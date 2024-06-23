const { Card, CardSuit, CardPoint, Cards, sortType,PlayHand } = require('./card');
const{Role,Direction,Type,EventEmitter,Player}=require('./player');
const{createDeck}=require('./strategy')

//测试发射信号 player.js
/*function testPlayer()
{
    const player1=new Player("A",Role.Lord,Type.User,false,100);
    const player2=new Player("B",Role.Farmer,Type.Robot,true,200);

    let card = new Card(CardPoint.Point_3, CardSuit.Diamond);
    let cards = new Cards();
    // 添加一些牌
    cards.add(new Card(CardPoint.Point_3, CardSuit.Diamond));
    cards.add(new Card(CardPoint.Point_3, CardSuit.Club));
    cards.add(new Card(CardPoint.Point_3, CardSuit.Heart));
    cards.add(new Card(CardPoint.Point_4, CardSuit.Spade));

    player1.on('grabLordBet', (point)=>{
        console.log(`${player1.getName()} 叫地主点数为 ${point}`);
    });
    player1.on('storeDispatchCard', (card) => {
        console.log(`${player1.getName()} 的存储的卡牌有`, card);
    });
    player1.on('playHand', (cards) => {
        console.log(`${player1.getName()} 的手牌有`, cards);
    });
    //地主点数
    player1.grabLordBet(5);
    //存储的牌
    player1.storeDispatchCard({ rank: 'A', suit: 'Spades' });
    //手牌
    player1.playHand([{ rank: '7', suit: 'Hearts' }, { rank: '8', suit: 'Hearts' }]);

    console.log(player1.getName(),  player1.getType(),  player1.isWin(),player1.getScore());
    console.log(player2.getName(), player2.getType(),  player2.isWin(),player2.getScore());

}
testPlayer();*/

//测试PlayHand类
/*function testPlayHand(){
    let cards = new Cards();
    // 添加一些牌
    cards.add(new Card(CardPoint.Point_3, CardSuit.Diamond));
    cards.add(new Card(CardPoint.Point_3, CardSuit.Club));
    cards.add(new Card(CardPoint.Point_3, CardSuit.Heart));
    cards.add(new Card(CardPoint.Point_4, CardSuit.Spade));

    let playhand=new PlayHand(cards);
    let type = playhand.judgeCardType();
    console.log(`cardtype: ${type}`)
}
testPlayHand();*/
// 测试 Card 类
/*function testCard() {
    // 创建一张牌
    let card = new Card(CardPoint.Point_3, CardSuit.Diamond);
    console.log(`Card: Point ${card.getPoint()}, Suit${card.getSuit()}`);
    if (card.getPoint() === CardPoint.Point_3 && card.getSuit() === CardSuit.Diamond) {
        console.log('Card test passed.');
    } else {
        console.error('Card test failed.');
    }
}

// 测试 Cards 类
function testCards() {
    let cardSet = new Cards();
    // 添加一些牌
    cardSet.add(new Card(CardPoint.Point_3, CardSuit.Diamond));
    cardSet.add(new Card(CardPoint.Point_4, CardSuit.Club));
    cardSet.add(new Card(CardPoint.Point_5, CardSuit.Heart));
    // 测试牌数
    console.log(`Card count: ${cardSet.cardCount()}`);
    if (cardSet.cardCount() === 3) {
        console.log('Cards add and count test passed.');
    } else {
        console.error('Cards add and count test failed.');
    }
    // 测试随机取牌
    let randomCard = cardSet.takeRandomCard();
    if (randomCard) {
        console.log(`Random card: Point ${randomCard.getPoint()}, Suit${randomCard.getSuit()}`);
        console.log('Cards takeRandomCard test passed.');
    } else {
        console.error('Cards takeRandomCard test failed.');
    }
    // 测试清空牌组
    cardSet.clear();
    if (cardSet.isEmpty()) {
        console.log('Cards clear and isEmpty test passed.');
    } else {
        console.error('Cards clear and isEmpty test failed.');
    }
}

// 运行测试
testCard();
testCards();*/
