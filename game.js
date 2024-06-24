var players = [];
var deck = [];
var landlordIndex = -1;
var currentTurnIndex = 0;

function initializeGame() {
    // 创建所有的卡牌
    for (var suit = 0; suit < 4; suit++) {
        for (var rank = 0; rank < 13; rank++) {
            var card = new jsPlugin.Card(suit, rank);
            cards.push(card);
        }
    }

    // 洗牌
    shuffle(cards);

    // 发牌
    distributeCards();
}

function distributeCards() {
    for (var i = 0; i < cards.length; i++) {
        var playerIndex = i % players.length;
        players[playerIndex].addCard(cards[i]);
    }

    // 决定地主，更新界面和玩家属性
    var landlordIndex = Math.floor(Math.random() * players.length);
    players[landlordIndex].isLandlord = true;

    // 更新 QML 界面显示
    // 例如通过信号发送更新手牌的命令到 QML 的 PokerPanel 中显示玩家手牌
}

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
    notcallButton.visible = true;
    callButton.visible = true;

}}


//不叫
function notcall(){
_notcallButtonImage.visible=false
_callButtonImage.visible=false
//notcall.visible=!notcall.visible
console.log("player notcall")
    //hidecallTimer.start();
}
//设置不抢和农民形象消失，地主形象出现
function hide(){
notcall.visible = false; // 定时器触发后隐藏图片按钮
 // 定时器触发后显示图片
_rcall.visible = true;
}
//叫地主
function call(){
_callButtonImage.visible=false
_notcallButtonImage.visible=false
mecall.visible=!mecall.visible
console.log("player call")
   myhidecallTimer.start();
}
