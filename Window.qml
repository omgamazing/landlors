import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
    property alias startButton:_startButton
    property alias notcallButton:_notcallButton
    property alias notcall:_notcall
    property alias centercard:_centercard
    property alias lcard:_lcard
    property alias rcard:_rcard
    property alias lplayer:_lplayer
    property alias rplayer:_rplayer
    property alias me:_me

    //游戏背景
    background: Image {
        id:_back
        source: "qrc:/images/background-2.png" //URL路径
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
    }

    //左边玩家
    Image{
        id:_lplayer
        visible:false
        source:"qrc:/images/people-1.png"
        width:100
        height:140
        anchors.left: window.left
        y:(parent.height-height)/2.3
    }

    //右边玩家
    Image{
        id:_rplayer
        visible:false
        source:"qrc:/images/people-3.png"
        width:100
        height:140
        //mirror: true // 水平镜像翻转
        anchors.right: parent.right
        y:(parent.height-height)/2.3

    }

    //自己
    Image{
        id:_me
        visible:false
        source:"qrc:/images/people-3.png"
        mirror: true // 水平镜像翻转
        width:100
        height:140
        x:100
        y:450

    }

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
            }
           // 鼠标离开时触发的信号处理函数
            onExited: {startButton.source="qrc:/images/start-1.png"}

            cursorShape: Qt.PointingHandCursor // 鼠标悬停时显示手形光标

        }
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


    Image{
        visible:false
        id:_notcallButton
        source: "qrc:/images/buqiang-1.png"
        anchors.right: startButton.left
        anchors.top:centercard.bottom
        anchors.topMargin:100
        // 添加动画
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true // 启用鼠标悬停事件

            //鼠标悬停于不抢按钮
            onEntered: {notcallButton.source="qrc:/images/buqiang-2.png"}
            onClicked:{
                notcallButton.visible=false
                notcall.visible=!notcall.visible
                //设置不抢消失
                if (notcall.visible) {
                                   hideTimer.start();
                               } else {
                                   hideTimer.stop();
                               }
            }
           // 鼠标离开时触发的信号处理函数
            onExited: {notcallButton.source="qrc:/images/buqiang-1.png"}

            cursorShape: Qt.PointingHandCursor // 鼠标悬停时显示手形光标

        }
    }
    Image{
        visible:false
        id:_notcall
        source: "qrc:/images/buqiang.png"
        anchors.top:centercard.bottom
        anchors.topMargin:10
        anchors.horizontalCenter: centercard.horizontalCenter
    }
    //不抢消失定时器
    Timer {
            id: hideTimer
            interval: 1000 // 1秒后触发
            repeat: false // 只触发一次
            onTriggered: {
                notcall.visible = false; // 定时器触发后隐藏图片按钮
            }
        }



            // 打印所有牌的信息
            console.log("所有牌的信息:");
            for (var i = 0; i < cards.length; i++) {
                console.log("花色:", cards[i].suit, " 牌面:", cards[i].rank);
            }
        }
}
