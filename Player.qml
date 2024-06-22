//此qml实现：定义玩家状态：是否为地主、是否轮到玩家出牌、是否能出牌(轮到玩家出牌后，出不出得起)
//创建player对象，
import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
QtObject {
    id: player

    enum Role { Lord, Farmer }//游戏角色 为地主/为农民
    enum Direction { Left, Right }//角色位置 左边的robot/右边的robot
    enum Type { Robot, User, UnKnow }//角色 用户/机器

    // 属性
    property string name
    property int score: 0//得分
    //property var role: Role.Farmer//农民
    //property var direction: Direction.Left
    //property var type: Type.UnKnow//玩家类型
    property bool isWin: false
    property var prevPlayer: null//上家
    property var nextPlayer: null//下家
    property var cards: []
    property var pendCards: []
    property var pendPlayer: null

    // 名字
    function setName(newName) {
        name = newName
    }

    function getName() {
        return name
    }
    //角色：地主/农民
    function setRole(newRole) {
        role = newRole
    }

    function getRole() {
        return role
    }
    //方位
    function setDirection(newDirection) {
        direction = newDirection
    }

    function getDirection() {
        return direction
    }
    //玩家类型：robot/user
    function setType(newType) {
        type = newType
    }

    function getType() {
        return type
    }
    //玩家得分
    function setScore(newScore) {
        score = newScore
    }

    function getScore() {
        return score
    }
    //游戏结果
    function setWin(flag) {
        isWin = flag
    }

    function isWin() {
        return isWin
    }
    //提供当前玩家的上家
    function setPrevPlayer(player) {
        prevPlayer = player
    }

    function getPrevPlayer() {
        return prevPlayer
    }
    //提供当前玩家的下家
    function setNextPlayer(player) {
        nextPlayer = player
    }

    function getNextPlayer() {
        return nextPlayer
    }
    //叫地主/抢地主
    function grabLordBet(point) {
        notifyGrabLordBet(player, point)
    }
    //存储从牌盒里发出来的扑克牌
    function storeDispatchCard(cardsArray) {
        for (var i in cardsArray) {
            cards.push(cardsArray[i])
        }
        notifyPickCards(this, [card])//通知已经发牌
    }
    //得到所有的牌
    function getCards() {
        return cards
    }
    //清空玩家手里的牌
    function clearCards() {
        cards = []
    }
    //出牌
    function playHand(playCards) {
        // to do
    }
    //获取待出牌玩家对象
    function getPendPlayer() {
        return pendPlayer
    }
    //获取待出牌玩家的牌
    function getPendCards() {
        return pendCards
    }
    //存储出牌玩家对象 打出来的牌
    function storePendingInfo(player, playedCards) {
        pendPlayer = player
        pendCards = playedCards
    }

    function prepareCallLord() {
        //to do
    }

    function preparePlayHand() {
        // to do
    }

    function thinkCallLord() {
        //to do
    }

    function thinkPlayHand() {
        // to do
    }

    // 信号
    //signal notifyGrabLordBet(var player, int bet)//通知叫地主
    signal notifyGrabLordBet()//通知叫地主
    signal notifyPlayHand(var player, var cards)//通知出牌
    signal notifyPickCards(var player, var cards)//通知已经发牌

    function triggerNotifyGrabLordBet() {
            notifyGrabLordBet()

        }

}





