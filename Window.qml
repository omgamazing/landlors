import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {


    visible: true
    width:1000
    height:650
    minimumWidth: 1000
    minimumHeight: 650
    maximumWidth: 1000
    maximumHeight: 650

    title: qsTr("斗地主")

    property alias back:_back
    property alias centercard:_centercard
    property alias start:_start

    //游戏背景
    background: Image {
        id:_back
        source: "qrc:/images/background-2.png" //URL路径
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
    }

    //分数显示栏
    ColumnLayout{
            width:100
            height:100
            anchors.right:parent.right
            anchors.rightMargin: 10
            Rectangle{width:100; height:10;color: "red"}
            Rectangle{width:100; height:10;color: "red"}
            Rectangle{width:100; height:10;color: "red"}


    }

    //中间卡牌
    Image{
        id:_centercard
        source: "qrc:/poker/rear.png"
        anchors.centerIn: parent

    }

    //开始按钮
    Image{
        id:_start
        source: "qrc:/images/start-1.png"
        anchors.top:centercard.bottom
        anchors.topMargin:100
        anchors.horizontalCenter: centercard.horizontalCenter

        // 添加动画

        MouseArea{
            anchors.fill: parent
            onClicked:_centercard.scale=2

        }


    }
}
