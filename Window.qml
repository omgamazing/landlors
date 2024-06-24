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
    property alias call:_call
    property alias lplayer:_lplayer
    property alias centercard:_centercard
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
         mirror:true
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
         width:100
         height:140
         x:100
         y:450

     }


     Image{
         id:_landlor
         visible:false
         source:"qrc:/images/people-1.png"
         width:100
         height:140
         //x:100
         //y:450

     }

     //开始按钮
     ColumnLayout {
         anchors.horizontalCenter: centercard.horizontalCenter
         y: 420

         Image{             
             id: _startImage
             visible: true
             source:"qrc:/images/start-1.png"
             fillMode: Image.PreserveAspectFit

             TapHandler {
                 //cursorShape: Qt.PointingHandCursor
                 onTapped:Controller.start()
                 }


             HoverHandler{
                  cursorShape: Qt.PointingHandCursor
                  onHoveredChanged: {
                      _startImage.source = hovered ? "qrc:/images/start-3.png" : "qrc:/images/start-1.png"
                      }
                  }

         }
    }

     //按钮：叫与不叫
     RowLayout {
         x:320
         y: 420
         spacing: 120

         //不叫地主
         Image{
             //signal isclicked()
             id: _notcallButtonImage
             visible: false
             source:"qrc:/images/bujiao1.png"
             fillMode: Image.PreserveAspectFit

             TapHandler {
                 //cursorShape: Qt.PointingHandCursor
                 onTapped: Controller.notcall()
             }

             HoverHandler{
                  cursorShape: Qt.PointingHandCursor
                  onHoveredChanged: {
                      _notcallButtonImage.source = hovered ? "qrc:/images/bujiao2.png" : "qrc:/images/bujiao1.png"
                  }
             }
         }

         //叫地主按钮
         Image{
             signal isclicked()
             id: _callButtonImage
             visible: false
             source:"qrc:/images/jiaodizhu1.png"
             fillMode: Image.PreserveAspectFit
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

     //动画：叫地主
     Image{
         id:_call
         visible:false
         source: "qrc:/images/jiaodizhu.png"
         anchors.top:centercard.bottom
         anchors.topMargin:10
         anchors.horizontalCenter: centercard.horizontalCenter
     }

     //动画：不抢
     Image{
         visible:false
         id:_nocall
         source: "qrc:/images/buqiang.png"
         anchors.top:centercard.bottom
         anchors.topMargin:10
         anchors.horizontalCenter: centercard.horizontalCenter
     }

     Timer{
         id:hidecallTimer
         interval: 200
         repeat: false
         onTriggered: hide()
         }

     Timer{
         id: myhidecallTimer
         interval: 200
         running:false
         repeat: false
         onTriggered: myhide()
         }

     //设置叫地主和农民形象消失，地主形象出现
     function hide(){
         _nocall.visible=false;
         //_rplayer.source="qrc:/images/people-1.png"
         _rplayer.visible=false
         _landlor.visible=true
         _landlor.mirror=true
         _landlor.x=_rplayer.x
         _landlor.y=_rplayer.y

     }

     function myhide(){
         _call.visible=false;
        // _me.source="qrc:/images/people-1.png"
         _me.visible=false
         _landlor.visible=true
         _landlor.mirror=false
         _landlor.x=_me.x
         _landlor.y=_me.y
     }

     Actions{
         id:actions
         start.onTriggered:Controller.start()
         call.onTriggered: Controller.call()
         notcall.onTriggered: Controller.notcall()
         about.onTriggered: content.dialogs.about.open()
     }

     Content{
         id:_content
     }

    property int count_me:0
    property int count_left:0
    property int count_right:0
    //分数显示栏
    ColumnLayout{
            id:score
            width:100
            height:100
            x:780
            y:20

            spacing:-10

            Text{text:"    我\t"+count_me+"分";font.pointSize: 16;color:"white"}
            Text{text:"左侧机器人 "+count_left+"分";font.pointSize: 16;color:"white"}
            Text{text:"右侧机器人 "+count_right+"分";font.pointSize: 16;color:"white"}
    }


    RowLayout {
            id: myDecks_location
            visible:false
            x: 350
            y: 480
            spacing: -56 // 每张牌之间的间距


            Repeater {
                model: 15 // 假设有5张牌
                delegate: Image {
                    source: "qrc:/poker/1-4.png"
                    y:0

                    TapHandler {
                        onTapped: {
                            parent.y=(parent.y===0?-15:0)
                        }

                    }


                }
            }
    }





    RowLayout {
            id: landlorsDecks_location
            visible: false
            x: 380
            y: 30
            spacing:8// 每张牌之间的间距

            Repeater {
                model: 3 // 假设有5张牌
                delegate: Image {
                    source: "qrc:/poker/1-4.png"
                }
            }
        }


}
