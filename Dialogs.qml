//实现：about、结算界面
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Item {
     property alias about: _about

     MessageDialog{
        id:_about
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Landlors"
        informativeText: qsTr("Freetext is a free software, and you can download its source code from www.open-src.com")
        detailedText: "Copyright©2024 Wei Gong (open-src@qq.com)"
    }

}
