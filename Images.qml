import QtQuick

Item {

    property alias startButton:_startButton



    property alias centercard:_centercard
    property alias lcard:_lcard
    property alias rcard:_rcard
    property alias lplayer:_lplayer
    property alias rplayer:_rplayer
    property alias me:_me

    //开始按钮
    Image{
        visible:false
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
            }
           // 鼠标离开时触发的信号处理函数
            onExited: {startButton.source="qrc:/images/start-1.png"}

            cursorShape: Qt.PointingHandCursor // 鼠标悬停时显示手形光标

        }
    }


    //左边玩家
    Image{
        id:_lplayer

        source:"qrc:/images/people-1.png"
        width:100
        height:140
        anchors.left: window.left
        y:(window.height-height)/2.3

        visible: false

    }
    Image{
        id:_rplayer

        source:"qrc:/images/people-1.png"
        width:100
        height:140
        mirror: true // 水平镜像翻转
        anchors.right: window.right
        y:(window.height-height)/2.3


        visible: false
    }

    //自己
    Image{
        id:_me
        source:"qrc:/images/people-1.png"
        width:100
        height:140
        x:100
        y:450
        visible:false

    }


    //中间卡牌
    Image{
        id:_centercard
        source: "qrc:/poker/rear.png"
        anchors.centerIn: window
        visible:false


    }

    //左右卡牌
    Image{
        id:_lcard
        source: "qrc:/poker/rear.png"
        anchors.verticalCenter:window.verticalCenter
        anchors.left: lplayer.right
        visible:false

    }
    Image{
        id:_rcard
        source: "qrc:/poker/rear.png"
        anchors.verticalCenter: window.verticalCenter
        anchors.right: rplayer.left
        visible:false
    }





}
