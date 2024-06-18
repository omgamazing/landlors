#include "cardNode.h"
CardNode::CardNode()
{
    resetNode(); //将所有成员变量重置为其默认值
}
CardNode::CardNode(int type, int val, int mainN, int len, int sub)
    : cardType(type)
    , value(val)
    , mainNum(mainN)
    , seralNum(len)
    , subNum(sub)
    , aggregate(0.0f)
{
    cards.clear();
}

CardNode::CardNode(const CardNode &other)
    : cardType(other.cardType)
    , value(other.value)
    , mainNum(other.mainNum)
    , seralNum(other.seralNum)
    , subNum(other.subNum)
    , aggregate(other.aggregate)
    , cards(other.cards)
{}

CardNode &CardNode::operator=(const CardNode &other)
{
    cardType = other.cardType;
    mainNum = other.mainNum;
    value = other.value;
    seralNum = other.seralNum;
    subNum = other.subNum;
    aggregate = other.aggregate;
    cards = other.cards;
    return *this;
}
void CardNode::setCards(const std::vector<int> &newCards)
{
    cards = newCards;
}

std::vector<int> CardNode::getCards() const
{
    return cards;
}
//当前的 CardNode 对象是否表示一种有效的牌型
bool CardNode::isValidNode() const
{
    return mainNum != 0;
}

//重置函数：将 CardNode 对象重置为初始状态，清空所有数据||重新开始游戏
void CardNode::resetNode()
{
    cardType = kCardType_Invalid;
    cardType = 0;
    value = 0;
    mainNum = 0;
    seralNum = 0;
    subNum = 0;
    aggregate = 0.0f;
    cards.clear();
}
//生成描述扑克牌的字符串
std::string CardNode::description() const
{
    std::vector<std::string> cardDescs;
    cardDescs.reserve(cards.size());

    for (int card : cards) {
        std::string suit;
        std::string value;
        // 根据花色和点数生成描述字符串
        if (card >= 1 && card <= 13) { // 黑桃
            suit = "1";
            value = std::to_string((card - 1) % 13 + 1);
        } else if (card >= 14 && card <= 26) { // 红桃
            suit = "2";
            value = std::to_string((card - 1) % 13 + 1);
        } else if (card >= 27 && card <= 39) { // 黑梅花
            suit = "3";
            value = std::to_string((card - 1) % 13 + 1);
        } else if (card >= 40 && card <= 52) { // 红方块
            suit = "4";
            value = std::to_string((card - 1) % 13 + 1);
        } else if (card == 53) { // 小王
            suit = "5";
            value = "1";
        } else if (card == 54) { // 大王
            suit = "5";
            value = "2";
        } else {
            continue;
        }

        cardDescs.push_back(
            suit + "-" + value
            + ".png"); // 将花色和点数字符串拼接成一个完整的牌描述字符串，并添加到 cardDescs 向量中。
    }
    return join(cardDescs, " ");
}
//字符串向量中的元素用指定的分隔符连接成一个单一的字符串
std::string CardNode::join(const std::vector<std::string> &vec, const std::string &delimiter)
{
    std::ostringstream oss;
    for (size_t i = 0; i < vec.size(); ++i) {
        if (i != 0) {
            oss << delimiter;
        }
        oss << vec[i];
    }
    return oss.str();
}
//获取最大一张牌的值,牌型的不同返回最大一张牌的值
int CardNode::getTopValue() const
{
    int top = value;
    //顺子 或 连对 或飞机
    if (cardType == kCardType_Serial) {
        //牌的起始值+连续长度-1
        top = value + seralNum - 1;
    }
    return top;
}

//把大小王放到牌中
void CardNode::fillJokers()
{
    cards.clear();

    //cardtype中kCardType_Rocket火箭
    if (cardType == kCardType_Rocket) {
        cards.push_back(kCard_Joker1);
        cards.push_back(kCard_Joker2);
    } else {
        assert(false);
    }
}
//是否火箭
bool CardNode::isRocket() const
{
    return cardType == kCardType_Rocket;
}

//是否炸弹
bool CardNode::isBomb() const
{
    return cardType == kCardType_Bomb;
}

// 比较是否比同一个牌型other小
bool CardNode::isExactLessThan(const CardNode &other) const
{
    if (!isValidNode()) {
        return true;
    }
    return (cardType == other.cardType && mainNum == other.mainNum && subNum == other.subNum
            && seralNum == other.seralNum && getTopValue() < other.getTopValue());
}

