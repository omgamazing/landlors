const { Card, CardSuit, CardPoint, Cards, sortType,PlayHand } = require('./card');

//洗牌
function shuffleDeck(deck) {
    for (let i = deck.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [deck[i], deck[j]] = [deck[j], deck[i]];
    }
}
// 创建一副54张卡牌
function createDeck() {
    const deck = [];

    // 创建常规的52张牌
    for (let suit in CardSuit) {
        for (let point in CardPoint) {
            if (CardPoint[point] >= 3 && CardPoint[point] <= 15) {
                deck.push({ suit: CardSuit[suit], point: CardPoint[point] });
            }
        }
    }

    // 添加两张王
    deck.push({ suit: 'Joker', point: CardPoint.Point_SJ }); // 小王
    deck.push({ suit: 'Joker', point: CardPoint.Point_BJ }); // 大王

    return deck;
}
const deck = createDeck();
shuffleDeck(deck);
// 打印出所有的卡牌
deck.forEach(card => {
    let suitStr = Object.keys(CardSuit).find(key => CardSuit[key] === card.suit) || card.suit;
    let pointStr = Object.keys(CardPoint).find(key => CardPoint[key] === card.point);
    console.log(`Suit: ${suitStr}, Point: ${pointStr}`);
});

// 需要发送信号：通知已经叫地主下注,通知已经出牌,通知已经发牌了
const Role = {//角色：农民/地主
  Lord: 'Lord',
  Farmer: 'Farmer'
};

const Direction = {//方位：左边ai/右边ai
  Left: 'Left',
  Right: 'Right'
};

const Type = {//玩家类型
  Robot: 'Robot',
  User: 'User',
  UnKnow: 'UnKnow'
};

//事件触发器
class EventEmitter{

    constructor() {
            this.events = {};
        }
    //传入任意数量的参数，转化称数组
        emit(event, ...args) {
            if (this.events[event]) {
                this.events[event].forEach(listener => listener(...args));
            }
        }

        on(event, listener) {
            if (!this.events[event]) {
                this.events[event] = [];
            }
            this.events[event].push(listener);
        }
}
// 分配牌


class Player extends EventEmitter{
    constructor(name,type) {
      super(); // 必须在访问 `this` 之前调用 `super
      this.m_name = name;
      //this.m_role = role;
      //this.m_direction = direction;
      this.m_type = type;
      //this.m_isWin = isWin;//胜利
      //this.m_score=score;
      //this.m_prev = null;//当前玩家的上家
      //this.m_next = null;//当前玩家的下家
      this.m_cards = [];//当前玩家的牌
      this.m_pendCards = new Cards();//获取待出牌玩家的牌
      this.m_pendPlayer = new Cards();}//获取待出牌的玩家
    // 分发扑克牌给玩家
     assignCards(cards) {
       if (this.m_type === Type.User || this.m_type === Type.Robot) {
         this.m_cards.addMultiple(cards);//存储牌
       } else {
         console.log("无法识别的玩家类型");
       }
     }

  getName() {
    return this.m_name;
  }
  getRole() {
    return this.m_role;
  }
  getDirection() {
    return this.m_direction;
  }
  getType() {
    return this.m_type;
  }
  getScore() {
    return this.m_score;
  }
  isWin() {
    return this.m_isWin;
  }
  getPrevPlayer() {
    return this.m_prev;
  }

  getNextPlayer() {
    return this.m_next;
  }
    //获得手上所有的牌
  getCards() {
    return this.m_cards;
  }
    //获取待出牌玩家以及牌
  getPendPlayer() {
    return this.m_pendPlayer;
  }

  getPendCards() {
    return this.m_pendCards;
  }

  clearCards() {
    this.m_cards.clear();
  }
    //叫地主/抢地主
  grabLordBet(point) {
    //发射信号
        this.emit('grabLordBet',point);
  }
    //存储扑克牌 单张
  storeDispatchCard(card) {
    this.m_cards.add(card);
        this.emit('storeDispatchCard',card);
  }
    //存储 多张
  storeDispatchCards(cards) {
    this.m_cards.addMultiple(cards);
  }
    //出牌
  playHand(cards) {
        this.emit('playHand',cards);
  }

    //存储出牌玩家以及牌
  storePendingInfo(player, cards) {
    this.m_pendPlayer = player;
    this.m_pendCards = cards;
  }

  prepareCallLord() {
    // to do
  }

  preparePlayHand() {
    // to do
  }

  thinkCallLord() {
    // to do
  }

  thinkPlayHand() {
    // to do
  }
}

function distributeCards(deck) {
  const userCards = [];
  const robotRightCards = [];
  const robotLeftCards = [];

    // 将牌堆中的牌分配给三个玩家
       while (deck.length > 0) {
           if (deck.length > 0) userCards.push(deck.pop());
           if (deck.length > 0) robotRightCards.push(deck.pop());
           if (deck.length > 0) robotLeftCards.push(deck.pop());
       }

  // 创建三个玩家实例
  const user = new Player('user', Type.User);
  const robotRight = new Player('robotright', Type.Robot);
  const robotLeft = new Player('robotleft', Type.Robot);

  // 为每个玩家分配牌
  user.assignCards(userCards);
  robotRight.assignCards(robotRightCards);
  robotLeft.assignCards(robotLeftCards);
  return { user, robotRight, robotLeft };
}

// 分配牌给三个玩家
const players = distributeCards(deck);

// 打印出每个玩家的牌
console.log("User's cards:");
players.user.getCards().forEach(card => {
    console.log(`Suit: ${card.suit}, Point: ${card.point}`);
});

console.log("RobotRight's cards:");
players.robotRight.getCards().forEach(card => {
    console.log(`Suit: ${card.suit}, Point: ${card.point}`);
});

console.log("RobotLeft's cards:");
players.robotLeft.getCards().forEach(card => {
    console.log(`Suit: ${card.suit}, Point: ${card.point}`);
});

module.exports = {
  Role,
  Direction,
  Type,
  Player
};
