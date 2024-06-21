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
    property int m_pt: -1//存储当前牌型点数
    property int extra: 0//记录牌数量

    property list<int> m_oneCard: []//1
    property list<int> m_twoCard: []//2
    property list<int> m_threeCard: []//3 三带
    property list<int> m_fourCard: []//4

    //获取牌的张数，统计各种点数的牌出现的次数，以便判断牌的类型
    function classify(cards)
    {
        var cardRecord = new Array(15).fill(0);
        //获取牌的数量
        for (var i = 0; i < cards.length; ++i)
        {
            var point = cards[i].point;
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
            //console.log("one card",oneCard)
            //console.log("two card",twoCard)
            //console.log("three card",threeCard)
            //console.log("four card",fourCard)
       // return {oneCard,twoCard,threeCard,fourCard};
    //判断牌的类型
    function judgeCardType() {
        m_type =  CardType.unknow
        m_pt = -1;
        m_extra = 0;//记录牌数量

        if (isPass()) {
                setCardType(CardType.pass);
            } else if (isSingle()) {
                setCardType(CardType.single, m_oneCard[0]);
            } else if (isPair()) {
                setCardType(CardType.two, m_twoCard[0]);
            } else if (isTriple()) {
                setCardType(CardType.triple, m_threeCard[0]);
            } else if (isTripleSingle()) {
                setCardType(CardType.tripleWithOne, m_threeCard[0]);
            } else if (isTriplePair()) {
                setCardType(CardType.tripleWithTwo, m_threeCard[0]);
            } else if (isPlane()) {
                setCardType(CardType.plane, m_threeCard[0]);
            } else if (isPlaneTwoSingle()) {
                setCardType(CardType.planeWithTwoSingle, m_threeCard[0]);
            } else if (isPlaneTwoPair()) {
                setCardType(CardType.planeWithTwoDouble, m_threeCard[0]);
            } else if (isSeqPair()) {
                setCardType(CardType.straightWithDouble, m_twoCard[0], m_twoCard.length);
            } else if (isSeqSingle()) {
                setCardType(CardType.straight, m_oneCard[0], m_oneCard.length);
            } else if (isBomb()) {
                setCardType(CardType.bomb, m_fourCard[0]);
            } else if (isBombPair()) {
                setCardType(CardType.bombWithPair, m_fourCard[0]);
            } else if (isBombTwoSingle()) {
                setCardType(CardType.bombWithTwoSingle, m_fourCard[0]);
            } else if (isBombJokers()) {
                setCardType(CardType.jokers);
            } else if (isBombJokersSingle()) {
                setCardType(CardType.jokersWithOne);
            } else if (isBombJokersPair()) {
                setCardType(CardType.jokersWithPair);
            } else if (isBombJokersTwoSingle()) {
                setCardType(CardType.jokersWithTwoSingle);
            }
   }
    function setCardType(type, pt = -1, extra = 0) {
        m_type = type;
        m_pt = pt;
        m_extra = extra;
    }
    function isPass()
    {
         return m_oneCard.length === 0 && m_twoCard.length === 0 && m_threeCard.length === 0 && m_fourCard.length === 0;
    }

    function getHandType() { return m_type; }//获取手牌类型
    function getCardPoint() { return m_pt; }//获取点数类型
    function getExtra() { return m_extra; }
        //判断当前的牌是否能打出去
        function canBeat(other)
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
            if (m_type === CardType.bomb && other.m_type >= CardType.single && other.m_type <= CardType.straight) {
                return true;
            }
            if (m_type === other.m_type) {
                if (m_type === CardType.straightWithDouble || m_type === CardType.straight) {
                    return m_pt > other.m_pt && m_extra === other.m_extra;
                } else {
                    return m_pt > other.m_pt;
                }
            }
            return false;
        }

        function isSingle()
        {
            if (m_oneCard.length === 1 && m_twoCard.length === 0 && m_threeCard.length === 0 &&
                   m_fourCard.length === 0) {
                   return true;
               }
               return false;
          }
        function isPair()
        {
            if (m_oneCard.length === 0 && m_twoCard.length === 1 && m_threeCard.length === 0 &&
                    m_fourCard.length === 0) {
                    return true;
                }
                return false;
          }
        function isTriple() {
            if (m_oneCard.length === 0 && m_twoCard.length === 0 && m_threeCard.length === 1 &&
                   m_fourCard.length === 0) {
                   return true;
               }
               return false;
          }
        function isTripleSingle() {
            if (m_oneCard.length === 1 && m_twoCard.length === 0 && m_threeCard.length === 1 &&
                   m_fourCard.length === 0) {
                   return true;
               }
               return false;
          }
        function isTriplePair() {
            if (m_oneCard.length === 0 && m_twoCard.length === 1 && m_threeCard.length === 1 &&m_fourCard.length === 0) {
                    return true;
                }
                return false;
          }
        function isPlane() {
            if (m_oneCard.length === 0 && m_twoCard.length === 0 && m_threeCard.length === 2 &&
                        m_fourCard.length === 0) {
                        m_threeCard.sort((a, b) => a - b);
                        if (m_threeCard[1] - m_threeCard[0] === 1 && m_threeCard[1] < Card_2) {
                            return true;
                        }
                    }
                    return false;
          }
        function isPlaneTwoSingle() {
            if (m_oneCard.length === 2 && m_twoCard.length === 0 && m_threeCard.length === 2 &&
                        m_fourCard.length === 0) {
                        m_threeCard.sort((a, b) => a - b);
                        m_oneCard.sort((a, b) => a - b);
                        if (m_threeCard[1] - m_threeCard[0] === 1 && m_threeCard[1] < Card_2 &&
                            m_oneCard[0] !== Card_SJ && m_oneCard[1] !== Card_BJ) {
                            return true;
                        }
                    }
                    return false;
          }
        function isPlaneTwoPair() {
            if (m_oneCard.length === 0 && m_twoCard.length === 2 && m_threeCard.length === 2 &&
                       m_fourCard.length === 0) {
                       m_threeCard.sort((a, b) => a - b);
                       if (m_threeCard[1] - m_threeCard[0] === 1 && m_threeCard[1] < Card_2) {
                           return true;
                       }
                   }
                   return false;
          }
        function isSeqPair() {
            if (m_oneCard.length === 0 && m_twoCard.length >= 3 && m_threeCard.length === 0 &&
                        m_fourCard.length === 0) {
                        m_twoCard.sort((a, b) => a - b);
                        if (m_twoCard[m_twoCard.length - 1] - m_twoCard[0] === (m_twoCard.length - 1) &&
                            m_twoCard[0] >= Card_3 && m_twoCard[m_twoCard.length - 1] < Card_2) {
                            return true;
                        }
                    }
                    return false;
          }
        function isSeqSingle() {
            if (m_oneCard.length >= 5 && m_twoCard.length === 0 && m_threeCard.length === 0 &&
                        m_fourCard.length === 0) {
                        m_oneCard.sort((a, b) => a - b);
                        if (m_oneCard[m_oneCard.length - 1] - m_oneCard[0] === (m_oneCard.length - 1) &&
                            m_oneCard[0] >= Card_3 && m_oneCard[m_oneCard.length - 1] < Card_2) {
                            return true;
                        }
                    }
                    return false;
          }
        function isBomb() {
            if (m_oneCard.length === 0 && m_twoCard.length === 0 && m_threeCard.length === 0 &&
                       m_fourCard.length === 1) {
                       return true;
                   }
                   return false;
          }
        function isBombSingle() {
            if (m_oneCard.length === 1 && m_twoCard.length === 0 && m_threeCard.length === 0 &&
                        m_fourCard.length === 1) {
                        return true;
                    }
                    return false;
          }
        function isBombPair() {
            if (m_oneCard.length === 0 && m_twoCard.length === 1 && m_threeCard.length === 0 &&
                        m_fourCard.length === 1) {
                        return true;
                    }
                    return false;
          }
        function isBombTwoSingle() {
            if (m_oneCard.length === 2 && m_twoCard.length === 0 && m_threeCard.length === 0 &&
                       m_fourCard.length === 1) {
                       m_oneCard.sort((a, b) => a - b);
                       if (m_oneCard[0] !== Card_SJ && m_oneCard[1] !== Card_BJ) {
                           return true;
                       }
                   }
                   return false;
          }
        function isBombJokers() {
            if (m_oneCard.length === 2 && m_twoCard.length === 0 && m_threeCard.length === 0 &&
                        m_fourCard.length === 0) {
                        m_oneCard.sort((a, b) => a - b);
                        if (m_oneCard[0] === Card_SJ && m_oneCard[1] === Card_BJ) {
                            return true;
                        }
                    }
                    return false;
          }
        function isBombJokersSingle() {
            if (m_oneCard.length === 3 && m_twoCard.length === 0 && m_threeCard.length === 0 &&
                       m_fourCard.length === 0) {
                       m_oneCard.sort((a, b) => a - b);
                       if (m_oneCard[1] === Card_SJ && m_oneCard[2] === Card_BJ) {
                           return true;
                       }
                   }
                   return false;
          }
        function isBombJokersPair() {
            if (m_oneCard.length === 2 && m_twoCard.length === 1 && m_threeCard.length === 0 &&
                        m_fourCard.length === 0) {
                        m_oneCard.sort((a, b) => a - b);
                        if (m_oneCard[0] === Card_SJ && m_oneCard[1] === Card_BJ) {
                            return true;
                        }
                    }
                    return false;
          }
        function isBombJokersTwoSingle() {
            if (m_oneCard.length === 4 && m_twoCard.length === 0 && m_threeCard.length === 0 &&
                        m_fourCard.length === 0) {
                        m_oneCard.sort((a, b) => a - b);
                        if (m_oneCard[2] === Card_SJ && m_oneCard[3] === Card_BJ) {
                            return true;
                        }
                    }
                    return false;
          }
}