// 比较炸弹是否比other小
bool CardNode::isStrictLessThan(const CardNode &other) const
{
    if (!isValidNode())
        return true;

    if (isRocket()) { //自己是火箭最大
        return false;
    }
    if (other.isRocket()) { //它是火箭，肯定比它小
        return true;
    }
    if (isBomb() && other.isBomb()) {
        return getTopValue() < other.getTopValue();
    } else if (isBomb()) {
        return false;
    } else if (other.isBomb()) {
        return true;
    }

    return isExactLessThan(other);
}

//合并两个型中的牌
void CardNode::merge(const CardNode &other)
{
    mergeTwoVectors(cards, other.cards);
}

//算权重的参数，计算出单个牌型的权重
float CardNode::calculateWeight(float baseWeight, float top, int seralNum, int subNum) const
{
    float weight = baseWeight;
    weight -= (top * VALUE_DECREASE_FACTOR);      // 减去值减少因子
    weight += (seralNum * SERIAL_NUM_MULTIPLIER); // 加上序列号乘数
    weight -= (subNum * SUB_NUM_PENALTY);         // 减去次要数量惩罚
    return weight;
}
// 计算当前牌型的权重
//会返回每个节点的权重。对于某些大牌，权重为正，剩下的牌型，越厌恶的权重越小
float CardNode::getPower() const
{
    float weight = 0.0f;

    //如果value：3 seralnum：1 subnum：0 mainnum：2
    //top = (3 + 3 + 1) / 2 = 3.5
    //weight = 0.437f - (3.5 * 0.02f) + (1 * 0.02f) - 0 = 0.437f - 0.07f + 0.02f = 0.387f
    //finalPower = -150 + (-100 * 0.387) = -150 - 38.7 = -188.7
    //牌型为火箭
    if (cardType == kCardType_Rocket) {
        weight = ROCKET_WEIGHT;
    } else {
        float top = (value + value + seralNum) / 2.0f;
        std::cout << "Top value: " << top << std::endl; //测试权重
        switch (mainNum) {
        case 4:
            if (subNum) //四张带了牌，权重变低
            {
                weight = calculateWeight(BOMB_BASE_WEIGHT, top, seralNum, subNum);
            } else if (value == kCard_Value2) //四张2
            {
                weight = BOMB_NO_SUB_WEIGHT;
            } else //其它的四张
            {
                weight = calculateWeight(OTHER_BOMB_WEIGHT, top, seralNum, 0);
            }
            break;
        case 3: //三张
            weight = calculateWeight(TRIPLE_BASE_WEIGHT, top, seralNum, subNum);
            break;
        case 2: //对子
            weight = calculateWeight(PAIR_BASE_WEIGHT, top, seralNum, 0);
            break;
        default: // 单牌
            weight = calculateWeight(SINGLE_BASE_WEIGHT, top, seralNum, 0);
            break;
        }
    }
    //std::cout << "Weight: " << weight << std::endl;
    float finalPower = kOneHandPower + kPowerUnit * weight;
    //std::cout << "Final power: " << finalPower << std::endl;
    // 计算最终的权重
    //如果最终权重低于 kMinPowerValue，则返回 kMinPowerValue
    return finalPower > kMinPowerValue ? finalPower : kMinPowerValue;
}

//比较牌是否比Other小
bool CardNode::operator<(const CardNode &other) const
{
    if (isRocket())
        return !other.isRocket();
    if (other.isRocket())
        return false;

    if (mainNum != other.mainNum)
        return mainNum > other.mainNum;
    if (value != other.value)
        return value < other.value;
    if (cardType != other.cardType)
        return cardType < other.cardType;
    if (seralNum != other.seralNum)
        return seralNum < other.seralNum;
    if (cards.size() != other.cards.size())
        return cards.size() < other.cards.size();

    return std::lexicographical_compare(cards.begin(),
                                        cards.end(),
                                        other.cards.begin(),
                                        other.cards.end());
}
//比较牌是否和Other相等
bool CardNode::isEqualTo(const CardNode &other) const
{
    if (isRocket() && other.isRocket()) {
        return true;
    }
    if (mainNum == other.mainNum && value == other.value && seralNum == other.seralNum
        && subNum == other.subNum) {
        return cards == other.cards;
    } else {
        return false;
    }
}
