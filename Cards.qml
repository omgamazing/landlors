import QtQuick

Item {
    id: root

    property var dawang: dawang
    property var xiaowang: xiaowang
    property var hongtaoA: hongtaoA

    Component {
        id: cardComponent
        Rectangle {
            width: 85
            height: 100
            color: "white"
            border.color: "black"

            // 卡片内容
            Text {
                font.bold: true
                font.pixelSize: 20
                anchors.centerIn: parent
            }
        }
    }

    Component.onCompleted: {
        dawang = cardComponent.createObject(root, {"id": "dawang"});
        xiaowang = cardComponent.createObject(root, {"id": "xiaowang"});
        hongtaoA = cardComponent.createObject(root, {"id": "hongtaoA"});
    }
}
