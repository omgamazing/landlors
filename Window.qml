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
    property alias rplayer:_rplayer
    property alias me:_me
    property alias lplayer:_lplayer
    property alias centercard:_centercard
    property alias startButton:_startButton
     property alias notcallButton:_notcallButton
    property alias callButton:_callButton
    //游戏背景
    background: Image {
        id:_back
        source: "qrc:/images/background-2.png" //URL路径
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
    }
    Image{
        id:_centercard
        source: "qrc:/poker/rear.png"
        anchors.centerIn: parent
    }

    //左边玩家
 Image{
     id:_lplayer
     visible:true
     source:"qrc:/images/people-2.png"
     width:100
     height:140
     anchors.left: window.left
     y:(parent.height-height)/2.3
 }

 //右边玩家
 Image{
     id:_rplayer
     visible:true
     source:"qrc:/images/people-3.png"
     width:100
     height:140
     anchors.right: parent.right
     y:(parent.height-height)/2.3

 }

 //自己
 Image{
     id:_me
     visible:true
     source:"qrc:/images/people-3.png"
     mirror: true // 水平镜像翻转
     width:100
     height:140
     x:100
     y:450

 }
 //开始
 ColumnLayout {
     anchors.top: centercard.bottom
     anchors.topMargin: 100
     anchors.horizontalCenter: centercard.horizontalCenter
     Button {
         id: _startButton
         visible: true
         background: Rectangle {
                Image {
                     source: _startButton.hovered ? "qrc:/images/start-2.png" : "qrc:/images/start-1.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                }
            }
    action: actions.start
     }
}
 RowLayout {
     x:395
     y: 470
      spacing: 200
      //不叫地主
     Button{
    visible:false
    id:_notcallButton
    background: Rectangle {
           Image {
               source:_notcallButton.hover ? "qrc:/images/bujiao2.png":"qrc:/images/bujiao1.png"
               fillMode: Image.PreserveAspectFit
               anchors.centerIn: parent
           }
       }
    action:actions.notcall
     }
     //玩家叫地主
 Button{
   visible:false
   id:_callButton
   background: Rectangle {
          Image {
              source: _notcallButton.hover ?"qrc:/images/jiaodizhu2.png":"qrc:/images/jiaodizhu1.png"
              fillMode: Image.PreserveAspectFit
              anchors.centerIn: parent
          }
      }
   action:actions.call
   }
 }
 Timer {
         id: hidecallTimer
         interval: 1000
         repeat: false
         onTriggered: hide()
     }
 Timer {
         id: myhidecallTimer
         interval: 2000
         repeat: false
         onTriggered: myhide()
     }
Actions{
    id:actions
    start.onTriggered: Controller.start();
    call.onTriggered: Controller.call();
    notcall.onTriggered: Controller.notcall();

}

    property int count_me:0
    property int count_left:0
    property int count_right:0
    //分数显示栏
    ColumnLayout{
        id:score
            width:100
            height:100
            anchors.top:parent.top
            anchors.topMargin: 20
            anchors.right:parent.right
            anchors.rightMargin:100

            spacing:-10

            Text{text:"    我\t"+count_me+"分";font.pointSize: 16;color:"white"}
            Text{text:"左侧机器人 "+count_left+"分";font.pointSize: 16;color:"white"}
            Text{text:"右侧机器人 "+count_right+"分";font.pointSize: 16;color:"white"}
    }
}
