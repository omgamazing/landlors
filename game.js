

/*
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
}*/

//游戏控制器：操作整个游戏的运行，接受信号并做出反应
//开始

var decks=[]
var meDecks=[]
var lplayerDecks=[]
var rplayerDecks=[]
var landlorsDecks=[]
var players=[
       { name: "玩家", isHuman: true},
       { name: "人机1", isHuman: false },
       { name: "人机2", isHuman: false }
   ]


function start(){

    console.log("---startGame----")
    for (var i = 0; i < players.length; i++) {
               var playerComponent = Qt.createComponent("Player.qml");
               if (playerComponent.status === Component.Ready) {
                   var playerObject = playerComponent.createObject( {
                       "name": players[i].name,
                       "isHuman": players[i].isHuman,
                       "index": i,
                       "playCard":arrayreturn(i)

                   });

                   if (playerObject === null) {
                       console.log("Error creating player " + players[i].name);
                   } else {
                       console.log("Created player: " + players[i].name);
                   }
               } else {
                   console.log("Error loading Player.qml component");
               }
           }

    var currentPlayerIndex = 0; // 当前玩家索引，从第一个玩家开始
    function getNextPlayer() {
        var player = players[currentPlayerIndex];
        currentPlayerIndex = (currentPlayerIndex + 1) % players.length; // 循环到下一个玩家
        return player;
    }
    var currentPlayer = getNextPlayer();
    console.log("当前玩家:", currentPlayer.name);

    window.content.music.backgroundMusic.stop()
    window.content.music.backgroundMusic.play()

    decks=[]
    meDecks=[]
    lplayerDecks=[]
    rplayerDecks=[]
    landlorsDecks=[]

    //显示三个玩家的农民形象和中间牌盒，开始按钮消失
    window.content.elements.me.visible=true
    window.content.elements.lplayer.visible=true
    window.content.elements.rplayer.visible=true
    window.content.elements.me.source=randomfarmer()
    window.content.elements.lplayer.source=randomfarmer()
    window.content.elements.rplayer.source=randomfarmer()
    window.content.elements.landlor.visible=false
    window.content.elements.landlorsDecksLocation.visible=false
    window.content.elements.startButtonImage.visible=false
    window.content.elements.notchuButtonImage.visible=false
    window.content.elements.chuButtonImage.visible=false


    init(decks,meDecks,lplayerDecks,rplayerDecks,landlorsDecks)

    console.log("--排序后--")
    console.log("\n-------我的牌:-------\n");
    sortDeck(meDecks)
    console.log("\n-------右边玩家的牌:-------\n");
    sortDeck(rplayerDecks)
    console.log("\n-------左边玩家的牌-------\n");
    sortDeck(lplayerDecks)
    console.log("\n-------地主牌的信息:-------\n");
    sortDeck(landlorsDecks)


    //出现我的牌堆，左边、右边玩家的牌及牌数、出现按钮叫与不叫
    window.content.elements.notcallButtonImage.visible = true;
    window.content.elements.callButtonImage.visible = true;
    window.content.elements.meDecksLocation.visible=true;
    window.content.elements.lDecksLocation.visible=true;
    window.content.elements.rDecksLocation.visible=true;

    /*
    console.log(meDecks.length);
    console.log(rplayerDecks.length);
    console.log(lplayerDecks.length);
    console.log(landlorsDecks.length);*/




}

function arrayreturn(a){

    switch(a){
    case 0:return meDecks;
    case 1:return rplayerDecks;
    case 2:return lplayerDecks;
    default:console.log("invalid return");break;
    }
}
function init(decks,meDecks,lplayerDecks,rplayerDecks,landlorsDecks)
{
    // 初始化牌堆：生成一副包括 A-K 的四种花色和大小王的54张牌

    var suits = ["♠️", "♥️", "🔷", "♣️"]
    for (var s = 0; s < suits.length; ++s) {
        for (var r = 3; r <= 15; ++r) {
            var card={suit:suits[s],rank:r}
            decks.push(card)
        }
    }
    // 添加大小王
    decks.push({ suit:"🤡", rank: 16 }); // 小王
    decks.push({ suit:"🤡", rank: 17 }); // 大王


    /*
    console.log("----所有牌的信息:-----");
            for (var i = 0; i < decks.length; i++) {
                console.log("索引",i,"花色:", decks[i].suit, " 牌面:", decks[i].rank);
            }*/

    //洗牌：每次迭代生成一个随机整数j，该整数满足 [0,i)。这个随机整数j用来确定当前元素i要移动到的位置
    for (var i = decks.length - 1; i > 0; --i) {
        var j = Math.floor(Math.random() * (i + 1))
        var tmp=decks[j]
        decks[j]=decks[i]
        decks[i]=tmp
    }


    /*
    console.log("所有牌的信息:");
            for (var e = 0; e < decks.length; e++) {
                console.log("索引",e,"花色:", decks[e].suit, " 牌面:", decks[e].rank);
            }*/


    //发牌：玩家拥有哪些牌，机器人拥有哪些
    for(var k = decks.length - 3; k < decks.length; k++)
        landlorsDecks.push(decks[k]);

    for(i=0;i<decks.length-3;i++){
        j=i%3;
        switch(j){
        case 0:
            meDecks.push(decks[i]);break;
        case 1:
            rplayerDecks.push(decks[i]);break;
        case 2:
            lplayerDecks.push(decks[i]);break;
        default:
            break;
        }

    }



}

