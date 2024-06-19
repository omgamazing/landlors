import QtQuick

QtObject {
//牌型
    readonly property int single: 1//单
    readonly property int two: 2//对子
    readonly property int triple: 3//三张
    readonly property int tripleWithOne: 4//三带一
    readonly property int tripleWithTwo: 5//三带一对
    readonly property int planeWithTwoSingle: 7//飞机带两单
    readonly property int planeWithTwoDouble: 8//飞机带两队
    readonly property int straight: 9//顺子
    readonly property int straightWithDouble: 10//连对
    readonly property int bomb: 11//炸弹
    readonly property int jokers: 12//王炸
}

