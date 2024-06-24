#include "playcontrol.h"
#include <QDebug>
#include <algorithm>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
PlayControl::PlayControl(QObject* parent)
    : QObject(parent)
    , currentPlayer(0)
    , dizhuFlag(-1)
    , timeLeft(10)
{
    connect(&timer, &QTimer::timeout, this, &PlayControl::onTimeout);
}

void PlayControl::startGame()
{
    players = {0, 1, 2}; // Players represented by indices
    currentPlayer = 1;   // Assuming the human player starts
    dizhuFlag = -1;      // No landlord initially
    timeLeft = 10;
    emit updateTime(currentPlayer, timeLeft);
    timer.start(1000); // Start a 1-second timer
}

void PlayControl::playerAction(bool isTakingLandlord)
{
    if (isTakingLandlord) {
        dizhuFlag = currentPlayer;
        emit setLandlord(currentPlayer);
        emit showLandlordCards(true);
    }
    nextTurn();
}

void PlayControl::onTimeout()
{
    if (--timeLeft <= 0) {
        timer.stop();
        emit updateTime(currentPlayer, 0);
        playerAction(false); // Timeout means player didn't take action
    } else {
        emit updateTime(currentPlayer, timeLeft);
    }
}

void PlayControl::nextTurn()
{
    currentPlayer = (currentPlayer + 1) % players.size();
    timeLeft = 10;
    emit updateTime(currentPlayer, timeLeft);
    if (currentPlayer != 1) { // Assuming player 1 is human
        computerAction(currentPlayer);
    }
    timer.start(1000);
}

void PlayControl::computerAction(int player)
{
    // Simple AI logic for taking landlord or not
    bool isTakingLandlord = (rand() % 2 == 0);
    qDebug() << "Computer" << player << (isTakingLandlord ? "takes" : "doesn't take") << "landlord";
    playerAction(isTakingLandlord);
}

void PlayControl::checkWinCondition()
{
    // Implement win condition checking logic
    // emit updateGameState("Player X wins");
}

void PlayControl::ShowCard(int role)
{
    PlayControl& playcontrol = playerList[role];
    std::vector<std::string> list;

    if (time[(role + 1) % 3] == "不要" && time[(role + 2) % 3] == "不要") {
        if (playcontrol.a1.size() > (playcontrol.a111222.size() * 2 + playcontrol.a3.size())) {
            list.push_back(playcontrol.a1.back());
        } else if (playcontrol.a2.size()
                   > (playcontrol.a111222.size() * 2 + playcontrol.a3.size())) {
            list.push_back(playcontrol.a2.back());
        } else if (!playcontrol.a123.empty()) {
            list.push_back(playcontrol.a123.back());
        } else if (!playcontrol.a3.empty()) {
            if (!playcontrol.a1.empty()) {
                list.push_back(playcontrol.a1.back());
            } else if (!playcontrol.a2.empty()) {
                list.push_back(playcontrol.a2.back());
            }
            list.push_back(playcontrol.a3.back());
        } else if (!playcontrol.a112233.empty()) {
            list.push_back(playcontrol.a112233.back());
        } else if (!playcontrol.a111222.empty()) {
            auto name = split(playcontrol.a111222.back(), ',');
            if (name.size() / 3 <= playcontrol.a1.size()) {
                list.push_back(playcontrol.a111222.back());
                for (size_t i = 0; i < name.size() / 3; ++i) {
                    list.push_back(playcontrol.a1[i]);
                }
            } else if (name.size() / 3 <= playcontrol.a2.size()) {
                list.push_back(playcontrol.a111222.back());
                for (size_t i = 0; i < name.size() / 3; ++i) {
                    list.push_back(playcontrol.a2[i]);
                }
            }
        } else if (!playcontrol.a4.empty()) {
            if (playcontrol.a1.size() >= 2) {
                list.push_back(playcontrol.a1.back());
                list.push_back(*(playcontrol.a1.end() - 2));
                list.push_back(playcontrol.a4.front());
            } else if (playcontrol.a2.size() >= 2) {
                list.push_back(playcontrol.a2.back());
                list.push_back(*(playcontrol.a2.end() - 2));
                list.push_back(playcontrol.a4.front());
            } else {
                list.push_back(playcontrol.a4.front());
            }
        }
    } else {
        // Implement the following logic for "跟牌" as in the original code
    }

    for (const auto& card : list) {
        std::cout << card << " ";
    }
    std::cout << std::endl;
}

std::vector<std::string> PlayControl::split(const std::string& s, char delimiter)
{
    std::vector<std::string> tokens;
    std::string token;
    std::istringstream tokenStream(s);
    while (std::getline(tokenStream, token, delimiter)) {
        tokens.push_back(token);
    }
    return tokens;
}
