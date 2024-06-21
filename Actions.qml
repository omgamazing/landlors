//动作：游戏开始start，帮助文档help，关于我们(游戏介绍)about


import QtQuick
import QtQuick.Controls

Item {
    property alias start: _start
    property alias call: _call
    property alias notcall: _notcall
    Action{
        id:_start
        onTriggered:{
        startButton.clicked();
    }
}
    Action{
        id:_call
        onTriggered:{
        callButton.clicked();
    }
}
    Action{
        id:_notcall
        onTriggered:{
        notcallButton.clicked();
    }
}
}
