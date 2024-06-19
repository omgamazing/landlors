#pragma once
#include <QCoreApplication>
#include <QDebug>
#include <QList>
#include <QString>
#include "cardType.h"
enum CardTypes {
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
// 定义牌型结构体
struct CardNode
{
    CardType type; // 牌型
    int value;     // 牌型中关键牌的值
    int count;     // 牌型中牌的数量
};
// 牌型的权重列表
const int cardWeights[] = {
    -210, //单牌
    -220, //对子
    -300, //三张
    -40,  //三带一  -250
    -250, //三带二  -260
    -260, //顺子 -40
    -100, //连对 -30
    -150, //飞机（两个三张连） -50
    -280, //飞机带俩单  -70
    -270, //飞机带两对  -60
    -60,  //四带俩单  -270
    -70,  //四带两对 -280
    -30,  //炸弹 -100
    -50   //王炸(火箭) -150
};
