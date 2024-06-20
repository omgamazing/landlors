import QtQuick 2.0
Item {
    ListModel{
            id: cardModel
        }
    // 初始化牌堆数据
    Component.onCompleted: {
        initializeDeck()
        shuffleDeck()
        dealCards()
    }


    // 初始化牌堆：生成一副包括 A-K 的四种花色和大小王的54张牌
    function initializeDeck() {

        var suits = ["1", "2", "3", "4"]
        for (var s = 0; s < suits.length; ++s) {
            for (var r = 1; r <= 13; ++r) {
                cardModel.append(Card.suit=s+1,Card.rank=r)
            }
        }
        // 添加大小王
        cardModel.append(Card.suit="",Card.rank=14)
        cardModel.append(Card.suit="",Card.rank=15)

        console.log("所有牌的信息:");
                for (var i = 0; i < 54; i++) {
                    console.log("花色:", cards[i].suit, " 牌面:", cards[i].rank);
                }
    }

    //洗牌：每次迭代生成一个随机整数 j，该整数满足 [0,i)。这个随机整数 j 用来确定当前元素 i 要移动到的位置。
    //cardModel.move(i, j) ：数组中索引为 i 的元素移动到索引为 j 的位置上
    function shuffleDeck() {
        for (var i = cardModel.count - 1; i > 0; --i) {
            var j = Math.floor(Math.random() * (i + 1))
            cardModel.move(i, j)
        }
        console.log("所有牌的信息:");
                for (var e = 0; e < 54; e++) {
                    console.log("花色:", cards[e].suit, " 牌面:", cards[e].rank);
                }
    }

    //排序（待实现）：对玩家手中的牌进行排序，根据♠、♥、♣、⬛的顺序排列
    function sortCards(){
        cardModel.sort(function(card1, card2) {
                   // 比较花色
                   if (card1.suit !== card2.suit) {
                       // 按照花色顺序排序，可以自定义花色顺序
                       var suitsOrder = ['Spades', 'Hearts', 'Clubs','Diamonds' ];  // 按照黑桃、红心、方块、梅花的顺序排序
                       return suitsOrder.indexOf(card1.suit) - suitsOrder.indexOf(card2.suit);
                   } else {
                       // 如果花色相同，比较大小
                       var ranksOrder = ['3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A', '2'];  // 按照从3到2的顺序排序
                       return ranksOrder.indexOf(card1.rank) - ranksOrder.indexOf(card2.rank);
                   }
               });

    }


    //发牌(待实现)：玩家拥有哪些牌，机器人拥有哪些
    //发牌特效：逆时针旋转，由玩家开始，依次发牌，每人17张，最后三张留作底牌，并扣上
    //发牌规则：按照数组下标，给每个人增加一张牌，对于玩家而言，每次发一张牌就得重新排序
    //大概思路：分为4个牌堆（三个玩家+地主），
    function dealCards() {

}
}
