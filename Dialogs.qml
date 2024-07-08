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
        text:"Landlord (incomplete version)"
        informativeText: qsTr("Landlord Fighter is a casual and relaxing game  ")
        detailedText: "This project file can be cloned from GitHub:https://github.com/omgamazing/landlors.git"
    }



}
