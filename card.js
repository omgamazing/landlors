//创建card属性 point：牌面 suit：花色
//花色 每一项有唯一的整数值
const CardSuit={
    Diamond:0,//菱形
    Club:1, //梅花
    Heart:2, //红心
    Spade:3//黑桃
}
//牌面
const CardPoint={
     Point_3:3,
     Point_4:4,
     Point_5:5,
     Point_6:6,
     Point_7:7,
     Point_8:8,
     Point_9:9,
     Point_10:10,
     Point_J:11,
     Point_Q:12,
     Point_K:13,
     Point_A:14,
     Point_2:15,
     Point_SJ:16,
     Point_BJ:17,
     Point_Unknow:0
}
const sortType={//排序方法 升序 降序 不排
    Asc:'Asc', Desc:'Desc', NoSort:'NoSort'
};
const CardType={
    Single: "Single",//单
    Pair: "Pair",//对子

    Triple: "Triple",//三
    TripleWithSingle: "TripleWithSingle",//三带一
    TripleWithPair: "TripleWithPair",//三带一对

    Plane: "Plane",//飞机
    PlaneWithTwoSingle: "PlaneWithTwoSingle",//飞机带两单
    PlaneWithTwoPair: "PlaneWithTwoPair",//飞机带两队

    Straight: "Straight",//顺子
    StraightWithPair: "StraightWithPair",//连对

    Bomb: "Bomb",//炸弹
    BombWithSingle: "BombWithSingle",//炸弹带一个
    BombWithPair: "BombWithPair",//炸弹带一对
    BombWithTwoSingle: "BombWithTwoSingle",//炸弹带两单

    Jokers: "Jokers",//王炸
    JokersWintSingle: "JokersWintSingle",//王炸带一个
    JokersWithPair: "JokersWithPair",//王炸带一对
    JokersWithTwoSingle: "JokersWithTwoSingle",//王炸带两单

    Unknown: "Unknown",//未知
    Pass: "Pass"//过
}

class Card {
    constructor(point,suit){
        this.point=point;
        this.suit=suit;
    }
    getPoint(){
        return this.point;
    };
    getSuit(){
        return this.suit;
    }

//比较牌面大小
    lessSort(c1, c2) {
    if (c1.getPoint() !== c2.getPoint()) {
        return c1.getPoint() < c2.getPoint();
    } else {
        return c1.getSuit() < c2.getSuit();
    }
}
//获取大牌
     greaterSort(c1, c2) {
    if (c1.getPoint() !== c2.getPoint()) {
        return c1.getPoint() > c2.getPoint();
    } else {
        return c1.getSuit() > c2.getSuit();
    }
}
}
//cards
class Cards {
    constructor() {
    this.m_cards = new Set();  // 确保元素唯一
}
    // 添加一张卡牌
    add (card) {
        this.m_cards.add(card);
    };

    // 添加多张卡牌
    addMultiple (cards) {
        this.m_cards = cards.concat(cards);
       // cards.forEach(card => this.m_cards.add(card));
    };

    // 删除一张卡牌
    remove(card) {
        this.m_cards.delete(card);
    };

    // 删除多张卡牌
    removeMultiple(cards) {
        cards.forEach(card => this.m_cards.delete(card));
    };

    // 获取卡牌数量
    cardCount() {
        return this.m_cards.size;
    };

    // 是否为空
    isEmpty () {
        return this.m_cards.size === 0;
    };

    // 清空卡牌
    clear () {
        this.m_cards.clear();
    };

    // 随机取出一张卡牌
    takeRandomCard () {
        let cardsArray = Array.from(this.m_cards);
        if(cardsArray.length===0){
            return null;
        }

        let randomIndex = Math.floor(Math.random() * cardsArray.length);
        let randomCard = cardsArray[randomIndex];
        this.m_cards.delete(randomCard);  // 从集合中移除这张牌
        return randomCard;
    };

    // 将卡牌转换为数组，并排序
    toCardList (sortType) {
        let cardsArray = Array.from(this.m_cards);
        if (sortType === 'Asc') {
            cardsArray.sort((a, b) => a.getPoint() - b.getPoint());
            } else if (sortType === 'Desc') {
            cardsArray.sort((a, b) => b.getPoint() - a.getPoint());
            }
        return cardsArray;
    };

   /*// 测试函数，打印所有卡牌信息
    printAllCardInfo() {
        this.m_cards.forEach(card => {
            console.log(`Suit: ${card.getSuit()}, Rank: ${card.getPoint()}`);
        });
    };*/
}

//牌的类型
class PlayHand{
    constructor(cards) {
        this.cards=cards;
        }
    toCardList(sortType){//将卡牌转换为数组，并排序
        let sortedCards = this.cards.toCardList(sortType);
        return sortedCards;
    }

