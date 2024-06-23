//用户与窗口的交互界面，通过点击菜单选项或者按钮，发送信号到控制器

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "game.js" as Controller

ApplicationWindow {
    id:window

    /*visible: true
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
    property alias mecall:_mecall
    property alias melandlor:_melandlor
    property alias lplayer:_lplayer
    property alias centercard:_centercard

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
 Image{
     id:_melandlor
     visible:false
     source:"qrc:/images/people-1.png"
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
     Image{
         property alias startbutton:startButtonArea
         id: _startImage
         visible: true
        source:"qrc:/images/start-1.png"
        fillMode: Image.PreserveAspectFit
     Rectangle {
         id: startButtonArea
         color: "transparent"
         width: _startImage.width // 按钮宽度
         height: _startImage.height // 按钮高度
          anchors.fill: parent
         TapHandler {
             cursorShape: Qt.PointingHandCursor
             onTapped:
                Controller.start()
             }

         }
         HoverHandler{
              cursorShape: Qt.PointingHandCursor
              onHoveredChanged: {
    _startImage.source = hovered ? "qrc:/images/start-2.png" : "qrc:/images/start-1.png"
                              }
         }
 }
}

 RowLayout {
     x:320
     y: 420
      spacing: 120
      //不叫地主
     Image{
         property alias notcallbutton:notcallButtonArea
         signal isclicked()
         id: _notcallButtonImage
         visible: false
        source:"qrc:/images/bujiao1.png"
        fillMode: Image.PreserveAspectFit
     Rectangle {
         id: notcallButtonArea
         color: "transparent"
         width: _notcallButtonImage.width // 按钮宽度
         height: _notcallButtonImage.height // 按钮高度
          anchors.fill: parent
         TapHandler {
             cursorShape: Qt.PointingHandCursor
             onTapped: {
                 Controller.notcall()
             }
         }
     }
     HoverHandler{
          cursorShape: Qt.PointingHandCursor
          onHoveredChanged: {
        _notcallButtonImage.source = hovered ? "qrc:/images/bujiao2.png" : "qrc:/images/bujiao1.png"
                          }
     }
     }
     //玩家叫地主
 Image{
     property alias callbutton:callButtonArea
     signal isclicked()
     id: _callButtonImage
     visible: false
    source:"qrc:/images/jiaodizhu1.png"
    fillMode: Image.PreserveAspectFit
 Rectangle {
     id: callButtonArea
     color: "transparent"
     width: _callButtonImage.width // 按钮宽度
     height: _callButtonImage.height // 按钮高度
      anchors.fill: parent
     TapHandler {
         cursorShape: Qt.PointingHandCursor
         onTapped: {
             Controller.call()
         }

     }
     HoverHandler{
          cursorShape: Qt.PointingHandCursor
          onHoveredChanged: {
   _callButtonImage.source = hovered ? "qrc:/images/jiaodizhu2.png" : "qrc:/images/jiaodizhu1.png"
                          }
     }
 }
 }
 }
 //叫地主动画
 Image{
     visible:false
     id:_mecall
     source: "qrc:/images/jiaodizhu.png"
     anchors.top:centercard.bottom
     anchors.topMargin:10
     anchors.horizontalCenter: centercard.horizontalCenter
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
 //设置叫地主和农民形象消失，地主形象出现
 function myhide(){
             // 定时器触发后隐藏图片按钮
            _mecall.visible=false;
             _me.visible = false;
             _melandlor.visible = true;// 定时器触发后显示图片
         }

Actions{
    id:actions
    start.onTriggered:Controller.start()
    call.onTriggered: Controller.call()
    notcall.onTriggered: Controller.notcall()
    about.onTriggered: content.dialogs.about.open()
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
    }*/


}
