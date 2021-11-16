import QtQuick.Controls 2.12
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

Window {
    id: mainWindow
    title: "Gomoku"
    visible: true

    height: Settings.screenHeight
    width: Settings.screenWidth

    flags: Qt.Dialog

    TileModel {
        id: tileModel
    }
    // *** Game View ***
    GameView {
        id: gameView
        // Gameview is disabled when gameViewHider is shown
        enabled: gameViewHider.state === "hide"
    }

    // *** Game View Hider ***
    Rectangle {
        id: gameViewHider
        anchors.fill: parent
        color: "black"
        opacity: 0.7

        states: [
            State {
                name: "hide"
                when: menuPanel.state === "hide"
                PropertyChanges {
                    target: gameViewHider
                    opacity: 0.0
                }
            }
        ]

        transitions: Transition {
            NumberAnimation {
                properties: "opacity"
                duration: 400
            }
        }
    }
    // *** Main Menu panel ***
    MenuPanel {
        id: menuPanel
    }

}

