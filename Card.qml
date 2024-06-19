import "./Card.qml"
import QtQuick
Item {

    property int suit // 花色
    property int rank // 牌面

    // 显示牌的外观，使用图片
    Image {
        anchors.centerIn: parent
        source: getCardImage(suit,rank)
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
        if (rank >= 1 && rank <= 13) {
            rankName = rank.toString();
        } else {
            // 处理大小王
            if (rank === 14) { // 小王
                suitName="5";
                rankName = "1";
            } else if (rank === 15) { // 大王
                suitName="5";
                rankName = "2";
            } else {
                // 处理错误情况，如超出范围的牌面大小
                console.error("Invalid card rank: " + rank);
                return "";
            }
        }

        // 返回图片路径
        return "qrc:/poker//" + suitName + "-" + rankName + ".png";
    }

//获取牌的类型
function getCardType(cards)
{
if(isSingle(cards))return CardTypes.single;
else if(isDouble(cards))return CardTypes.two;
else if(isTriple(cards))return CardTypes.triple;
else if(isTripleWithOne(cards))return CardTypes.tripleWithOne;
else if(isTripleWithTwo(cards))return CardTypes.tripleWithTwo;
else if(isPlane())return CardTypes.plane;
else if(isPlaneWithTwoSingle(cards))return CardTypes.planeWithTwoSingle;
else if(isPlaneWithTwoDouble(cards))return CardTypes.planeWithTwoDouble;
else if(isStraight())return CardTypes.straight;
else if(isStraightWithDouble(cards))return CardTypes.straightWithDouble;
else if(isBomb(cards))return CardTypes.bomb;
else if(isJokers(cards))return CardTypes.jokers;
}
//排序
function sortCards(cards)
{
    cards.sort((a,b)=>{
        if(a.rank!==b.rank){return a.rank-b.rank;}else{return a.suit-b.suit;}});
}

//判断是否为单牌
function isSingle(cards)
{
    return cards.length===1;
}
//判断是否为对子
function isDouble(cards)
{
    if (cards.length !== 2) {
            return false;
        }
        return cards[0].rank === cards[1].rank;
}

//判断是否为三个相同
function isTriple(cards)
{
    if (cards.length !== 3) {
            return false;
        }
        return cards[0].rank === cards[1].rank && cards[1].rank === cards[2].rank;
}

//判断是否为三带一
function isTripleWithOne(cards) {
    if (cards.length !== 4) {
        return false;
    }
    csortCards(cards);
    return (cards[0].rank === cards[1].rank && cards[1].rank === cards[2].rank) ||
           (cards[1].rank === cards[2].rank && cards[2].rank === cards[3].rank);
}

//判断是否为三带二
function isTripleWithTwo(cards) {
    if (cards.length !== 5) {
        return false;
    }
    sortCards(cards);
    return (cards[0].rank === cards[1].rank && cards[1].rank === cards[2].rank &&
            cards[3].rank === cards[4].rank && cards[2].rank !== cards[3].rank);
}
//判断是否为飞机带两单张
function isPlaneWithTwoSingle(cards) {
    if (cards.length < 8 || cards.length % 5 !== 0) {
        return false;
    }
    sortCards(cards);

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
function isPlaneWithTwoDouble(cards) {
    if (cards.length < 10 || cards.length % 5 !== 0) {
        return false;
    }
    sortCards(cards);
    for (var i = 0; i < cards.length - 4; i += 3) {
        if (cards[i].rank !== cards[i+1].rank || cards[i].rank !== cards[i+2].rank) {
            continue;
        }
        if (i + 5 < cards.length &&
            cards[i+3].rank === cards[i+4].rank &&
            cards[i+3].rank === cards[i+5].rank &&
            cards[i+6].rank === cards[i+7].rank) {
        }
    }

    return false;
}
//判断是否为顺子 五张以上连续单牌
function isStraight(cards) {
    if (cards.length < 5 || cards.length > 12) {
        return false;
    }
    sortCards(cards);
    for (let i = 0; i < cards.length - 1; i++) {
        if (cards[i + 1].rank !== cards[i].rank + 1) {
            return false;
        }
    }
    return true;

}
//判断是否为连对 三个以上连续双牌
function isStraightWithDouble(cards) {
    if (cards.length < 6 || cards.length % 2 !== 0) {
        return false;
    }
    sortCards(cards);
    for (let i = 0; i < cards.length - 2; i += 2) {
        if (cards[i + 1].rank !== cards[i].rank || cards[i + 2].rank !== cards[i].rank + 1) {
            return false;
        }
    }
    return true;
}
//判断是否为炸弹
function isBomb(cards) {
    if (cards.length !== 4) {
        return false;
    }
    cards.sort((a, b) => a.rank - b.rank);
    return cards[0].rank === cards[1].rank && cards[1].rank === cards[2].rank && cards[2].rank === cards[3].rank;
}

//判断是否为王炸
function isJokers(cards) {
    if (cards.length !== 2) {
        return false;
    }
    cards.sort((a, b) => a.rank - b.rank);
    return cards[0].rank === JOKER_RANK && cards[1].rank === JOKER_RANK;
}


//判断当前出牌是否合理
function isAllowedCards()
{
    //to do
}
//比较两组牌的大小
function compareCards()
{
    //to do
}
}
