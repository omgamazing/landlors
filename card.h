#pragma once

class card
{
public:
    //点数
    enum CardPoint {
        Card_Begin,
        card_3,
        card_4,
        card_5,
        card_6,
        card_7,
        card_8,
        card_9,
        card_10,
        card_J,
        card_Q,
        card_K,
        card_A,
        card_2,
        card_SJ, //小王
        card_BJ, //大王
        Card_End
    };
    //花色
    enum CardSuit {
        Suit_Begin,
        diamond, //方块
        flower,  //梅花
        heart,   //红桃
        spade,   //黑桃
        Suit_end
    };

    void setPoint(CardPoint point);
    void setSuit(CardSuit suit);
    int point();
    int suit();

private:
    CardPoint m_point;
    CardSuit m_suit;
};
