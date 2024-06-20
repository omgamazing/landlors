import QtQuick
Item {

    property int suit // 花色
    property int rank // 牌面
    property var cards:[]//手牌
    property var myCards: []//玩家手牌
    property var otherCards: []//其他的手牌


    // 显示牌的外观，使用图片
    Image {
        anchors.centerIn: parent
        source: getCardImage(suit,rank)
    }

    // 测试代码
    Component.onCompleted: {
        //myCards.push({suit: 5, rank: 16});//大王
        //myCards.push({ suit: 5, rank: 17});//小王
        //myCards.push({suit:3,rank:13})//三带一 三K带3
        //myCards.push({suit:1,rank:13})
        //myCards.push({suit:2,rank:13})
        //myCards.push({suit:3,rank:3})
        //otherCards.push({suit: 1, rank: 5});//三5 带6
        //otherCards.push({ suit: 2, rank: 5 });
        //otherCards.push({ suit: 3, rank: 5 });
        //otherCards.push({ suit: 1, rank: 6 });
        //var isPlay=isAllowedCards(myCards,otherCards);
        //console.log("我是否可以出牌？",isPlay)

        cards.push({suit:3,rank:13})//三带一 三K带3
        cards.push({suit:1,rank:13})
        cards.push({suit:2,rank:13})
        cards.push({suit:3,rank:3})

    }

//获取牌的类型
function getCardType()
{
if(isSingle())return CardType.single;
else if(isDouble())return CardType.two;
else if(isTripleWithOne())return CardType.tripleWithOne;
else if(isTripleWithTwo())return CardType.tripleWithTwo;
else if(isPlaneWithTwoSingle())return CardType.planeWithTwoSingle;
else if(isPlaneWithTwoDouble())return CardType.planeWithTwoDouble;
else if(isStraight())return CardType.straight;
else if(isStraightWithDouble())return CardType.straightWithDouble;
else if(isBomb())return CardType.bomb;
else if(isJokers())return CardType.jokers;
}

//判断当前出牌是否合理
//两个参数：其他玩家打出来的牌，自己将要打的牌
function isAllowedCards(myCards,otherCards)
{
    //如果其他玩家当前这一轮没有打牌，自己任意牌都可以出
    if(otherCards.length===0)
    {
        console.log("玩家可以出任意牌！");
        return true;
    }
    //获取牌的类型
    var myCardsType=getCardType(myCards);
   // console.log("玩家的牌型是：",myCardsType);
    var otherCardsType=getCardType(otherCards);

    if(myCardsType===CardType.jokers)
    {
        console.log("玩家打出王炸!");
        return true;
    }else if(myCardsType===CardType.bomb&&otherCardsType!==CardType.bomb)
    {
        console.log("玩家出炸弹！");
        return true;
    }
    //同类型的牌做比较,当前实现只是能够一张一张的比较排序，不能分开特殊类型的主牌和副牌进行比较
    else if(myCardsType===otherCardsType)
    {
        console.log("同类型的牌，正在比较！");
        //逐步的牌做比较
        myCards.sort((a, b) => a.rank - b.rank);
        otherCards.sort((a, b) => a.rank - b.rank);

        for (let i = 0; i < myCards.length; i++) {
            if (myCards[i].rank !== otherCards[i].rank) {
                return false;}}
        console.log("玩家的牌大与other！");
               return true;
    }else {return false;}
}

//排序,冒泡排序
function sortCards()
{
    for (let i = 0; i < cards.length - 1; i++) {
            for (let j = 0; j < cards.length - 1 - i; j++) {
                if (cards[j].rank > cards[j + 1].rank ||
                    (cards[j].rank === cards[j + 1].rank && cards[j].suit > cards[j + 1].suit)) {
                    // 交换 cards[j] 和 cards[j + 1]
                    let temp = cards[j];
                    cards[j] = cards[j + 1];
                    cards[j + 1] = temp;
                }
            }
        }
}
//判断是否为单牌
function isSingle()
{
    console.log("正在判断牌型是否为Single");
    return cards.length===1;
}
//判断是否为对子
function isDouble()
{
    if (cards.length !== 2) {
            return false;
        }
    console.log("正在判断牌型是否为Double");
        return cards[0].rank === cards[1].rank;
}

//判断是否为三带一
function isTripleWithOne() {
    console.log("正在判断牌型是否为TripleWithOne");
    if (cards.length !== 4) {
        return false;
    }
    sortCards();
    return (cards[0].rank === cards[1].rank && cards[1].rank === cards[2].rank) ||
           (cards[1].rank === cards[2].rank && cards[2].rank === cards[3].rank);
}

//判断是否为三带二
function isTripleWithTwo() {
    console.log("正在判断牌型是否为TripleWithTwo");
    if (cards.length !== 5) {
        return false;
    }
    sortCards();
    console.log("当前手牌为TripleWithTwo！");
    return (cards[0].rank === cards[1].rank && cards[1].rank === cards[2].rank &&
            cards[3].rank === cards[4].rank && cards[2].rank !== cards[3].rank);
}
//判断是否为飞机带两单张
function isPlaneWithTwoSingle() {
    console.log("正在判断牌型是否为PlaneWithTwoSingle");
    if (cards.length < 8 || cards.length % 5 !== 0) {
        return false;
    }
    sortCards();

    for (var i = 0; i < cards.length - 4; i += 3) {
        if (cards[i].rank !== cards[i+1].rank || cards[i].rank !== cards[i+2].rank) {
            continue;
        }
        if (i + 3 < cards.length && cards[i+3].rank !== cards[i+4].rank) {
            return true;
        }
    }
    return false;
}
//判断是否为飞机带两对
function isPlaneWithTwoDouble() {
    console.log("正在判断牌型是否为PlaneWithTwoDouble");
    if (cards.length < 10 || cards.length % 5 !== 0) {
        return false;
    }
    cards.sort((a, b) => a - b);

    // 检查是否满足飞机带两对的条件
    for (let i = 0; i < cards.length - 5; i += 5) {
            // 检查飞机部分，即三张牌是否相同
        if (cards[i] !== cards[i + 2]) {
             continue; // 如果不是相同的牌，跳过这一组
         }

        // 后面两对是否分别相同
        if (cards[i + 3] !== cards[i + 4] || cards[i + 3] !== cards[i + 6] || cards[i + 6] !== cards[i + 7]) {
            continue; // 如果不是两对牌，跳过这一组
        }
        console.log("当前手牌为PlaneWithTwoDouble！");
    return true;}
}
//判断是否为顺子 五张以上连续单牌
function isStraight(){
    console.log("正在判断牌型是否为Straight");
    if (cards.length < 5 || cards.length > 12) {
        return false;
    }
    sortCards(cards);
    for (let i = 0; i < cards.length - 1; i++) {
        if (cards[i + 1].rank !== cards[i].rank + 1) {
            return false;
        }
    }
    console.log("当前手牌为Straight！");
    return true;
}
//判断是否为连对 三个以上连续双牌
function isStraightWithDouble() {
    console.log("正在判断牌型是否为StraightWithDouble");
    if (cards.length < 6 || cards.length % 2 !== 0) {
        return false;
    }
    sortCards();
    for (let i = 0; i < cards.length - 2; i += 2) {
        if (cards[i + 1].rank !== cards[i].rank || cards[i + 2].rank !== cards[i].rank + 1) {
            return false;
        }
    }
    console.log("当前手牌为StraightWithDouble！");
    return true;
}
//判断是否为炸弹
function isBomb() {
    console.log("正在判断牌型是否为Bomb");
    if (cards.length !== 4) {
        return false;
    }
    sortCards();
    console.log("当前手牌为bomb！");
    return cards[0].rank === cards[1].rank && cards[1].rank === cards[2].rank && cards[2].rank === cards[3].rank;
}

//判断是否为王炸
function isJokers() {
    console.log("正在判断牌型是否为Jokers");
    if (cards.length !== 2) {
        return false;
    }
    sortCards();
    console.log("当前牌型是王炸！");
    return cards[0].rank === 16 && cards[1].rank === 17;
}


// 辅助函数，根据花色和牌面大小返回牌的图片路径
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
}

