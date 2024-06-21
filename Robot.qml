//实现ai斗地主的逻辑
//计算ai牌堆的权重进行是否叫地主考虑 实时监控地主手牌情况
import QtQuick
Item {
    id: robot
    property string name: "Robot"
    property string type: "Player.Robot"
    property var cards: []

    //使用子线程
    function prepareCallLord() {
        console.log("Preparing to call lord...");
        var subThread = new RobotGrapLord(robot);
        subThread.finished.connect(function() {
            console.log("RobotGrapLord 子线程对象析构..., Robot name: " + robot.name);
            subThread = null;
        });
        subThread.start();
    }

    function preparePlayHand() {
        console.log("Preparing to play hand...");
        var subThread = new RobotPlayHand(robot);
        subThread.finished.connect(function() {
            console.log("RobotPlayHand 子线程对象析构..., Robot name: " + robot.name);
            subThread = null;
        });
        subThread.start();
    }

    //考虑是否抢地主
    function thinkCallLord() {
        var weight = 0;
        var strategy = new Strategy(robot, robot.cards);

        weight += strategy.getRangeCards("Card_SJ", "Card_BJ").cardCount() * 6;

        var optSeq = strategy.pickOptimalSeqSingles();
        weight += optSeq.length * 5;

        var bombs = strategy.findCardsByCount(4);
        weight += bombs.length * 5;

        weight += strategy.pointCount("Card_2") * 3;

        var tmp = robot.cards.slice(); // Clone the cards array
        strategy.removeCards(tmp, optSeq);
        strategy.removeCards(tmp, bombs);
        var card2 = strategy.getRangeCards("Card_2", "Card_2");
        strategy.removeCards(tmp, card2);
        var triples = strategy.findCardsByCount(3);
        weight += triples.length * 4;

        strategy.removeCards(tmp, triples);
        var pairs = strategy.findCardsByCount(2);
        weight += pairs.length * 1;

        if (weight >= 22) {
            grabLordBet(3);
        } else if (weight < 22 && weight >= 18) {
            grabLordBet(2);
        } else if (weight < 18 && weight >= 10) {
            grabLordBet(1);
        } else {
            grabLordBet(0);
        }
    }

    //考虑选什么牌来出
    function thinkPlayHand() {
        var strategy = new Strategy(robot, robot.cards);
        var cs = strategy.makeStrategy();
        playHand(cs);
    }
}
