import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
Item {

    property alias rplayer:_rplayer
    property alias me:_me
    property alias lplayer:_lplayer
    property alias notcallButton:_notcallButton
    property alias notcallButtonImage:_notcallButtonImage
    property alias notcall:_notcall
    property alias mecall:_mecall
    property alias startButton:_startButton
    property alias startButtonImage:_startButtonImage
    property alias centercard:_centercard
    property alias lcard:_lcard
    property alias rcard:_rcard
    property alias callButton:_callButton
    property alias callButtonImage:_callButtonImage
    property alias clockImage:_clockImage
    property int countdownSeconds: 30
    property int currentSecond: countdownSeconds
    property int digitWidth: 40  // 假设每个数字的宽度是40
    property int digitHeight: 42 // 假设每个数字的高度是42
    //中间卡牌
    Image{
        id:_centercard
        source: "qrc:/poker/rear.png"
        anchors.centerIn: parent
    }

    //左右卡牌
    Image{
        id:_lcard
        visible:false
        source: "qrc:/poker/rear.png"
        anchors.verticalCenter:parent.verticalCenter
        anchors.left: lplayer.right
    }
    Image{
        id:_rcard
        visible:false
        source: "qrc:/poker/rear.png"
        anchors.verticalCenter:parent.verticalCenter
        anchors.right: rplayer.left

    }

    //开始按钮
     ColumnLayout {
         anchors.top: centercard.bottom
         anchors.topMargin: 100
         anchors.horizontalCenter: centercard.horizontalCenter
    Button {
        id: _startButton
        visible: true
        background: Rectangle {
               Image {
                   id: _startButtonImage
                   source: "qrc:/images/start-1.png"
                   fillMode: Image.PreserveAspectFit
                   anchors.centerIn: parent
               }
           }
        onClicked: {
            startButton.visible = false;
            notcallButton.visible = !notcallButton.visible;
            callButton.visible = !callButton.visible;
            console.log("player starts game");
            displayclockTimer.start();
        }

        HoverHandler {
            acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
            cursorShape: Qt.PointingHandCursor

            onHoveredChanged: {
                if (hovered) {
                    startButtonImage.source = "qrc:/images/start-2.png"; // 悬停时的图片路径
                } else {
                    startButtonImage.source = "qrc:/images/start-1.png"; // 恢复默认图片
                }
            }
        }
    }
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
    //变地主
    //右侧机器人
    Image{
        id:_rlandlor
        visible:false
        source:"qrc:/images/people-1.png"
        mirror: true
        width:100
        height:140
        anchors.right: parent.right
        y:(parent.height-height)/2.3

    }
    //自己
    Image{
        id:_melandlor
        visible:false
        source:"qrc:/images/people-1.png"
        width:100
        height:140
        x:100
        y:450

    }
    //玩家不叫地主

     RowLayout {
         x:395
         y: 470
          spacing: 200
         Button{
        visible:false
        id:_notcallButton
        background: Rectangle {
               Image {
                   id: _notcallButtonImage
                   source: "qrc:/images/bujiao1.png"
                   fillMode: Image.PreserveAspectFit
                   anchors.centerIn: parent
               }
           }
            onClicked:{
                notcallButton.visible=false
                _callButton.visible=false
                notcall.visible=!notcall.visible
                console.log("player notcall")
                //设置不抢和农民形象消失，地主形象出现
                if (notcall.visible) {
                                   hideTimer.start();
                               } else {
                                   hideTimer.stop();
            }
        }
            HoverHandler{
                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                cursorShape: Qt.PointingHandCursor
                onHoveredChanged: {
                            if (hovered) {
                                _notcallButtonImage.source="qrc:/images/bujiao2.png"; // 悬停时的图片路径
                            } else {
                                 _notcallButtonImage.source="qrc:/images/bujiao1.png"; // 恢复默认图片
                            }
                        }
            }
    }
             //玩家叫地主
         Button{
           visible:false
           id:_callButton
           background: Rectangle {
                  Image {
                      id: _callButtonImage
                      source: "qrc:/images/jiaodizhu1.png"
                      fillMode: Image.PreserveAspectFit
                      anchors.centerIn: parent
                  }
              }
               onClicked:{
                            callButton.visible=false
                            notcallButton.visible=false
                            mecall.visible=!mecall.visible
                            console.log("player call")
                            //设置叫地主和农民形象消失，地主形象出现

                            if (mecall.visible) {
                                               mehideTimer.start();
                                           } else {
                                               mehideTimer.stop();
           }
       }
               HoverHandler{
                   acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                   cursorShape: Qt.PointingHandCursor
                   onHoveredChanged: {
                               if (hovered) {
                                   callButtonImage.source="qrc:/images/jiaodizhu2.png"; // 悬停时的图片路径
                               } else {
                                   callButtonImage.source="qrc:/images/jiaodizhu1.png"; // 恢复默认图片
                               }
                           }
               }
           }
     }

    //不抢动画
    Image{
        visible:false
        id:_notcall
        source: "qrc:/images/buqiang.png"
        anchors.top:centercard.bottom
        anchors.topMargin:10
        anchors.horizontalCenter: centercard.horizontalCenter
    }
    //叫地主动画
    Image{
        visible:false
        id:_rcall
        source: "qrc:/images/jiaodizhu.png"
        anchors.right:rcard.left
        anchors.rightMargin:40
       anchors.verticalCenter:parent.verticalCenter
    }


    //不抢消失定时器
    Timer {
            id: hideTimer
            interval: 1000 // 1秒后触发
            repeat: false // 只触发一次
            onTriggered: {
                notcall.visible = false; // 定时器触发后隐藏图片按钮
                 // 定时器触发后显示图片
                _rcall.visible = true;
                 hidecallTimer.start();
            }

        }
    Timer {
            id: hidecallTimer
            interval: 2000 // 2秒后触发
            repeat: false // 只触发一次
            onTriggered: {
                _rcall.visible = false; // 定时器触发后隐藏图片按钮
                rplayer.visible = false;
                _rlandlor.visible = true;// 定时器触发后显示图片
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
    //叫地主定时器

    Timer {
        id: displayclockTimer
        interval: 5000 // 设置为5000毫秒，即5秒
        repeat: false // 只触发一次
        onTriggered: {
            _clockImage.visible = true // 定时器触发后设置图片可见
        }
    }
    Timer {
            id: mehideTimer
            interval: 1000 // 1秒后触发
            repeat: false // 只触发一次
            onTriggered: {
                mecall.visible = false; // 定时器触发后隐藏图片按钮
                  me.visible = false;
                 // 定时器触发后显示图片
                 _melandlor.visible = true;
            }

        }
    //玩家叫不叫地主无反应倒计时
    Timer {
            id:_clock
            interval: 1000 // 每秒触发一次
            running: true
            repeat: true
            onTriggered: {
                if (currentSecond > 0) {
                    currentSecond--;
                } else {
                    _clock.running = false; // 计时器停止
                    // 在此处触发闹钟倒计时结束的信号或其他处理
                }
            }
        }

        Image {
            id:_clockImage
            source: "qrc:/images/clock.png"
            width:70
            height:70
            anchors.top:centercard.bottom
            anchors.topMargin:50
            anchors.horizontalCenter: centercard.horizontalCenter
            visible: false
            onSourceChanged: {
                // 确保在图片加载后更新显示区域
                updateDisplay();
            }

            function updateDisplay() {
                if (clockImage.status === Image.Ready) {
                    var digitX = 10; // 假设数字显示区域在图片中的位置和尺寸
                    var digitY = 15;
                    clockImage.sourceRect = Qt.rect((currentSecond % 10) * digitWidth + digitX, digitY, digitWidth, digitHeight);
                }
            }
        }

}

