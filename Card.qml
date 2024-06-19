import QtQuick 2.15

Item {
    // 牌的属性：花色和牌面大小
    property int suit // 0-3 分别代表 ♠️ ♥️ ♦️ ♣️
    property int rank // 1-13 分别代表 A, 2-10, J, Q, K

    // 显示牌的外观，使用图片
    Image {
        anchors.centerIn: parent
        source: getCardImage()
    }

    // 辅助函数，根据花色和牌面大小返回牌的图片路径
    function getCardImage() {
        var suitName;
        var rankName;

        // 根据花色设置文件夹和文件名前缀
        switch (suit) {
            case 0:
                suitName = "1"; // 黑桃
                break;
            case 1:
                suitName = "2"; // 红桃
                break;
            case 2:
                suitName = "3"; // 梅花
                break;
            case 3:
                suitName = "4"; // 方块
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
            if (rank == 14) { // 大王
                rankName = "5-2";
            } else if (rank == 15) { // 小王
                rankName = "5-1";
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
