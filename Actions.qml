import QtQuick
import QtQuick.Controls

Item {

    property alias start:_start
    Action{
        id:_start
        icon.source: ":/images/start-1.png"
        //onTriggered:
        MouseArea{
            cursorShape: Qt.PointingHandCursor // 鼠标悬停时显示手形光标

        }


    }

}
