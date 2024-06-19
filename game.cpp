
#include "game.h"
Game::Game()
    : currentPlayer(0)
{}
//初始化牌面
void Game::initializeDeck()
{
    /*
     * 有bug
    deck.clear();
    for (int s = DIAMOND; s <= SPADE; s++) {
        for (int p = ACE; p <= KING; ++p) {
            deck.push_back(Card(static_cast<CardSuit>(s), static_cast<CardPoint>(p)));
        }
    }*/
}

//洗牌，洗整个牌盒里面的牌
void Game::shuffleDeck()
{
    std::srand(static_cast<unsigned int>(std::time(nullptr)));
    std::random_shuffle(deck.begin(), deck.end());
}

//清空 分推
void Game::dealCards()
{
    player1.clear();
    player2.clear();
    player3.clear();
    threeCards.clear();

    for (int i = 0; i < 51; ++i) {
        if (i % 3 == 0)
            player1.push_back(deck[i]);
        else if (i % 3 == 1)
            player2.push_back(deck[i]);
        else
            player3.push_back(deck[i]);
    }

    for (int i = 51; i < 54; ++i) {
        threeCards.push_back(deck[i]);
    }
    sortPlayerCards();
}

//玩家牌 排序
void Game::sortPlayerCards()
{
    sortCards(player1);
    sortCards(player2);
    sortCards(player3);
}

//牌堆 排序
void Game::sortCards(std::vector<Card>& cards)
{
    std::sort(cards.begin(), cards.end(), [](const Card& a, const Card& b) {
        return (a.getSuit() < b.getSuit())
               || (a.getSuit() == b.getSuit() && a.getPoint() < b.getPoint());
    });
}
//打印玩家的牌（验证）
void Game::displayPlayerCards(const std::vector<Card>& player)
{
    for (const auto& card : player) {
        std::cout << "[" << card.getSuit() << "," << card.getPoint() << "] ";
    }
    std::cout << std::endl;
}
//打印牌堆的牌
void Game::displayAllPlayersCards()
{
    std::cout << "Player 1's Cards: ";
    displayPlayerCards(player1);
    std::cout << "Player 2's Cards: ";
    displayPlayerCards(player2);
    std::cout << "Player 3's Cards: ";
    displayPlayerCards(player3);
}
//验证玩家出的牌是否有效
bool Game::isValidCombination(const std::vector<Card>& cards)
{
    //to do
    if (cards.size() == 0)
        return false;

    std::vector<Card> sortedCards = cards;
    sortCards(sortedCards);

    if (isSingle(sortedCards))
        return true;
    if (isPair(sortedCards))
        return true;
    if (isThreeOfAKind(sortedCards))
        return true;
    if (isStraight(sortedCards))
        return true;
    if (isDoubleStraight(sortedCards))
        return true;
    if (isTripleStraight(sortedCards))
        return true;

    return false;
}
//对牌型的一些判断
bool Game::isSingle(const std::vector<Card>& cards)
{
    //to do
}

bool Game::isPair(const std::vector<Card>& cards)
{
    //to do
}

bool Game::isThreeOfAKind(const std::vector<Card>& cards)
{
    //to do
}

bool Game::isStraight(const std::vector<Card>& cards)
{
    //to do
}

bool Game::isDoubleStraight(const std::vector<Card>& cards)
{
    //to do
}

bool Game::isTripleStraight(const std::vector<Card>& cards)
{
    //to do
}

bool Game::canBeat(const std::vector<Card>& current, const std::vector<Card>& previous)
{
    //to do
    return true;
}
//玩家是否出牌
bool Game::playCards(std::vector<Card>& player, const std::vector<Card>& cards)
{
    if (isValidCombination(cards)) {
        //如果玩家出牌，将牌除掉
        for (const auto& card : cards) {
            auto it = std::find(player.begin(), player.end(), card);
            if (it != player.end()) {
                player.erase(it);
            }
        }
        return true;
    } else {
        std::cout << "Cannot play these cards." << std::endl;
        return false;
    }
}
//开始游戏
void Game::startGame()
{
    initializeDeck();
    shuffleDeck();
    dealCards();
    displayAllPlayersCards();

    currentPlayer = 0;
    std::vector<Card> currentCards;

    while (!player1.empty() && !player2.empty() && !player3.empty()) {
        if (currentPlayer == 0) {
            std::cout << "轮到你出牌了. （请输入1-13）: ";
        } else {
            std::cout << "AI Player " << currentPlayer << "'s turn." << std::endl;
        }

        if (currentPlayer == 0)
            currentPlayer = 1;
        else if (currentPlayer == 1)
            currentPlayer = 2;
        else if (currentPlayer == 2)
            currentPlayer = 0;

        displayAllPlayersCards();
    }
}
