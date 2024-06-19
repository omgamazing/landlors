#pragma once
#include "card.h"
#include <cassert>
#include <iostream>
#include <sstream>
#include <vector>
using std::vector;
//功能：定义牌的权重
//将牌切分成不同种类的牌型（cardNode），对每种牌型设置权重

const int kOneHandPower = -150; // 代表基本的牌型权重，每多一个牌型会减少权重
const int kPowerUnit = -100;    // 表示每个单位权重减少100
const int kMinPowerValue = -100000000; // 最小权重

const float ROCKET_WEIGHT = -8.0f;
const float BOMB_BASE_WEIGHT = -6.0f;
const float BOMB_NO_SUB_WEIGHT = -6.2f;
const float OTHER_BOMB_WEIGHT = -6.5f;
const float TRIPLE_BASE_WEIGHT = 0.433f;
const float PAIR_BASE_WEIGHT = 0.437f;
const float SINGLE_BASE_WEIGHT = 0.435f;
const float VALUE_DECREASE_FACTOR = 0.02f;
const float SERIAL_NUM_MULTIPLIER = 0.02f;
const float SUB_NUM_PENALTY = 0.01f;

static const char *cardSuits[] = {"♣️", "♦️", "♥️", "♠️"};
static const char *cardValues[]
    = {"", "1", "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A", "2"};

class CardNode : public card
{
    enum CardType {
        kCardType_Invalid = 0,
        kCardType_Single,
        kCardType_Pair,
        kCardType_Triple,
        kCardType_Bomb,
        kCardType_Rocket,
        kCardType_Serial,
        kCardType_SerialPair,
        kCardType_SerialTriple
    };
    enum CardValue {
        // 以下为牌的面值，从3开始
        kCard_ValueLeast = 2,   // 最小牌值（用于标识）
        kCard_Value3 = 3,       // 3
        kCard_Value4 = 4,       // 4
        kCard_Value5 = 5,       // 5
        kCard_Value6 = 6,       // 6
        kCard_Value7 = 7,       // 7
        kCard_Value8 = 8,       // 8
        kCard_Value9 = 9,       // 9
        kCard_ValueT = 10,      // 10
        kCard_ValueJ = 11,      // J
        kCard_ValueQ = 12,      // Q
        kCard_ValueK = 13,      // K
        kCard_ValueA = 14,      // A
        kCard_Value2 = 15,      // 2
        kCard_ValueJoker1 = 16, // 小王
        kCard_ValueJoker2 = 17, // 大王
        kCard_ValueMax = 18,    // 最大牌值

        kCard_TableMax = 20, // 牌桌上的最大牌数
        kCard_KindMax = 5,   // 最大种类数

        // 特殊牌值
        kCard_Joker1 = 53, // 小王（红色 Joker）
        kCard_Joker2 = 54, // 大王（黑色 Joker）
        //kCard_Flower = 55, // 花牌（假设有花牌）

        // 牌值掩码
        kCardMask_CardValue = 0x00ff, // 牌的面值掩码
        kCardMask_AnyMatch = 0x0100,  // 任意配对掩码

        // 游戏中的常量
        kMaxCardNum = 56, // 最大牌数
        kMaxPlayers = 3,  // 玩家数量

        // 牌型定义
        kCardValue_Single = 1, // 单牌类型，seriaNum == 1
        kCardValue_Serial = 2, // 顺子类型（单顺、双顺、三顺(飞机)、四顺）
        kCardValue_Rocket = 3, // 火箭（大小王）

        // 牌的角度
        kCardAngle = 130 // 牌的角度，两家的牌是倾斜的
    };

public:
    CardNode();
    //牌型种类，牌面数值，主牌张数，连续张数，副牌的数量
    CardNode(int type, int val, int mainN, int len, int sub);
    CardNode(const CardNode &other);
    //给牌赋值操作
    CardNode &operator=(const CardNode &other);

    bool isValidNode() const;
    void resetNode();                                  //重置为0
    int getTopValue() const;                           //获取牌最大值
    void fillJokers();                                 //王炸
    void merge(const CardNode &other);                 //合并两组牌
    bool isRocket() const;                             //王炸
    bool isBomb() const;                               //炸弹
    bool isExactLessThan(const CardNode &other) const; //是否比其他玩家的牌型小
    bool isStrictLessThan(const CardNode &other) const;
    float getPower() const;                      //获取牌的权重
    bool operator<(const CardNode &other) const; //比较，是否小于
    bool isEqualTo(const CardNode &other) const; //比较，是否等于
    std::string description() const;             //获取花色和值字符串
    static std::string join(const std::vector<std::string> &vec,
                            const std::string &delimiter); //连接成单一字符串
    float calculateWeight(float baseWeight, float top, int seralNum, int subNum) const;

    //添加getter setter
    void setCards(const std::vector<int> &cards);
    std::vector<int> getCards() const;

private:
    int cardType;    //牌型：不是连续的牌 连续的牌 王炸
    int value;       //牌面的值
    int mainNum;     //主牌张数
    int seralNum;    //连续牌的张数
    int subNum;      //副牌的张数
    float aggregate; //牌的权重
    vector<int> cards;
};

//合并 迭代器，src插入dest末尾
template<typename Ele>
void mergeTwoVectors(vector<Ele> &dest, const vector<Ele> &src)
{
    dest.insert(dest.end(), src.begin(), src.end());
}
