import QtQuick

Item {
    Repeater{
        id:cardRepeater
    }

    property var cards: []
    //添加单张牌
    function addCard(suit,rank)
    {
        cards.push({suit:suit,rank:rank})
        updateCards();
        console.log("已添加牌面为："+suit," 牌值为："+rank+"的牌")
    }
    //添加多张牌
    function addCards(newCards)
    {
        cards = cards.concat(newCards);
        updateCards();
        console.log("已完成多张牌的添加");
    }
    //移除单张牌
    function removeCard(suit,rank)
    {
        const index = findCardIndex(suit, rank);
        if (index !== -1) {
            cards.splice(index, 1);
            console.log("已删除牌面为：" + suit, " 牌值为：" + rank);
            updateCards();}
    }
    //删除多张牌
    function removeCards(removalCards)
    {
        removalCards.forEach(card => removeCard(card.suit, card.rank));
        updateCards();
        console.log("已完成多张牌的删除");
    }
    // 查找卡牌索引
    function findCardIndex(suit, rank)
    {
        return cards.findIndex(card => card.suit === suit && card.rank === rank);
    }
    //牌的张数
    function cardCount() {
        return cards.length;
    }
    function isEmpty()
    {
        return cards.length===0
    }

    //清空牌
    function clear()
    {
        cards=[]
        updateCards();
        console.log("清空！")
    }

    //检查牌是否存在,卡的下标存在就存在
    function containsCard(suit, rank)
    {
            return findCardIndex(suit, rank) !== -1;
    }
    //找出cards最大的点数
    function maxPoint()
    {
            if (cards.length === 0) return null;
            var max = cards[0].rank;
            for (var i = 1; i < cards.length; i++) {
                if (cards[i].rank > max) {
                    max = cards[i].rank;
                }
            }
            console.log("最小点数：",max)
            return max;
    }
    //找出cards最小的点数
    function minPoint()
    {
            if (cards.length === 0) return null;
            var min = cards[0].rank;
            for (var i = 1; i < cards.length; i++) {
                if (cards[i].rank < min) {
                    min = cards[i].rank;
                }
            }
            console.log("最小点数：",min)
            return min;
    }
    //打印所有卡牌信息
    function printAllCardInfo()
    {
            console.log("All cards:");
            for (var i = 0; i < cards.length; i++)
            {
                console.log(cards[i].suit + " " + cards[i].rank);
            }
    }
    //打乱卡牌的元素顺序
    function shuffleArray(array)
    {
        for (let i = array.length - 1; i > 0; i--) {
            let j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
        updateCards();
       }
    //从中随即取出一张随即的卡牌
       function takeRandomCard()
       {
           if (cards.length === 0) return null;
           shuffleArray(cards);
           return cards.pop();
       }

       //更新卡牌
       function updateCards()
       {
           cardRepeater.model = cards;
           console.log("更新卡牌!")
       }

       /*Component.onCompleted: {
               // 创建并添加一些卡片
               var newCards = [
                   {suit: 1, rank: 6},
                   {suit: 2, rank: 7},
                   {suit: 4, rank: 13}
               ];
               addCards(newCards);
               // 创建移除卡片的数组
               var removalCards = [
                   {suit: "Spades", rank: 3}
               ];
               removeCards(removalCards);

               // 打印所有卡片信息
               printAllCardInfo();
           minPoint()
           removeCard(1,6)
           }*/
}
