//类似于一个容器：有游戏界面、对话框

import QtQuick

Item {

    property alias dialogs:_dialogs

    //定义了Dialogs,Dialogs.qml实现的具体的对话框
    Dialogs{
        id:_dialogs
    }



}
