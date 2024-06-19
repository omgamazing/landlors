#include "cardWeight.h"
//判断是否为顺子或连对
bool areConsecutive(const QList<int>& values)
{
    if (values.size() < 2)
        return true;

    QList<int> sortedValues = values;
    std::sort(sortedValues.begin(), sortedValues.end());

    for (int i = 1; i < sortedValues.size(); ++i) {
        if (sortedValues[i] != sortedValues[i - 1] + 1)
            return false;
    }

    return true;
}
bool CardWeight::isSingle()
{
    if ()
}
// 计算单个牌型的权重
int calculateCardWeight(const CardNode& node)
{
    int baseWeight = cardWeights[node.type]; // 获取对应牌型的基础权重

    // 根据牌值调整权重
    baseWeight -= node.value; // 牌值越小，权重越低

    // 根据手数调整权重
    baseWeight -= node.count * 5; // 每多一手数，权重再降低一定值

    return baseWeight;
}

//根据手牌的牌值列表和计数列表识别牌型
CardType identifyHandType(const QList<int>& values, const QList<int>& counts)
{
    int n = values.size();
    int maxCount = *std::max_element(counts.begin(), counts.end());

    //
    if (n == 2 && maxCount == 2 && values.contains(16) && values.contains(17)) {
        return JokerBomb;
    }

    //
    if (n == 1) //单张牌
        return Single;
    else if (n == 2 && maxCount == 2)
        return Pair; //对子
    else if (n == 3 && maxCount == 3)
        return Triple; //三张
    else if (n >= 5 && areConsecutive(values))
        return Straight; //顺子
    else if (n == 4 && maxCount == 3)
        return TripleWithOne; //三带一
    else if (n == 5 && maxCount == 3)
        return TripleWithPair; //三带二
    else if (n == 4 && maxCount == 4)
        return Bomb; //炸弹
    else if (n == 6 && maxCount == 4)
        return QuadrupleWithTwo; //四带二
    else if (n == 6 && maxCount == 3)
        return AirplaneWithTwoPair; //飞机带两队
    else if (n == 8 && maxCount == 3)
        return AirplaneWithSingle; //飞机带两张
    else if (n >= 6 && areConsecutive(values) && n % 2 == 0)
        return SequencePair; //连对
    else if (n >= 6 && maxCount == 3 && n % 3 == 0)
        return Airplane; //飞机
    else
        return Single;
}
