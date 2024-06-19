#include "card.h"

void card::setPoint(CardPoint point)
{
    m_point = point;
}
void card::setSuit(CardSuit suit)
{
    m_suit = suit;
}
int card::point()
{
    return m_point;
}
int card::suit()
{
    return m_suit;
}
