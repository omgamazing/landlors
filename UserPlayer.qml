import QtQuick 2.0
Item {
    //userplayer

    Component.onCompleted: {
        // 初始化操作
        //userPlayer.name = "User Player 1";
        //userPlayer.setRole(UserPlayerJS.Player.Role.Farmer);
        //userPlayer.setSex(UserPlayerJS.Player.Sex.Man);
        // 其他属性设置
    }

    // 响应信号
    Connections {
        target: userPlayer

       // onStartCountDown: {
          //  console.log("Countdown started for user player.");
            // 在这里处理倒计时逻辑
       // }
    }
}
