// PlayControl.qml

import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    property int currentPlayer: -1
    property int dizhuFlag: -1
    property int timeLeft: 10

    Timer {
        id: timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: playControl.onTimeout()
    }

    function startGame() {
        playControl.startGame();
    }

    function playerAction(isTakingLandlord) {
        playControl.playerAction(isTakingLandlord);
    }

    function computerAction(player) {
        playControl.computerAction(player);
    }

    function checkWinCondition() {
        // Implement win condition checking logic
        // playControl.checkWinCondition();
    }

  /*  PlayControl {
        id: playControl
        onUpdateTime: {
            // Update UI or handle time updates
        }
        onSetLandlord: {
            // Handle landlord setting
        }
        onShowLandlordCards: {
            // Handle showing landlord cards
        }
    }*/

    // Example UI elements or logic binding
    Text {
        text: "Current Player: " + currentPlayer
    }

    Button {
        text: "Start Game"
        onClicked: startGame()
    }

    // Add more UI elements as needed
}
