//定义牌的花色与大小，与图片进行绑定  牌的定义与图片png相关
//suit花色：1 黑桃 2：红桃 3：梅花 4：红心 5：大小王
//rank牌面：3-10：3-10 J：11 Q：12 K：13 小鬼：14 大鬼：15
//1,比较单张牌的大小：从小到大，从大到小，是否相等

import QtQuick
Item {

    property int suit // 花色 赋初值
    property int rank // 牌面

    //用于使用时更新
    function setRank(newRank)
    {
            rank = newRank
    }
    function setSuit(newSuit)
    {
            suit = newSuit
    }
    //比较单张牌的大小
    function compareSingleBig(card1,card2)
    {
        if(card1.rank===card2.rank)
        {
            return card1.suit<card2.suit;
        }else
        {
            return card1.rank<card2.rank;
        }
    }
    function compareSingleSmall(card1,card2)
    {
        if(card1.rank===card2.rank)
        {
            return card1.suit>card2.suit;
        }else
        {
            return card1.rank>card2.rank;
        }
    }
    //从小到达排序
    function singleCardSort(card1, card2) {

        return compareSingleSmall(card1, card2)
    }
    //判断是否相等
    function isEqual(card1,card2)
    {
        return card1.rank===card2.rank&&card1.suit===card2.suit
    }
    //快速找到函数对象，将card映射到整数数组
    function qHash(card)
    {
        return card.point * 100 + card.suit
    }

// 根据花色和牌面大小返回牌的图片路径
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

