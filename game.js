//游戏控制器：操作整个游戏的运行，接受信号并做出反应
//开始
function start(){
    _startImage.visible = false;

    //displayclockTimer.start();

    console.log("---startGame----")

    //创建Deck对象
    var component = Qt.createComponent("CardsPrepare.qml");
    if (component.status === Component.Ready) {
        var deck= component.createObject();
    if (deck === null) {
        console.error("Error creating object")
    } else {
        _notcallButtonImage.visible = true;
       _callButtonImage.visible = true;
    }
    }
    else if(component.status === Component.Error){
            console.error("Error loading CardsPrepare.qml");
        }
}


//不叫
function notcall(){
_notcallButtonImage.visible=false
_callButtonImage.visible=false
//notcall.visible=!notcall.visible
console.log("player notcall")
    //hidecallTimer.start();
}
/*//设置不抢和农民形象消失，地主形象出现
function hide(){
notcall.visible = false; // 定时器触发后隐藏图片按钮
 // 定时器触发后显示图片
_rcall.visible = true;
}*/
//叫地主
function call(){
_callButtonImage.visible=false
_notcallButtonImage.visible=false
mecall.visible=!mecall.visible
console.log("player call")
   myhidecallTimer.start();
}
