import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.4
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0

import "customitem"
import io.github.zanyxdev 1.0


ColumnLayout{
    id:controlPanel

    signal quitApp()

    component ProportionalRect: MaterialCard {
        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.preferredWidth: 1
        Layout.preferredHeight: 1

        Material.elevation: 6

        radius: 4
    }

    component InfoLabel:QQC2.Label{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left

        color: Material.foreground

        font.family: appWnd.localFont
        font.pointSize: settings.middleFont

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        padding: settings.itemPadding
    }

    component ContolButton:FineButton{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left

        font.family: appWnd.localFont
        font.pointSize: settings.smallFont

        shadowColor: themeSetting.chinesBlack

        padding: settings.itemPadding
    }

    ProportionalRect {
        id:boxTimeMoveScore

        Layout.preferredHeight: 120

        InfoLabel {
            id:textTime

            text: qsTr("Time")
        }

        InfoLabel {
            id:valueTime

            anchors.top: textTime.bottom

            font.pointSize: settings.smallFont

            text: backend.gameTime
        }

        InfoLabel {
            id:textMoves

            anchors.top: valueTime.bottom

            text: qsTr("Moves")
        }

        InfoLabel {
            id:valueMoves

            anchors.top: textMoves.bottom

            font.pointSize: settings.smallFont

            text: backend.moves
        }

        InfoLabel {
            id:textScore

            anchors.top: valueMoves.bottom

            text: qsTr("Score")
        }

        InfoLabel {
            id:valueScore

            anchors.top: textScore.bottom

            text: backend.score
        }
    }

    ProportionalRect {
        id:boxPlayerOrAI
        Layout.preferredHeight: 60

        InfoLabel {
            id:textPlayerName
            text: qsTr("AI-1")//backend.playerName
            padding: settings.itemPadding
        }

        ContolButton{
            id:undoButton
            anchors.top: textPlayerName.bottom
            enabled: backend.moves > 0 ? true : false
            text: qsTr("UNDO")
            onClicked:  {
                console.log("Undo.clicked");
            }
        }
    }

    ProportionalRect {
        id:boxButtons
        Layout.preferredHeight: 120
    }

        ContolButton{
            id:quitButton
            anchors.bottom: parent.bottom
            // enabled: backend.moves <= 0 ? true : false
            text: qsTr("Quit")
            onClicked:  {
                controlPanel.quitApp()
                console.log("Quit.clicked");
            }
        }
    }
}
