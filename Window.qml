//用户与窗口的交互界面，通过点击菜单选项或者按钮，发送信号到控制器

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "game.js" as Controller
import "card.js" as Card

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




}
