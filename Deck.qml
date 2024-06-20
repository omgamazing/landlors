//对整副牌初始化和洗牌、对玩家发牌、对玩家手中的牌排序

import QtQuick 2.0
Item {
    //牌堆
    property var decks:[]

    //用于验证：property var cards:[]

    // 初始化牌堆数据
    Component.onCompleted: {
        initializeDeck()
        shuffleDeck()
        dealCards()

        /*
        cards.push({suit:4,rank:12});
        cards.push({suit:2,rank:15});
        cards.push({suit:5,rank:16});
        cards.push({suit:4,rank:15});
        cards.push({suit:3,rank:3});
        cards.push({suit:5,rank:17});
        cards.push({suit:1,rank:12});
        cards.push({suit:2,rank:13});
        cards.push({suit:1,rank:13});
        print()*/

        sortDeck(meDecks)
        print(meDecks)
    }


    // 初始化牌堆：生成一副包括 A-K 的四种花色和大小王的54张牌
    function initializeDeck() {
        var suits = ["1", "2", "3", "4"]
        for (var s = 0; s < suits.length; ++s) {
            for (var r = 3; r <= 15; ++r) {
                var card={suit:suits[s],rank:r}
                decks.push(card)
            }
        }

        // 添加大小王
        decks.push({ suit: 5, rank: 16 }); // 小王
        decks.push({ suit: 5, rank: 17 }); // 大王

        /*
        console.log("所有牌的信息:");
                for (var i = 0; i < decks.length; i++) {
                    console.log("索引",i,"花色:", decks[i].suit, " 牌面:", decks[i].rank);
                }*/
    }

    //洗牌：每次迭代生成一个随机整数j，该整数满足 [0,i)。这个随机整数j用来确定当前元素i要移动到的位置。
    function shuffleDeck() {
        for (var i = decks.length - 1; i > 0; --i) {
            var j = Math.floor(Math.random() * (i + 1))
            var tmp=decks[j]
            decks[j]=decks[i]
            decks[i]=tmp
        }
        /*
        console.log("所有牌的信息:");
                for (var e = 0; e < decks.length; e++) {
                    console.log("索引",e,"花色:", decks[e].suit, " 牌面:", decks[e].rank);
                }*/
    }



    //发牌：玩家拥有哪些牌，机器人拥有哪些
    //发牌特效（未实现）：动画与音乐
    //发牌规则：逆时针旋转，由玩家开始，依次发牌，每人17张，最后三张留作底牌，并扣上
    //大概思路：分为4个牌堆（三个玩家+地主），地主牌为最后三张

    property var meDecks:[]
    property var lplayerDecks:[]
    property var rplayerDecks:[]
    property var landlorsDecks:[]

    function dealCards() {
        for(var k = decks.length - 3; k < decks.length; k++)
            landlorsDecks.push(decks[k]);

        for(var i=0;i<decks.length-3;i++){
            var j=i%3;
            switch(j){
            case 0:
                meDecks.push(decks[i]);break;
            case 1:
                rplayerDecks.push(decks[i]);break;
            case 2:
                lplayerDecks.push(decks[i]);break;
            default:
                break;
            }

        }

        /*
        console.log("\n-------我的牌:-------\n");
        for (var e = 0; e < meDecks.length; e++) {
            console.log("索引",e,"花色:", meDecks[e].suit, " 牌面:", meDecks[e].rank);
        }
        console.log("\n-------右边玩家的牌:-------\n");
        for (e = 0; e <  rplayerDecks.length; e++) {
            console.log("索引",e,"花色:", rplayerDecks[e].suit, " 牌面:", rplayerDecks[e].rank);
        }
        console.log("\n-------左边玩家的牌-------\n");
        for (e = 0; e <  lplayerDecks.length; e++) {
            console.log("索引",e,"花色:",  lplayerDecks[e].suit, " 牌面:",  lplayerDecks[e].rank);
        }
        console.log("\n-------地主牌的信息:-------\n");
        for (e = 0; e < landlorsDecks.length; e++) {
            console.log("索引",e,"花色:", landlorsDecks[e].suit, " 牌面:", landlorsDecks[e].rank);
        }*/

    }


    //排序：根据玩家牌面大小由大到小进行排序
    //排序特效（未实现）：动画与音乐
    //排序规则：每一次大循环确定一张牌的位置，小循环从牌当前位置向后比较
    function sortDeck(cards){

        for (var i = 0; i < cards.length - 1; i++) {
                for (var j = 0; j < cards.length - 1 - i; j++) {
                    if (cards[j].rank < cards[j + 1].rank) {
                        // 交换 arr[j] 和 arr[j + 1]
                        var temp = cards[j];
                        cards[j] =cards[j + 1];
                        cards[j + 1] = temp;
                    }
                }
            }
        console.log("--排序后--")
        return cards;
    }
    function print(cards){
        console.log("\n-------我的牌:-------\n");
        for (var e = 0; e < cards.length; e++) {
            console.log("索引",e,"花色:",cards[e].suit, " 牌面:", cards[e].rank);
        }
    }


}
