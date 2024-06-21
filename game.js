//游戏控制器：操作整个游戏的运行，接受信号并做出反应
//开始
function start(){
    startButton.visible = false;

    //displayclockTimer.start();

    console.log("---startGame----")

    //创建Deck对象
    var component = Qt.createComponent("CardsPrepare.qml");
    if (component.status === Component.Ready) {
        var deck= component.createObject();
    }

    notcallButton.visible = true;
    callButton.visible = true;

    var userplayer = Qt.createComponent("Player.qml");
    userplayer.name="uyg"
    console.log(userplayer.name)

    userplayer.notifyGrabLordBet.connect(function() {
    console.log("接受");})
    userplayer.triggerNotifyGrabLordBet()
}
//不叫
function notcall(){
notcallButton.visible=false
_callButton.visible=false
notcall.visible=!notcall.visible
console.log("player notcall")
    hidecallTimer.start();
}
//设置不抢和农民形象消失，地主形象出现
function hide(){
notcall.visible = false; // 定时器触发后隐藏图片按钮
 // 定时器触发后显示图片
_rcall.visible = true;
}
//叫地主
function call(){
callButton.visible=false
notcallButton.visible=false
mecall.visible=!mecall.visible
console.log("player call")
    myhidecallTimer.start();
}
//设置叫地主和农民形象消失，地主形象出现
function myhide(){
            _rcall.visible = false; // 定时器触发后隐藏图片按钮
            rplayer.visible = false;
            _rlandlor.visible = true;// 定时器触发后显示图片
        }

