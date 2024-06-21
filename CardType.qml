//牌类型的定义，或许类型大小的比较可以写里面
//比较自己手上的牌与其他人的牌的大小
//判断牌的类型
//对牌进行分类
import QtQuick

Item {
    //牌型20种
    readonly property string single: "single"//单
    readonly property string two: "two"//对子

    readonly property string triple: "triple"//三
    readonly property string tripleWithOne: "tripleWithOne"//三带一
    readonly property string tripleWithTwo: "tripleWithTwo"//三带一对

    readonly property string plane: "plane"//飞机
    readonly property string planeWithTwoSingle: "planeWithTwoSingle"//飞机带两单
    readonly property string planeWithTwoDouble: "planeWithTwoDouble"//飞机带两队

    readonly property string straight: "straight"//顺子
    readonly property string straightWithDouble: "straightWithDouble"//连对

    readonly property string bomb: "bomb"//炸弹
    readonly property string bombWithOne: "bomb"//炸弹带一个
    readonly property string bombWithPair: "bomb"//炸弹带一对
    readonly property string bombWithTwoSingle: "bomb"//炸弹带两单

    readonly property string jokers: "jokers"//王炸
    readonly property string jokersWintOne: "jokers"//王炸带一个
    readonly property string jokersWithPair: "jokers"//王炸带一对
    readonly property string jokersWithTwoSingle: "jokers"//王炸带两单

    readonly property string unknow: "unknow"//未知
    readonly property string pass: "pass"//过

    property string m_type: "unknow"//存储当前牌型
    property int m_pt: -1//存储当前牌型点数，用于同类型牌的比较
    property int extra: 0//记录牌数量

    //存储不同牌型
    property var m_oneCard: []//1
    property var m_twoCard: []//2
    property var m_threeCard: []//3 三带
    property var m_fourCard: []//4

    //获取牌的张数，统计各种点数的牌出现的次数，以便判断牌的类型
    function classify(cards)
    {
        var cardRecord = new Array(15).fill(0);//获取每一次牌面的值，将牌面的值放在一起
        //获取牌的数量
        for (var i = 0; i < cards.length; ++i)
        {
            var point = cards[i].rank//将牌面放进point容器
            cardRecord[point]++;
        }
            m_oneCard = [];
            m_twoCard = [];
            m_threeCard = [];
            m_fourCard = [];
        //获取数量之后，将牌放入对应的容器里面
            for (var i = 0; i < cardRecord.length; ++i) {
                if (cardRecord[i] === 1) {
                    m_oneCard.push(i);
                } else if (cardRecord[i] === 2) {
                     m_twoCard.push(i);
                 } else if (cardRecord[i] === 3) {
                     m_threeCard.push(i);
                } else if (cardRecord[i] === 4) {
                     m_fourCard.push(i);
                }
        }
    }

       // return {oneCard,twoCard,threeCard,fourCard};
    //判断牌的类型(没有传递参数，不能验证)
    function judgeCardType() {
        m_type =  CardType.unknow
        m_pt = -1;
        m_extra = 0;//记录牌数量

        if (isPass()) {
                m_type=CardType.pass;
            console.log("Hand Type:", m_type);
            } else if (isSingle()) {
                m_type=CardType.single;
                m_pt=m_oneCard[0]
            console.log("Hand Type:", m_type);
            } else if (isPair()) {
                m_type=CardType.two;
                m_pt= m_twoCard[0];
            console.log("Hand Type:", m_type);
            } else if (isTriple()) {
                m_type=CardType.triple;
                m_pt=m_threeCard[0];
            console.log("Hand Type:", m_type);
            } else if (isTripleSingle()) {
                m_type=CardType.tripleWithOne;
                m_pt=m_threeCard[0];
            console.log("Hand Type:", m_type);
            } else if (isTriplePair()) {
                m_type=CardType.tripleWithTwo;
                m_pt=m_threeCard[0];
            console.log("Hand Type:", m_type);
            } else if (isPlane()) {
                m_type=CardType.plane;
                m_pt=m_threeCard[0];
            console.log("Hand Type:", m_type);
            } else if (isPlaneTwoSingle()) {
                m_type=CardType.planeWithTwoSingle;
                m_pt=m_threeCard[0];
            console.log("Hand Type:", m_type);
            } else if (isPlaneTwoPair()) {
                m_type=CardType.planeWithTwoDouble;
                m_pt=m_threeCard[0];
            console.log("Hand Type:", m_type);
            } else if (isSeqPair()) {
                m_type=CardType.straightWithDouble;
                m_pt=m_twoCard[0];
                m_extra =m_twoCard.length;
            console.log("Hand Type:", m_type);
            } else if (isSeqSingle()) {
                m_type=CardType.straight;
                m_pt=m_oneCard[0];
                m_extra =m_oneCard.length;
            console.log("Hand Type:", m_type);
            } else if (isBomb()) {
                m_type=CardType.bomb;
                m_pt=m_fourCard[0];
            console.log("Hand Type:", m_type);
            } else if (isBombPair()) {
                m_type=CardType.bombWithPair;
                m_pt=m_fourCard[0];
            console.log("Hand Type:", m_type);
            } else if (isBombTwoSingle()) {
                m_type=CardType.bombWithTwoSingle;
                m_pt=m_fourCard[0];
            console.log("Hand Type:", m_type);
            } else if (isBombJokers()) {
                m_type=CardType.jokers;
            console.log("Hand Type:", m_type);
            } else if (isBombJokersSingle()) {
                m_type=CardType.jokersWithOne;
            console.log("Hand Type:", m_type);
            } else if (isBombJokersPair()) {
                m_type=CardType.jokersWithPair;
            console.log("Hand Type:", m_type);
            } else if (isBombJokersTwoSingle()) {
                m_type=CardType.jokersWithTwoSingle;
            console.log("Hand Type:", m_type);
            }
   }
    //过牌
    function isPass()
    {
         return m_oneCard.length === 0 && m_twoCard.length === 0 && m_threeCard.length === 0 && m_fourCard.length === 0;
    }

    function getHandType() { return m_type; }//获取手牌类型
    function getCardPoint() { return m_pt; }//获取点数类型
    function getExtra() { return m_extra; }//记录牌的数量

    //判断当前的牌是否能打出去
    function canBeat(other)//传别人的牌
    {
            if (m_type === CardType.unknow) {
                return false;
            }
            //对方放弃出牌
            if (other.m_type === CardType.pass) {
                return true;
            }
            if (m_type === CardType.jokers) {//王炸
                return true;
            }
            //if (m_type === CardType.bomb && other.m_type >= CardType.single && other.m_type <= CardType.straight)
            if (m_type === CardType.bomb && other.m_type!==CardType.bomb&&other.m_type!==CardType.jokers) {
                return true;
            }
            //如果牌的类型相同，就比较m_pt和 m_extra
            if (m_type === other.m_type) {
                if (m_type === CardType.straightWithDouble || m_type === CardType.straight) {
                    return m_pt > other.m_pt && m_extra === other.m_extra;
                } else {
                    return m_pt > other.m_pt;
                }
            }
            return false;
    }
        //验证
    Component.onCompleted:{
            var cards = [
                {suit: 5, rank: 17},//王炸检测不了
                {suit: 5, rank: 16},
                {suit: 1, rank: 13},
                {suit: 1, rank: 5},//三个5
                {suit: 2, rank: 5},
                {suit: 3, rank: 5},
                {suit: 3, rank: 13},
            ];
            classify(cards);//给cards分类

            console.log("one card",m_oneCard)
            console.log("two card",m_twoCard)
            console.log("three card",m_threeCard)
            console.log("four card",m_fourCard)
    }

        function isSingle()
        {
            if (m_oneCard.length === 1 && m_twoCard.length === 0 && m_threeCard.length === 0 &&m_fourCard.length === 0) {
                console.log("single牌");
                   return true;
               }
               return false;
          }
        function isPair()
        {
            if (m_oneCard.length === 0 && m_twoCard.length === 1 && m_threeCard.length === 0 &&
                    m_fourCard.length === 0) {
                console.log("pair牌");
                    return true;
                }
                return false;
          }
        function isTriple() {
            if (m_oneCard.length === 0 && m_twoCard.length === 0 && m_threeCard.length === 1 &&
                   m_fourCard.length === 0) {
                console.log("triple牌");
                   return true;
               }
               return false;
          }
        function isTripleSingle() {
            if (m_oneCard.length === 1 && m_twoCard.length === 0 && m_threeCard.length === 1 &&
                   m_fourCard.length === 0) {
                console.log("triplesingle牌");
                   return true;
               }
               return false;
          }
        function isTriplePair() {
            if (m_oneCard.length === 0 && m_twoCard.length === 1 && m_threeCard.length === 1 &&m_fourCard.length === 0) {
                console.log("triplepair牌");
                    return true;
                }
                return false;
          }
        function isPlane() {
            if (m_oneCard.length === 0 && m_twoCard.length === 0 && m_threeCard.length === 2 && m_fourCard.length === 0) {
                        m_threeCard.sort((a, b) => a - b);
                        if (m_threeCard[1] - m_threeCard[0] === 1 && m_threeCard[1] < Card_2) {
                            console.log("plane牌");
                            return true;
                        }
                    }
                    return false;
          }
        function isPlaneTwoSingle() {
            if (m_oneCard.length === 2 && m_twoCard.length === 0 && m_threeCard.length === 2 &&m_fourCard.length === 0) {
                        m_threeCard.sort((a, b) => a - b);
                        m_oneCard.sort((a, b) => a - b);
                //if (m_threeCard[1] - m_threeCard[0] === 1 && m_threeCard[1] < Card_2 &&m_oneCard[0] !== Card_SJ && m_oneCard[1] !== Card_BJ)
                        if (m_threeCard[1] - m_threeCard[0] === 1 &&m_oneCard[0] !== 17 && m_oneCard[1] !== 16) {//判断单牌不为大小王
                            console.log("PlaneTwoSingle牌");
                            return true;
                        }
                    }
                    return false;
          }
        function isPlaneTwoPair() {
            if (m_oneCard.length === 0 && m_twoCard.length === 2 && m_threeCard.length === 2 &&m_fourCard.length === 0) {
                       m_threeCard.sort((a, b) => a - b);
                       if (m_threeCard[1] - m_threeCard[0] === 1 ) {
                           console.log("PlaneTwoPair牌");
                           return true;
                       }
                   }
                   return false;
          }
        function isSeqPair() {
            if (m_oneCard.length === 0 && m_twoCard.length >= 3 && m_threeCard.length === 0 &&m_fourCard.length === 0) {
                        m_twoCard.sort((a, b) => a - b);
                //if (m_twoCard[m_twoCard.length - 1] - m_twoCard[0] === (m_twoCard.length - 1) &&m_twoCard[0] >= Card_3 && m_twoCard[m_twoCard.length - 1] < Card_2)
                        if (m_twoCard[m_twoCard.length - 1] - m_twoCard[0] === (m_twoCard.length - 1) ) {
                            console.log("SeqPair牌");
                            return true;
                        }
                    }
                    return false;
          }
        function isSeqSingle() {
            if (m_oneCard.length >= 5 && m_twoCard.length === 0 && m_threeCard.length === 0 &&
                        m_fourCard.length === 0) {
                        m_oneCard.sort((a, b) => a - b);
                //if (m_oneCard[m_oneCard.length - 1] - m_oneCard[0] === (m_oneCard.length - 1) &&m_oneCard[0] >= Card_3 && m_oneCard[m_oneCard.length - 1] < Card_2)
                        if (m_oneCard[m_oneCard.length - 1] - m_oneCard[0] === (m_oneCard.length - 1) ) {
                            console.log("SeqSingle牌");
                            return true;
                        }
                    }
                    return false;
          }
        function isBomb() {
            if (m_oneCard.length === 0 && m_twoCard.length === 0 && m_threeCard.length === 0 &&m_fourCard.length === 1) {
                console.log("Bomb牌");
                       return true;
                   }
                   return false;
          }
        function isBombSingle() {
            if (m_oneCard.length === 1 && m_twoCard.length === 0 && m_threeCard.length === 0 &&m_fourCard.length === 1) {
                console.log("Bombsingle牌");
                        return true;
                    }
                    return false;
          }
        function isBombPair() {
            if (m_oneCard.length === 0 && m_twoCard.length === 1 && m_threeCard.length === 0 &&m_fourCard.length === 1) {
                console.log("BombPair牌");
                        return true;
                    }
                    return false;
          }
        function isBombTwoSingle() {
            if (m_oneCard.length === 2 && m_twoCard.length === 0 && m_threeCard.length === 0 &&m_fourCard.length === 1) {
                       m_oneCard.sort((a, b) => a - b);
                //if (m_oneCard[0] !== Card_SJ && m_oneCard[1] !== Card_BJ)
                       if (m_oneCard[0] !== 16 && m_oneCard[1] !==17) {
                           console.log("BombTwoSingle牌");
                           return true;
                       }
                   }
                   return false;
          }
        function isBombJokers() {
            if (m_oneCard.length === 2 && m_twoCard.length === 0 && m_threeCard.length === 0 &&m_fourCard.length === 0) {
                        m_oneCard.sort((a, b) => a - b);
                        if (m_oneCard[0] === 16 && m_oneCard[1] === 17) {
                            console.log("BombJokers牌");
                            return true;
                        }
                    }
                    return false;
          }
        function isBombJokersSingle() {
            if (m_oneCard.length === 3 && m_twoCard.length === 0 && m_threeCard.length === 0 &&m_fourCard.length === 0) {
                       m_oneCard.sort((a, b) => a - b);
                       if (m_oneCard[1] === 16 && m_oneCard[2] === 17) {
                           console.log("BombJokersSingle牌");
                           return true;
                       }
                   }
                   return false;
          }
        function isBombJokersPair() {
            if (m_oneCard.length === 2 && m_twoCard.length === 1 && m_threeCard.length === 0 &&m_fourCard.length === 0) {
                        m_oneCard.sort((a, b) => a - b);
                        if (m_oneCard[0] === 16 && m_oneCard[1] === 17) {
                            console.log("BombJokersPair牌");
                            return true;
                        }
                    }
                    return false;
          }
        function isBombJokersTwoSingle() {
            if (m_oneCard.length === 4 && m_twoCard.length === 0 && m_threeCard.length === 0 &&m_fourCard.length === 0) {
                        m_oneCard.sort((a, b) => a - b);
                        if (m_oneCard[2] === 16 && m_oneCard[3] ===17) {
                            console.log("BombJokersTwoSingle牌");
                            return true;
                        }
                    }
                    return false;
          }
}
