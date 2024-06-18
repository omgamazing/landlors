#include "cardtype.h"

card::card() {}
enum CardTypes {
    Error_Card,           //错误出牌
    Single_Card,          //单牌
    Double_Card,          //对子
    Three_Card,           //三张
    ThreeOne_Card,        //三带一
    ThreeTwo_Card,        //三带二
    Line_Card,            //顺子
    Double_Line_Card,     //连对
    Plane_Card,           //飞机（两个三张连）
    Plane_TwoSingle_Card, //飞机带俩单
    Plane_TwoDouble_Card, //飞机带两对
    Four_TwoSingle_Card,  //四带俩单
    Four_TwoDouble_Card,  //四带两对
    Bomb_Card,            //炸弹
    Rocket_Card           //王炸(火箭)
};
// 牌值枚举
enum CardValue {
    // 以下为牌的面值，从3开始
    kCard_ValueLeast = 2,   // 最小牌值（用于标识）
    kCard_Value3 = 3,       // 3
    kCard_Value4 = 4,       // 4
    kCard_Value5 = 5,       // 5
    kCard_Value6 = 6,       // 6
    kCard_Value7 = 7,       // 7
    kCard_Value8 = 8,       // 8
    kCard_Value9 = 9,       // 9
    kCard_ValueT = 10,      // 10
    kCard_ValueJ = 11,      // J
    kCard_ValueQ = 12,      // Q
    kCard_ValueK = 13,      // K
    kCard_ValueA = 14,      // A
    kCard_Value2 = 15,      // 2
    kCard_ValueJoker1 = 16, // 小王
    kCard_ValueJoker2 = 17, // 大王
    kCard_ValueMax = 18,    // 最大牌值

    kCard_TableMax = 20, // 牌桌上的最大牌数
    kCard_KindMax = 5,   // 最大种类数

    // 特殊牌值
    kCard_Joker1 = 53, // 小王（红色 Joker）
    kCard_Joker2 = 54, // 大王（黑色 Joker）
    kCard_Flower = 55, // 花牌（假设有花牌）

    // 牌值掩码
    kCardMask_CardValue = 0x00ff, // 牌的面值掩码
    kCardMask_AnyMatch = 0x0100,  // 任意配对掩码

    // 游戏中的常量
    kMaxCardNum = 56, // 最大牌数
    kMaxPlayers = 3,  // 玩家数量

    // 牌型定义
    kCardType_Single = 1, // 单牌类型，seriaNum == 1
    kCardType_Serial = 2, // 顺子类型（单顺、双顺、三顺(飞机)、四顺）
    kCardType_Rocket = 3, // 火箭（大小王）

    // 牌的角度
    kCardAngle = 130 // 牌的角度，两家的牌是倾斜的
};
