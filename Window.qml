//用户与窗口的交互界面，通过点击菜单选项或者按钮，发送信号到控制器

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "game.js" as Controller

ApplicationWindow {
    id:window

    visible: true
    width:1000
    height:650
    minimumWidth: 1000
    minimumHeight: 650
    maximumWidth: 1000
    maximumHeight: 650

    title: qsTr("斗地主")

    property alias back:_back
    property alias content:_content



    menuBar: MenuBar{
      Menu {
            title: qsTr("File")
            MenuItem {action:actions.start}
            MenuItem {action:actions.quit}
            MenuItem {action:actions.about}
        }

    }

    //游戏背景
    background: Image {
        id:_back
        source: "qrc:/images/background-2.png" //URL路径
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
    }

    Actions{
        id:actions
        start.onTriggered:Controller.start()
        about.onTriggered: content.dialogs.about.open()
    }

    Content{
        id:_content
    }

    //卡牌从一个点移动到另一个点 移动效果的函数,用于发牌
    /*Item {
        property alias card: cardItem // 将内部的Card对象暴露给外部访问

        Rectangle {
            id: cardItem
            width: 50
            height: 80
            color: "red" // 红色矩形，模拟卡牌
            //rePosition();

            function createCard(x, y) {
                            var cardItem = Qt.createQmlObject('import QtQuick 2.15; Rectangle { \
                                                                    width: 50; \
                                                                    height: 80; \
                                                                    color: "red"; \
                                                                }', cardContainer, "dynamicCard");
                            cardItem.x = x;
                            cardItem.y = y;
                            return cardItem;
                        }
            function move(from, to, duration) {
                var animation = Qt.createQmlObject('import QtQuick 2.0; SequentialAnimation { \
                                PropertyAnimation { target: cardItem; property: "x"; from: ' + from.x + '; to: ' + to.x + '; duration: ' + duration + ' } \
                                PropertyAnimation { target: cardItem; property: "y"; from: ' + from.y + '; to: ' + to.y + '; duration: ' + duration + ' } \
                            }', cardItem, "dynamicAnimation");

                animation.start();
            }

            function rePosition(container, cardList, flag) {
                var p = { x: 0, y: 0 };
                var spacingX = 21;
                var spacingY = 15;

                if (flag === 0) {
                    p.x = 50;
                    p.y = (450 / 2) - (cardList.length + 1) * spacingY / 2;
                } else if (flag === 1) {
                    p.x = (800 / 2) - (cardList.length + 1) * spacingX / 2;
                    p.y = 450;
                } else if (flag === 2) {
                    p.x = 700;
                    p.y = (450 / 2) - (cardList.length + 1) * spacingY / 2;
                }

                for (var i = 0; i < cardList.length; i++) {
                    var card = cardList[i];
                    move(card, { x: card.x, y: card.y }, p, 10);
                    container.setZ(i, card);
                    if (flag === 1) {
                        p.x += spacingX;
                    } else {
                        p.y += spacingY;
                    }
                }
            }
        }
    }*/

}
