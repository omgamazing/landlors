#include "cardType.h"

card::card() {}
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
// 牌值枚举
enum CardValue {
    kCard_Value3 = 3,           // 3
    kCard_Value4 = 4,           // 4
    kCard_Value5 = 5,           // 5
    kCard_Value6 = 6,           // 6
    kCard_Value7 = 7,           // 7
    kCard_Value8 = 8,           // 8
    kCard_Value9 = 9,           // 9
    kCard_ValueT = 10,          // 10
    kCard_ValueJ = 11,          // J
    kCard_ValueQ = 12,          // Q
    kCard_ValueK = 13,          // K
    kCard_ValueA = 14,          // A
    kCard_Value2 = 15,          // 2
    kCard_ValueJokerSmall = 16, // 小王
    kCard_ValueJokerBig = 17,   // 大王

};