//排序：根据玩家牌面大小由大到小进行排序
//排序特效（未实现）：动画与音乐
//排序规则：每一次大循环确定一张牌的位置，小循环从牌当前位置向后比较
function sortDeck(cards){

    for (var i = 0; i < cards.length - 1; i++) {
            for (var j = 0; j < cards.length - 1 - i; j++) {
                if (cards[j].rank < cards[j + 1].rank) {
                    // 交换 arr[j] 和 arr[j + 1]
                    var temp = cards[j];
                    cards[j] =cards[j + 1];
                    cards[j + 1] = temp;
                }
            }
        }

    for (var e = 0; e < cards.length; e++) {
        console.log("索引",e,"花色:",cards[e].suit, " 牌面:", cards[e].rank);
    }

    return cards;
}

/*

//向玩家中添加地主牌（叫地主后）
function addcards(cards){
    for(var i=0;i<landlorsDecks.length;i++){
        var card={suit:landlorsDecks[i].suit,rank:landlorsDecks[i].rank}
        console.log(landlorsDecks[i].suit,landlorsDecks[i].rank)
        cards.push(card)
    }
        sortDeck(cards)

}*/


//不叫
function notcall(){
    console.log("player notcall")

    window.content.elements.notcallButtonImage.visible=false
    window.content.elements.callButtonImage.visible=false
    window.content.elements.centercard.visible=false
    window.content.elements.landlorsDecksLocation.visible=true


    window.content.elements.notchuButtonImage.visible=false
    window.content.elements.chuButtonImage.visible=false


    //console.log("右边玩家叫地主后，右边玩家的牌")
    //addcards(lplayerDecks)

}


//叫地主
function call(){
    console.log("player call")



    window.content.elements.callButtonImage.visible=false
    window.content.elements.notcallButtonImage.visible=false
    window.content.elements.centercard.visible=false
    window.content.elements.landlorsDecksLocation.visible=true

    window.content.elements.notchuButtonImage.visible=true
    window.content.elements.chuButtonImage.visible=true
    //console.log("我叫地主后，我的牌")
    //addcards(meDecks)



}
function notchu(){
    console.log("guo")


    window.content.elements.notchuButtonImage.visible=false
    window.content.elements.chuButtonImage.visible=false



}
function chu(){
    console.log("chu")


    window.content.elements.notchuButtonImage.visible=false
    window.content.elements.chuButtonImage.visible=false

}
function randomfarmer()
{
    //生成2-3的整数
    var n=Math.floor(Math.random() * 2) + 2
    if(n!=2)
        n=3
    return "qrc:/images/people-"+n+".png"
}
function get(){
    console.log("地主牌")
    for(var i=0;i<landlorsDecks.length;i++)
        return getCardImage(landlorsDecks[i].suit,landlorsDecks[i].rank)
}
function getCardImage(suit,rank) {
    var suitName;
    var rankName;

    // 根据花色设置文件夹和文件名前缀
    switch (suit) {
        case 1:
            suitName = "1"; // 黑桃
            break;
        case 2:
            suitName = "2"; // 红桃
            break;
        case 3:
            suitName = "3"; // 梅花
            break;
        case 4:
            suitName = "4"; // 方块
            break;
        case 5:
            suitName="5";//大小王
            break;
        default:
            suitName = "";
            break;
    }

    // 根据牌面大小设置文件名
    if (rank >= 3 && rank <= 13) {
                rankName = rank.toString();
                console.log("1")
            }else if(rank>=14&&rank<=15){
                rankName=(rank-13).toString()
                console.log("2")
            }else if(rank === 16) { // 小王
                    suitName="5";
                    rankName = "1";
                console.log("3")
            }else if (rank === 17) { // 大王
                    suitName="5";
                    rankName = "2";
                console.log("4")
            }else{
                    // 处理错误情况，如超出范围的牌面大小
                    console.error("Invalid card rank: " + rank);
                    return "";}

    // 返回图片路径
    return "qrc:/poker//" + suitName + "-" + rankName + ".png";

}


//机器人出牌
// 出牌逻辑函数，传入参数为当前手牌和上家出的牌
function makeMove(hand, lastPlayed) {
    // 根据手牌和上家出牌情况判断可以出的牌
    var cardsToPlay = [];

    // 首先判断是否有能大过上家的牌
    var bestPlay = findBestPlay(hand, lastPlayed);
    if (bestPlay.length > 0) {
        cardsToPlay = bestPlay;
    } else {
        // 如果没有能大过的牌，则尝试出其他牌型，这里可以根据具体游戏规则编写更复杂的逻辑
        cardsToPlay = findAnyPlay(hand);
    }

    return cardsToPlay;
}

// 找到能大过上家的最佳牌组合
function findBestPlay(hand, lastPlayed) {
    // 在实际游戏中，这里需要实现更复杂的牌型判断和策略
    var bestCombination = [];

    // 简化为找到第一个符合条件的牌即停止
    for (var i = 0; i < hand.length; ++i) {
        if (lastPlayed.length === 0 || hand[i].value > lastPlayed[0].value) {
            bestCombination.push(hand[i].value);
            break;
        }
    }

    return bestCombination;
}

// 找到任意可以出的牌
function findAnyPlay(hand) {
    // 简化为找到最小的一张牌进行出牌
    var anyPlay = [];

    if (hand.length > 0) {
        anyPlay.push(hand[0].value);
    }

    return anyPlay;
}

// 假设机器人的手牌和上家出的牌
var playerHand = [{ value: 3 }, { value: 4 }, { value: 5 }, { value: 6 }, { value: 7 }, { value: 8 }];
var lastPlayedCards = [{ value: 8 }, { value: 9 }, { value: 10 }];

// 机器人进行出牌决策
var cardsToPlay = makeMove(playerHand, lastPlayedCards);
console.log("机器人出牌:", cardsToPlay);