    judgeCardType(){
        let cardArray=this.toCardList(sortType.NoSort)//
        cardArray.sort((a,b)=>a.getPoint()-b.getPoint());

        const cardCount=cardArray.length;//记录长度

        switch (cardCount) {
                case 1:
                    {console.log(`cardtype:Single `)
                    return CardType.Single;} // 单排}
                case 2:
                    if (this.isPair(cardArray))
                    return CardType.Pair; //对子
                    break;
                case 3:
                    if (this.isTriple(cardArray))
                    return CardType.Triple; // 三张
                    break;
                case 4:
                    if (this.isBomb(cardArray))
                            return CardType.Bomb; // 炸弹
                    if (this.isTripleWithSingle(cardArray))
                            return CardType.TripleWithSingle; // 三带一
                    if (this.isPlane(cardArray))
                            return CardType.Plane; // 飞机
                            break;
                default:
                    if (this.isStraight(cardArray))
                            return CardType.Straight; // 顺子
                    if (this.isStraightWithPair(cardArray))
                            return CardType.StraightWithPair; // 连队
                    if (this.isPlaneWithTwoSingle(cardArray))
                            return CardType.PlaneWithTwoSingle; // 飞机带两张单排
                    if (this.isPlaneWithTwoPair(cardArray))
                            return CardType.PlaneWithTwoPair; // 飞机带两对
                        break;
                }
        return CardType.Unknown;
    }
    isPair(cards) {
            return cards.length === 2 && cards[0].getPoint() === cards[1].getPoint();
    }

    isTriple(cards) {
            return cards.length === 3 && cards[0].getPoint() === cards[1].getPoint() && cards[1].getPoint() === cards[2].getPoint();
    }

    isBomb(cards) {
            return cards.length === 4 && cards[0].getPoint() === cards[1].getPoint() && cards[1].getPoint() === cards[2].getPoint() && cards[2].getPoint() === cards[3].getPoint();
    }

    isTripleWithSingle(cards) {
            if (cards.length !== 4) return false;
            let pointCounts = this.countPoints(cards);
            return pointCounts.length === 2 && pointCounts[0].count === 3 && pointCounts[1].count === 1;
    }

    isPlane(cards) {
            if (cards.length < 6 || cards.length % 3 !== 0) return false;
            let pointCounts = this.countPoints(cards);
            return pointCounts.every(count => count.count === 3);
    }

    isStraight(cards) {
            if (cards.length < 5) return false;
            for (let i = 1; i < cards.length; i++) {
                if (cards[i].getPoint() !== cards[i - 1].getPoint() + 1) {
                    return false;
                }
            }
            return true;
    }

    isStraightWithPair(cards) {
            if (cards.length < 6 || cards.length % 2 !== 0) return false;
            let sortedCards = cards.slice().sort((a, b) => a.getPoint() - b.getPoint());
            for (let i = 0; i < sortedCards.length - 1; i += 2) {
                if (sortedCards[i].getPoint() !== sortedCards[i + 1].getPoint() || (i > 0 && sortedCards[i].getPoint() !== sortedCards[i - 1].getPoint() + 1)) {
                    return false;
                }
            }
            return true;
    }

    isPlaneWithTwoSingle(cards) {
            if (cards.length < 8 || cards.length % 4 !== 0) return false;
            let pointCounts = this.countPoints(cards);
            let tripleCount = 0;
            let singleCount = 0;
            for (let count of pointCounts) {
                if (count.count === 3) tripleCount++;
                else if (count.count === 1) singleCount++;
                else return false;
            }
            return tripleCount * 3 === cards.length && singleCount === tripleCount * 2;
    }

    isPlaneWithTwoPair(cards) {
            if (cards.length < 10 || cards.length % 5 !== 0) return false;
            let pointCounts = this.countPoints(cards);
            let tripleCount = 0;
            let pairCount = 0;
            for (let count of pointCounts) {
                if (count.count === 3) tripleCount++;
                else if (count.count === 2) pairCount++;
                else return false;
            }
            return tripleCount * 3 === cards.length && pairCount === tripleCount * 2;
    }
    //统计一组 cards 中每个point出现的次数，并返回这些点数以及对应的出现次数的数组。按照出现次数从高到低排序结果
    countPoints(cards) {
            let pointCounts = [];
            cards.forEach(card => {
                let existingCount = pointCounts.find(count => count.point === card.getPoint());
                if (existingCount) {
                    existingCount.count++;
                } else {
                    pointCounts.push({ point: card.getPoint(), count: 1 });
                }
            });
            return pointCounts.sort((a, b) => b.count - a.count); // Sort by count descending
    }

}

module.exports = {
  Card,
  CardSuit,
  CardPoint,
  Cards,
  sortType,
  PlayHand
};
