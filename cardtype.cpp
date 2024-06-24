//牌型算法：列举所有牌型，判断牌型、设计权值、设计拆牌算法、判断当前卡牌是否能打出
#include <algorithm>
#include <iostream>
#include <map>
#include <string>
#include <vector>

//定义牌
class Card
{
public:
    Card(int p, int s)
        : point(p)
        , suit(s)
    {}
    int getPoint() const { return point; }
    //获取花色
    int getSuit() const { return suit; } //5:大小王

private:
    int point;        //牌面 3-10:3-10 J:11 Q:12 K:13 SJ:14 BJ:15
    int suit;         //花色 1 2 3 4 5:大小王
                      //获取点数
};
//卡牌单张牌的数量
class CardIndex
{
public:
    std::vector<int> a[4];
};

class CardType
{
    enum CardTypes {
        Single, //单
        Pair,   //对子

        Triple,           //三
        TripleWithSingle, //三带一
        TripleWithPair,   //三带一对

        Plane,              //飞机
        PlaneWithTwoSingle, //飞机带两单/一对
        PlaneWithTwoPair,   //飞机带两队

        Straight,         //顺子
        StraightWithPair, //连对

        Bomb,            //炸弹
        BombWithTow,     //炸弹带一对或两单
        BombWithTwoPair, //炸弹带两对

        Jokers, //王炸

