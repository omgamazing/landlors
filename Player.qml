//需要修改的地方：可以考虑将控件加入另一个qml中，也可以先放到window,后续再分离
//此qml实现：定义玩家状态：是否为地主、是否轮到玩家出牌、是否能出牌(轮到玩家出牌后，出不出得起)

import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
Item {
    property alias notcall:_notcall
    property alias mecall:_mecall
    property alias lcard:_lcard
    property alias rcard:_rcard
    property alias clockImage:_clockImage
    property int countdownSeconds: 30
    property int currentSecond: countdownSeconds
    property int digitWidth: 40  // 假设每个数字的宽度是40
    property int digitHeight: 42 // 假设每个数字的高度是42
    //中间卡牌
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




    //叫地主动画
    Image{
        visible:false
        id:_mecall
        source: "qrc:/images/jiaodizhu.png"
        anchors.top:centercard.bottom
        anchors.topMargin:10
        anchors.horizontalCenter: centercard.horizontalCenter
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

