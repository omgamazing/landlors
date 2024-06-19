#pragma once
#include <QCoreApplication>
#include <QDebug>
#include <QList>
#include <QString>
#include <algorithm>

enum CardType {
    Single,              // 单张牌
    Pair,                // 对子
    Triple,              // 三张
    TripleWithOne,       // 三带一
    TripleWithPair,      // 三带二
    Straight,            // 顺子
    SequencePair,        // 连对
    Airplane,            // 飞机（两个三张连）
    AirplaneWithSingle,  // 飞机带俩单
    AirplaneWithTwoPair, // 飞机带两对
    QuadrupleWithOne,    // 四带一
    QuadrupleWithTwo,    // 四带两对
    Bomb,                // 炸弹
    JokerBomb            // 王炸(火箭)
};
// 定义牌型结构体
struct CardNode
{
    CardType type; // 牌型
    int value;     // 牌型中关键牌的值
    int count;     // 牌型中牌的数量
};

class CardWeight
{
public:
    //识别牌的类型
    CardWeight();
    CardWeight(CardType cardType);

    CardType getCardType(); //获得牌型
    //识别牌型
    CardType identifyHandType(const QList<int>& values, const QList<int>& counts);
    // 计算单个牌型的权重
    int calculateCardWeight(const CardNode& node);

    bool isSingle();
    bool isPair();
    bool isTriple();
    bool isTripleWithOne();
    bool isTripleWithPair();
    bool isStraight();
    bool isSequencePair();
    bool isAirplane();
    bool isAirplaneWithSingle();
    bool isAirplaneWithTwoPair();
    bool isQuadrupleWithOne();
    bool isQuadrupleWithTwo();
    bool isBomb();
    bool isJokerBomb();
    bool areConsecutive(const QList<int>& values); //判断是否为顺子或连对

private:
};