        Unknown, //未知 14
        Pass     //过
    };

public:
    //判断牌型
    static CardTypes judgeType(std::vector<Card> &list)
    {
        int len = list.size();
        //排序
        order(list);
        //牌的张数小于等于4：单牌、对子、三不带、三带一、炸弹、王炸
        if (len <= 4) {
            if (len > 0 && list[0].getPoint() == list[len - 1].getPoint()) {
                switch (len) {
                case 1:
                    return Single; //单张牌
                case 2:
                    return Pair; //对子
                case 3:
                    return Triple; //三不带
                case 4:
                    return Bomb; //炸弹
                }
            }
            if (len == 2 && list[0].getPoint() == 16 && list[1].getPoint() == 17) //王炸
                return Jokers;
            if (len == 4
                && (list[0].getPoint() == list[2].getPoint()
                    || list[1].getPoint() == list[3].getPoint())) //三带一
            {
                return TripleWithSingle;
            }
        }
        //牌的张数大于4：三带一对、飞机、飞机带两单、飞机带两对、顺子、连对、炸弹带两对、炸弹带一对/带两单
        if (len > 4) {
            //按照牌出现的相同次数来比较  获取牌的最大值，用最大值比较
            CardIndex card_index;
            for (int i = 0; i < 4; i++) {
                card_index.a[i] = std::vector<int>(); //a[0,1,2,3]分别表示重复1,2,3,4次的牌

                getMax(card_index, list); //获取当前组合的最大值
                if (card_index.a[2].size() == 1 && card_index.a[1].size() == 1 && len == 5)
                    return TripleWithPair; //三带二
                //4带2(单,双)
                if (card_index.a[3].size() == 1 && len == 6)
                    return BombWithTow;
                //4带2对
                if (card_index.a[3].size() == 1 && card_index.a[1].size() == 2 && len == 8)
                    return BombWithTwoPair;
                //顺子 保证没有王 小王point：16
                if ((list[len - 1].getPoint() != 16) && (card_index.a[0].size() == len)
                    && (list[0].getPoint() - list[len - 1].getPoint() == len - 1))
                    return Straight;
                //连对
                if (card_index.a[1].size() == len / 2 && len % 2 == 0 && len / 2 >= 3
                    && ((list[0].getPoint() - list[len - 1].getPoint() == len / 2 - 1)))
                    return StraightWithPair;
                //飞机
                if (card_index.a[2].size() == len / 3 && (len % 3 == 0)
                    && ((list[0].getPoint() - list[len - 1].getPoint() == len / 3 - 1)))
                    return Plane;
                //飞机带单
                if (card_index.a[2].size() == len / 4
                    && (card_index.a[2][len / 4 - 1] - card_index.a[2][0] == len / 4 - 1))
                    return PlaneWithTwoSingle;
                //飞机带n双
                if (card_index.a[2].size() == len / 5
                    && (card_index.a[2][len / 5 - 1] - card_index.a[2][0] == len / 5 - 1))
                    return PlaneWithTwoPair;
            }
        }
        return Unknown;
    }
    //排序
    static void order(std::vector<Card> &list)
    {
        std::sort(list.begin(), list.end(), cardComparator);
    }
    //比较卡片
    static bool cardComparator(const Card &c1, const Card &c2)
    {
        int b1 = c1.getPoint();
        int b2 = c2.getPoint();
        if (b1 == 16) //小王
            b1 += 100;
        if (b1 == 17) //大王
            b1 += 150;
        if (b2 == 16) //小王
            b2 += 100;
        if (b2 == 17) //大王
            b2 += 150;

        if (b1 == 14) //A
            b1 += 20;
        if (b1 == 15) //2
            b1 += 30;
        if (b2 == 14)
            b2 += 20;
        if (b2 == 15)
            b2 += 30;

        int flag = b2 - b1;
        if (flag == 0) {
            return c1.getSuit() > c2.getSuit();
        } else {
            return flag > 0;
        }
    }
    //当取当前牌型的最大值
    static void getMax(CardIndex &card_index, const std::vector<Card> &list)
    {
        std::map<int, int> frequencyMap;
        for (const auto &card : list) {
            frequencyMap[card.getPoint() - 3]++; //牌的牌值都是从3开始
        }
        for (const auto &entry : frequencyMap) {
            int count = entry.second; //花色
            int value = entry.first;  //牌面 -3之后的点数
            if (count >= 1 && count <= 4) {
                card_index.a[count - 1].push_back(value);
            }
        }
    }

private:
};
//测试
int main()
{
    // 示例卡片列表
    //std::vector<Card> cards = {Card(3, 1), Card(15, 2), Card(8, 4), Card(13, 3), Card(6, 2)};//Unkwno
    //std::vector<Card> cards = {Card(16, 5), Card(17, 5)}; //王炸
    //std::vector<Card> cards = {Card(3, 1), Card(3, 2), Card(3, 4), Card(13, 3)}; //三带一
    //std::vector<Card> cards = {Card(3, 1), Card(3, 2)}; //对子
    //std::vector<Card> cards= {Card(3, 1), Card(3, 2), Card(3, 3), Card(4, 1), Card(4, 3), Card(4, 2)}; //飞机不带 未检测到
    //std::vector<Card> cards = {Card(3, 1), Card(3, 2), Card(3, 3), Card(3, 4)}; //炸弹
    //std::vector<Card> cards= {Card(3, 1), Card(3, 2), Card(3, 3), Card(3, 4), Card(6, 3), Card(6, 4)}; //炸弹带一对
    //std::vector<Card> cards = {Card(3, 1),Card(3, 2),Card(3, 3),Card(4, 1),Card(4, 3),Card(4, 2), Card(7, 3),Card(9, 2)}; //飞机带两单
    //std::vector<Card> cards = {Card(7, 4),Card(9, 3),Card(3, 1),Card(3, 2), Card(3, 3),Card(4, 1),Card(4, 3),Card(4, 2),Card(7, 3),Card(9, 2)}; //飞机带两对 未检测到
    //std::vector<Card> cards= {Card(7, 1), Card(6, 2), Card(5, 3), Card(4, 1), Card(3, 3), Card(8, 2)}; //顺子 为检测到
    std::vector<Card> cards
        = {Card(7, 1), Card(7, 2), Card(5, 3), Card(5, 1), Card(6, 3), Card(6, 2)}; //连对 为检测到
    // 排序前输出
    std::cout << "Before sorting:" << std::endl;
    for (const auto &card : cards) {
        std::cout << card.getPoint() << "-" << card.getSuit() << " ";
    }
    std::cout << std::endl;

    // 排序
    CardType::order(cards);

    // 排序后输出
    std::cout << "After sorting:" << std::endl;
    for (const auto &card : cards) {
        std::cout << card.getPoint() << "-" << card.getSuit() << " ";
    }
    std::cout << std::endl;

    int typ = CardType::judgeType(cards);
    if (typ == 0)
        std::cout << "单牌" << std::endl;
    if (typ == 1)
        std::cout << "对子" << std::endl;
    if (typ == 2)
        std::cout << "三不带" << std::endl;
    if (typ == 3)
        std::cout << "三带一" << std::endl;
    if (typ == 4)
        std::cout << "三带一对" << std::endl;
    if (typ == 5)
        std::cout << "飞机不带" << std::endl;
    if (typ == 6)
        std::cout << "飞机带两单/一对" << std::endl;
    if (typ == 7)
        std::cout << "飞机带两对" << std::endl;
    if (typ == 8)
        std::cout << "顺子" << std::endl;
    if (typ == 9)
        std::cout << "连对" << std::endl;
    if (typ == 10)
        std::cout << "炸弹" << std::endl;
    if (typ == 11)
        std::cout << "炸弹带一对/两单" << std::endl;
    if (typ == 12)
        std::cout << "炸弹带两对" << std::endl;
    if (typ == 13)
        std::cout << "王炸" << std::endl;
    if (typ == 14)
        std::cout << "未定义" << std::endl;
    return 0;
}
