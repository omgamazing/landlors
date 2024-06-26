import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    width: 800
    height: 600

    property int countdown: 10
    property bool running: true
    property int turn: 1 // 默认从玩家开始

    Text {
        id: timerText
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: "倒计时: " + countdown
        font.pixelSize: 24
    }

    function delay(ms) {
        var date = new Date()
        var curDate = null
        do {
            curDate = new Date()
        } while (curDate - date < ms)
    }

    Timer {
        id: gameTimer
        interval: 1000
        running: running
        repeat: true

        onTriggered: {
            if (countdown > -1 && running) {
                timerText.text = "倒计时: " + countdown--
                // 其他逻辑...
            } else {
                // 倒计时结束处理
                running = false
                timerText.text = "不抢"
                // 其他逻辑...
            }
        }
    }

    Component.onCompleted: {
        // 游戏开始初始化
        gameTimer.start()
        // 其他初始化逻辑...
    }
}
