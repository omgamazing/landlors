//牌类型的定义，或许类型大小的比较可以写里面(当然只是参考)

import QtQuick

QtObject {
//牌型
    readonly property string single: "single"//单
    readonly property string two: "two"//对子
    readonly property string tripleWithOne: "tripleWithOne"//三带一
    readonly property string tripleWithTwo: "tripleWithTwo"//三带一对
    readonly property string planeWithTwoSingle: "planeWithTwoSingle"//飞机带两单
    readonly property string planeWithTwoDouble: "planeWithTwoDouble"//飞机带两队
    readonly property string straight: "straight"//顺子
    readonly property string straightWithDouble: "straightWithDouble"//连对
    readonly property string bomb: "bomb"//炸弹
    readonly property string jokers: "jokers"//王炸
}
