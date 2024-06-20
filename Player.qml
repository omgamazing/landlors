import QtQuick

Item {

    property alias rplayer:_rplayer
    property alias me:_me
    property alias lplayer:_lplayer
    property alias notcallButton:_notcallButton
    property alias notcall:_notcall
    property alias mecall:_mecall
    property alias startButton:_startButton
    property alias centercard:_centercard
    property alias lcard:_lcard
    property alias rcard:_rcard
    property alias callButton:_callButton
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
    Image{
        visible:true
        id:_startButton
        source: "qrc:/images/start-1.png"
        anchors.top:centercard.bottom
        anchors.topMargin:100
        anchors.horizontalCenter: centercard.horizontalCenter

        // 添加动画
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true // 启用鼠标悬停事件

            //鼠标悬停于开始按钮
            onEntered: {startButton.source="qrc:/images/start-2.png"}
            onClicked:{
                startButton.visible=false
                notcallButton.visible=!notcallButton.visible
                callButton.visible=!callButton.visible
            }
           // 鼠标离开时触发的信号处理函数
            onExited: {startButton.source="qrc:/images/start-1.png"}

            cursorShape: Qt.PointingHandCursor // 鼠标悬停时显示手形光标

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

    Image{
        visible:false
        id:_notcallButton
        source: "qrc:/images/bujiao1.png"
        anchors.right: startButton.left
        anchors.top:centercard.bottom
        anchors.topMargin:70
        // 添加动画
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true // 启用鼠标悬停事件

            //鼠标悬停于不抢按钮
            onEntered: {notcallButton.source="qrc:/images/bujiao2.png"}
            onClicked:{
                notcallButton.visible=false
                _callButton.visible=false
                notcall.visible=!notcall.visible
                //设置不抢和农民形象消失，地主形象出现

                if (notcall.visible) {
                                   hideTimer.start();
                               } else {
                                   hideTimer.stop();
            }
        }
             // 鼠标离开时触发的信号处理函数
            onExited:{notcallButton.source="qrc:/images/bujiao1.png"}

            cursorShape:Qt.PointingHandCursor // 鼠标悬停时显示手形光标
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
    //玩家叫地主
    Image{
        visible:false
        id:_callButton
        source: "qrc:/images/jiaodizhu1.png"
        anchors.left: startButton.right
        anchors.top:notcallButton.top
        anchors.topMargin: -5
        // 添加动画
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true // 启用鼠标悬停事件

            //鼠标悬停于叫地主按钮
            onEntered: {callButton.source="qrc:/images/jiaodizhu2.png"}
            onClicked:{
                callButton.visible=false
                notcallButton.visible=false
                mecall.visible=!mecall.visible
                //设置叫地主和农民形象消失，地主形象出现

                if (mecall.visible) {
                                   mehideTimer.start();
                               } else {
                                   mehideTimer.stop();
            }
        }
            // 鼠标离开时触发的信号处理函数
             onExited: {callButton.source="qrc:/images/jiaodizhu1.png"}

             cursorShape: Qt.PointingHandCursor // 鼠标悬停时显示手形光标
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

}

