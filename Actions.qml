//动作：游戏开始start，帮助文档help，关于我们(游戏介绍)about

import QtQuick
import QtQuick.Controls

Item {
    property alias start: _start
    property alias quit: _quit
    property alias about: _about

    Action{
        id:_start
        text: qsTr("&Start...")

    }


    Action {
        id: _quit
        text: qsTr("&Quit")
        icon.name: "application-exit"
        shortcut: "Ctrl+q"
        onTriggered: Qt.quit();
    }

    Action {
        id: _about
        text: qsTr("&About")
        icon.name: "help-about"
    }

}
