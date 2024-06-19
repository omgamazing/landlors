//人机对战整体项目框架搭建
#pragma once
#include <algorithm>
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <string>
#include <vector>
using std::vector;
enum CardSuit { DIAMOND, CLUB, HEART, SPADE };
enum CardPoint {
    ONE,     //A
    TWO,     //2
    THREE,   //3
    FOUR,    //4
    FIVE,    //5
    SIX,     //6
    SEVEN,   //7
    EIGHT,   //8
    NINE,    //9
    TEN,     //10
    JACK,    //J
    QUEEN,   //Q
    KING,    //K
    JOKER_S, //小鬼
    JOKER_B  //大鬼
};

//牌面
class Card
{
    CardSuit suit;   //花色
    CardPoint point; //牌面值 点数

    Card(CardSuit s, CardPoint p)
        : suit(s)
        , point(p)
    {}

public:
    CardSuit getSuit() const { return suit; }
    CardPoint getPoint() const { return point; }
};

//game操作为一个类：Game
//   需要实现：拿到牌、分发牌、对牌排序
//card卡牌为一个类：Card
//   实现单张牌的比较
//cardType为一个类：CardType
//   对card所有能够组合的牌进行分类，并对牌做权重加权
//cards卡组为一个类Cards
//   每一堆每分发一张牌就需要添加一张牌，每打出去一张就要删除一张;实现牌盒的记录
//AI出牌为一个类AICard
//   实现人机对战的效果，给ai出牌的逻辑
//gameControl游戏控制类
//   实现得到玩家实例对象，每个人打完分值的变化，抢地主游戏状态变化
//游戏场景：加载定时器，扑克牌对齐方式
class Game
{
public:
    Game();
    void initializeDeck();                                    //初始话牌堆
    void shuffleDeck();                                       //洗牌
    void dealCards();                                         //清空玩家牌和分堆
    void sortPlayerCards();                                   //对玩家的牌堆进行排序
    void sortCards(std::vector<Card>& cards);                 //牌组排序
    void displayPlayerCards(const std::vector<Card>& player); //打印玩家的牌
    void displayAllPlayersCards();                            //打印每一位玩家的牌

    bool isValidCombination(const std::vector<Card>& cards); //验证玩家出的牌是否有效
    bool canBeat(const std::vector<Card>& current,
                 const std::vector<Card>& previous); //判断当前手牌是否打得过前一组牌
    bool playCards(std::vector<Card>& player, const std::vector<Card>& cards); //玩家出牌
    void startGame();                                                          // 开始游戏

    bool isSingle(const std::vector<Card>& cards);
    bool isPair(const std::vector<Card>& cards);
    bool isThreeOfAKind(const std::vector<Card>& cards);
    bool isStraight(const std::vector<Card>& cards);
    bool isDoubleStraight(const std::vector<Card>& cards);
    bool isTripleStraight(const std::vector<Card>& cards);

private:
    std::vector<Card> deck;                      //存储牌
    std::vector<Card> player1, player2, player3; //玩家
    std::vector<Card> threeCards;                //分成三个牌堆
    std::vector<Card> landlordCards;             // 地主牌
    int currentPlayer;                           // 当前出牌玩家
};
