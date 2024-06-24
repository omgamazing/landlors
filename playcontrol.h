#pragma once

#include <QObject>
#include <QTimer>
#include <QVector>

class PlayControl : public QObject
{
    Q_OBJECT
public:
    explicit PlayControl(QObject *parent = nullptr);

    void startGame();
    void playerAction(bool isTakingLandlord);
    std::vector<std::string> a1;
    std::vector<std::string> a2;
    std::vector<std::string> a3;
    std::vector<std::string> a4;
    std::vector<std::string> a123;
    std::vector<std::string> a112233;
    std::vector<std::string> a111222;
    std::vector<PlayControl> playerList;
    std::vector<std::string> time;
    void ShowCard(int role);

signals:
    void updateTime(int player, int timeLeft);
    void setLandlord(int player);
    void showLandlordCards(bool show);
    void updateGameState(const QString &state);

private slots:
    void onTimeout();

private:
    void nextTurn();
    void computerAction(int player);
    void checkWinCondition();
    std::vector<std::string> split(const std::string &s, char delimiter);

    QVector<int> players;
    int currentPlayer;
    int dizhuFlag;
    QTimer timer;
    int timeLeft;
};
