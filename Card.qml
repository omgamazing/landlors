import QtQuick 2.15

Item {

    property int suit // 花色
    property int rank // 牌面

    //测试比较牌面的大小
    property var cards: []//牌组数组，存储多张牌
    Component.onCompleted: {
        cards.push({suit:1,rank:1});//黑桃a
        cards.push({suit:2,rank:2});//红桃2
        cards.push({suit:3,rank:3});//梅花3
        cards.push({suit:5,rank:14});//小王
        cards.push({suit:5,rank:15});//大王

        //打印所有牌的信息
        console.log("所有牌的信息:");
                for (var i = 0; i < cards.length; i++) {
                    console.log("花色:", cards[i].suit, " 牌面:", cards[i].rank);
                }
    }

    // 显示牌的外观，使用图片
    Image {
        anchors.centerIn: parent
        source: getCardImage(suit,rank)
    }

    // 辅助函数，根据花色和牌面大小返回牌的图片路径
    function getCardImage(suit,rank) {
        var suitName;
        var rankName;

        // 根据花色设置文件夹和文件名前缀
        switch (suit) {
            case 1:
                suitName = "1"; // 黑桃
                break;
            case 2:
                suitName = "2"; // 红桃
                break;
            case 3:
                suitName = "3"; // 梅花
                break;
            case 4:
                suitName = "4"; // 方块
                break;
            case 5:
                suitName="5";//大小王
                break;
            default:
                suitName = "";
                break;
        }

        // 根据牌面大小设置文件名
                if (rank >= 1 && rank <= 13) {
                    rankName = rank.toString();
                } else {
                    // 处理大小王
                    if (rank === 14) { // 小王
                        suitName="5";
                        rankName = "1";
                    } else if (rank === 15) { // 大王
                        suitName="5";
                        rankName = "2";
                    } else {
                        // 处理错误情况，如超出范围的牌面大小
                        console.error("Invalid card rank: " + rank);
                        return "";
                    }
                }
        // 返回图片路径
        return "qrc:/poker//" + suitName + "-" + rankName + ".png";
    }
}
