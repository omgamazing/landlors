import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "game.js" as Controller
import "card.js" as Card

Item {

    property alias centercard:_centercard
    property alias me:_me
    property alias rplayer:_rplayer
    property alias lplayer:_lplayer
    property alias landlor: _landlor
    property alias landlorsDecksLocation:_landlorsDecksLocation
    property alias meDecksLocation:_meDecksLocation
    property alias lDecksLocation:_lDecksLocation
    property alias rDecksLocation:_rDecksLocation
    property alias meLocation:_meLocation
    property alias lplayLocation:_lplayLocation
    property alias rplayLocation:_rplayLocation

    property alias startButtonImage:_startButtonImage
    property alias notcallButtonImage:_notcallButtonImage
    property alias callButtonImage:_callButtonImage
    property alias notchuButtonImage:_notchuButtonImage
    property alias chuButtonImage:_chuButtonImage

    property alias callAni:_callAni
    property alias notcallAni:_notcallAni


    property int count_me:0
    property int count_left:0
    property int count_right:0

    //分数显示栏
    ColumnLayout{
            id:score
            width:100
            height:100
            x:780
            y:20

            spacing:-10

            Text{text:"    我\t"+count_me+"分";font.pointSize: 16;color:"white"}
            Text{text:"左侧机器人 "+count_left+"分";font.pointSize: 16;color:"white"}
            Text{text:"右侧机器人 "+count_right+"分";font.pointSize: 16;color:"white"}
    }

    //中间牌盒
    Image{
        id:_centercard
        visible:true
        source: "qrc:/poker/rear.png"
        x:470
        y:275
    }


    //自己
    Image{
        id:_me
        visible:false
        source:randomfarmer()
        width:100
        height:140
        x:100
        y:450

    }

    //地主形象
    Image{
        id:_landlor
        visible:false
        source:"qrc:/images/people-1.png"
        width:100
        height:140
        //x:100
        //y:450

    }

    //左边玩家
     Image{
         id:_lplayer
         visible:false
         source:randomfarmer()
         width:100
         height:140
         x:0
         y:(window.height-height)/2.57
     }


     //右边玩家
     Image{
         id:_rplayer
         visible:false
         source:randomfarmer()
         mirror:true
         width:100
         height:140
         x:900
         y:(window.height-height)/2.57

     }

     //地主牌区域
     RowLayout {
             id: _landlorsDecksLocation
             visible: false
             x: 380
             y: 30
             spacing:8// 每张牌之间的间距

             Repeater {
                 model: 3
                 delegate:Image {
                     source:"qrc:/poker/1-2.png"

             }
         }
     }

     //左边玩家的牌堆
     Rectangle{
         id:_lDecksLocation
         visible: false
         width:70
         height:120
         anchors.left: _lplayer.right
         anchors.leftMargin: 30
         y:(window.height-height)/2.2
         color: "transparent" // 设置矩形的颜色为透明

         Text {
             id:_text1
             anchors.horizontalCenter: parent.horizontalCenter
             textFormat: Text.RichText
             font.pixelSize: 13

             text: {
                 var num = Controller.lplayerDecks.length;
                 return qsTr("剩 ")
                      + "<font color='white' size='5'>" + num+ "</font>"
                      + qsTr(" 张");
                     }
         }

         Image{
             anchors.top: _text1.bottom
             anchors.horizontalCenter: parent.horizontalCenter
             source:"qrc:/poker/rear.png"
         }

     }

     //右边玩家的牌堆
     Rectangle{
         id:_rDecksLocation
         visible: false
         width:70
         height:120
         anchors.right: _rplayer.left
         anchors.rightMargin: 30
         y:(window.height-height)/2.2
         color: "transparent"

         Text {
             id:_text2
             anchors.horizontalCenter: parent.horizontalCenter
             textFormat: Text.RichText
             font.pixelSize: 13

             text:{qsTr("剩 "
                        + "<font color='white' size='5' >" + Controller.rplayerDecks.length + "</font>"
                        + " 张")}
         }

         Image{
             anchors.top: _text2.bottom
             anchors.horizontalCenter: parent.horizontalCenter
             source:"qrc:/poker/rear.png"
         }

     }


     //自己的牌
     RowLayout {
             id: _meDecksLocation
             visible:false
             x: 350
             y: 480
             spacing: -56 // 每张牌之间的间距


             Repeater {
                 model: 15 // 假设有5张牌
                 delegate: Image {
                     id:cardImage
                     width:71
                     height:96
                     source: "qrc:/poker/1-4.png"
                     y:0

                     /* 问题：无法一次只点击一张，因为点击卡片部分区域是重叠的，点击卡片左边会涉及其他卡片的
                    TapHandler{
                        onTapped:{
                             cardImage.y=(cardImage.y===0?-15:0)
                         }

                     }*/

                     MouseArea{
                         anchors.fill: parent
                         onClicked:  {
                             cardImage.y=(cardImage.y===0?-15:0)
                             console.log("clicked")
                         }
                     }
                 }
             }
     }


     //我出牌区域
     RowLayout{
             id: _meLocation
             visible: false
             x:420
             y:350
             spacing:-56// 每张牌之间的间距

             Repeater {
                 model: 3
                 delegate: Image {
                     source: "qrc:/poker/2-7.png"
                 }
             }
         }

     //右边玩家出牌区域
     ColumnLayout{
             id: _rplayLocation
             visible: false
             anchors.right:_rDecksLocation.left
             anchors.rightMargin: 60
             anchors.top:_rDecksLocation.top
             anchors.topMargin: -50
             spacing:-77// 每张牌之间的间距

             Repeater {
                 model: 3
                 delegate: Image {
                     source: "qrc:/poker/2-13.png"
                 }
             }
         }

     //左边玩家出牌区域
     ColumnLayout{
             id: _lplayLocation
             visible: false
             anchors.left: _lDecksLocation.right
             anchors.leftMargin: 60
             anchors.top:_lDecksLocation.top
             anchors.topMargin: -50
             spacing:-77// 每张牌之间的间距

             Repeater {
                 model: 3
                 delegate: Image {
                     source: "qrc:/poker/2-12.png"
                 }
             }
         }



     //开始按钮
     ColumnLayout {
         anchors.horizontalCenter: _centercard.horizontalCenter
         y: 420

         Image{
             id: _startButtonImage
             visible: true
             source:"qrc:/images/start-1.png"
             fillMode: Image.PreserveAspectFit
             TapHandler {
                 onTapped:Controller.start()
                 }


             HoverHandler{
                  cursorShape: Qt.PointingHandCursor
                  onHoveredChanged: {
                      _startButtonImage.source = hovered ? "qrc:/images/start-3.png" : "qrc:/images/start-1.png"
                      }
                  }

         }
    }


     //按钮：叫与不叫
     RowLayout {
         id:jiaobujiao
         x:320
         y: 420
         spacing: 120
         z:0

         //不叫地主
         Image{
             id: _notcallButtonImage
             visible: false
             source:"qrc:/images/bujiao1.png"
             fillMode: Image.PreserveAspectFit

             TapHandler {
                 onTapped: {
                     Controller.notcall()
                     _notcallAni.visible=true
                     notcallAniTimer.start()
                     rhideTimer.start()
                 }
             }

             HoverHandler{
                  cursorShape: Qt.PointingHandCursor
                  onHoveredChanged: {
                      _notcallButtonImage.source = hovered ? "qrc:/images/bujiao2.png" : "qrc:/images/bujiao1.png"
                  }
             }
         }

         //叫地主按钮
         Image{
             id: _callButtonImage
             visible: false
             source:"qrc:/images/jiaodizhu2.png"
             fillMode: Image.PreserveAspectFit
             TapHandler {
                 cursorShape: Qt.PointingHandCursor
                 onTapped: {
                     Controller.call()
                     _callAni.visible=true
                     callAniTimer.start()
                     mehideTimer.start()
                     buchuTimer.start()
                     }
             }
             HoverHandler{
                  cursorShape: Qt.PointingHandCursor
                  onHoveredChanged: {
                      _callButtonImage.source = hovered ? "qrc:/images/jiaodizhu1.png" : "qrc:/images/jiaodizhu2.png"
                  }
             }

         }

     }


     //按钮：出不出牌
     RowLayout {
         id:chubuchu
         x:350
         y: 420
         spacing: 120
         z:1

         //notchu
         Image{
             id: _notchuButtonImage
             width: 120
             height:55
             visible: false
             source:"qrc:/images/pass1.png"
             fillMode: Image.PreserveAspectFit

             TapHandler {
                 onTapped: {
                     buchuTimer.stop()
                     Controller.notchu()

                 }
             }

             HoverHandler{
                  cursorShape: Qt.PointingHandCursor
                  onHoveredChanged: {
                      _notchuButtonImage.source = hovered ? "qrc:/images/pass2.png" : "qrc:/images/pass1.png"
                  }
             }
         }

         //chu
         Image{
             id: _chuButtonImage
             visible: false
             source:"qrc:/images/chupai1.png"
             fillMode: Image.PreserveAspectFit
             TapHandler {
                 cursorShape: Qt.PointingHandCursor
                 onTapped: {
                     buchuTimer.stop()
                     Controller.chu()
                     }
             }
             HoverHandler{
                  cursorShape: Qt.PointingHandCursor
                  onHoveredChanged: {
                      _chuButtonImage.source = hovered ? "qrc:/images/chupai2.png" : "qrc:/images/chupai1.png"
                  }
             }

         }

     }

     //动画：叫地主
     Image{
         id:_callAni
         visible:false
         source: "qrc:/images/jiaodizhu.png"
         x:430
         y:320
     }
     Timer{
         id:callAniTimer
         interval: 1000
         repeat: false
         onTriggered: {
             _callAni.visible=false
         }

     }

     //动画：不抢
     Image{
         id:_notcallAni
         visible:false
         source: "qrc:/images/buqiang.png"
         x:420
         y:320
     }

     Timer{
         id:notcallAniTimer
         interval: 1000
         repeat: false
         onTriggered: {
             _notcallAni.visible=false
         }

     }

     //动画：过
     Image{
         id:_passAni
         visible:false
         source: "qrc:/images/pass.png"
         x:420
         y:320
     }
     Timer{
         id:passAniTimer
         interval: 1000
         repeat: false
         onTriggered: {
             _passAni.visible=false}

     }


     //超过3s不出自动跳到下一位
     Timer{
         id:buchuTimer
         interval: 3000
         repeat: false
         onTriggered: {
             Controller.notchu()
             _passAni.visible=true
             passAniTimer.start()

         }
     }


     Timer{
         id:rhideTimer
         interval: 200
         repeat: false
         onTriggered: rplayerhide()
         }

     Timer{
         id: mehideTimer
         interval: 200
         running:false
         repeat: false
         onTriggered: mehide()
         }

     //隐藏左边玩家农民形象，出现地主形象
     function lplayerhide(){
         _lplayer.visible=false
         _landlor.visible=true
         _landlor.mirror=false
         _landlor.x=_lplayer.x
         _landlor.y=_lplayer.y
     }

     //隐藏右边玩家农民形象，出现地主形象
     function rplayerhide(){
         _rplayer.visible=false
         _landlor.visible=true
         _landlor.mirror=true
         _landlor.x=_rplayer.x
         _landlor.y=_rplayer.y
     }

     //隐藏自己农民形象，出现地主形象
     function mehide(){
         _me.visible=false
         _landlor.visible=true
         _landlor.mirror=false
         _landlor.x=_me.x
         _landlor.y=_me.y
     }

     function randomfarmer()
     {
         //生成2-3的整数
         var n=Math.floor(Math.random() * 2) + 2
         if(n!=2)
             n=3
         return "qrc:/images/people-"+n+".png"
     }


         //卡牌从一个点移动到另一个点 移动效果的函数,用于发牌
         //Item {
             //property alias card: cardItem // 将内部的Card对象暴露给外部访问

         /*RowLayout {
             id: _landlorsDecksLocation
             visible: false
             x: 270
             y: 480
             spacing: -56 // 每张牌之间的间距

             Repeater {
                 model: 17 // 假设有17张牌
                 delegate: Item {
                     width: 85
                     height: 100

                     Canvas {
                         id: cardCanvas
                         width: parent.width
                         height: parent.height

                         onPaint: {
                             var ctx = getContext("2d");
                             ctx.clearRect(0, 0, width, height);

                             // 绘制牌的背景
                             ctx.fillStyle = "white";
                             ctx.fillRect(0, 0, width, height);
                             ctx.strokeStyle = "black";
                             ctx.strokeRect(0, 0, width, height);

                             //player1传入

                             var rank; // 替换为牌的名称
                             var suit = "♠"; // 替换为牌的花色符号
                             for(var i=0;i<deck.length;i++){

                             }

                             // 绘制牌的花色和名称

                             ctx.font = "bold 24px Arial";
                             ctx.fillStyle = (suit === "♠" || suit === "♣") ? "black" : "red";
                             ctx.textAlign = "left";
                             ctx.textBaseline = "top";
                             ctx.fillText(suit + rank, 5, 5);
                         }
                     }

                     MouseArea {
                         anchors.fill:parent
                         onClicked: {
                             parent.y=(parent.y===0?-15:0)
                         }
                     }
                 }
             }
         }
         function addCardView(arr){
             var deck=Card.player1Card()
             for (var i = 0; i < arr.length; i++) {
                     var card = arr[i]; // 获取玩家1的第i张牌数据
                     myDecks_location.itemAt(i).cardCanvas.rank = card.rank;
                     myDecks_location.itemAt(i).cardCanvas.suit = card.suit;}
         }*/





         /*Rectangle{
             id: btnBox
             width: 200 // 设置宽度
             height: 50 // 设置高度

             TextInput {
                         padding: 10 // 内边距
                         width: 150 // 宽度
                         height: 30 // 高度
                         //backgroundColor: "#ffff33" // 背景色
                         //border.width: 0 // 边框宽度
                         //radius: 20 // 圆角
                         color: "#972b00" // 文本颜色
                         focus: false // 失去焦点
             }
             // 第二个和第三个 input 的隐藏
             TextInput {
                         visible: false // 隐藏元素
             }
             TextInput {
                         visible: false // 隐藏元素
             }
         }

         //生成玩家牌
         ListView {
                 id: playerlistView
                 width: parent.width
                 height: parent.height
                 clip: true
                 delegate: Item {
                     width: 80
                     height: 120
                     Column {
                         anchors.centerIn: parent

                         Text {
                             text: modelData.pname + modelData.suit
                             font.pixelSize: 18
                             horizontalAlignment: Text.AlignHCenter
                         }
                     }
                 }
         }*/


}

