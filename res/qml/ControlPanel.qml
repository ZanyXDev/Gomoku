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

    property string  fontFamily: "Helvetica"
    property int fontSize: 16

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

        font.family: fontFamily
        font.pointSize: fontSize

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        padding: 6
    }

    component ContolButton:FineButton{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left

        font.family: fontFamily
        font.pointSize: fontSize

        shadowColor: themeSetting.chinesBlack

        padding: 6
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

            font.pointSize: fontSize - 8

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

            font.pointSize: fontSize - 8

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

            font.pointSize: fontSize - 8

            text: qsTr("0000")//backend.score
        }
    }

    ProportionalRect {
        id:boxPlayerOrAI
        Layout.preferredHeight: 60

        InfoLabel {
            id:textPlayerName
            text: qsTr("AI-1")//backend.playerName
            padding: 10
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

    Component.onCompleted: {
        console.log("controlPanel.width:"+controlPanel.width)
        console.log("controlPanel.height :"+controlPanel.height )
        console.log("boxTimeMoveScore.height :"+boxTimeMoveScore.height )
        console.log("boxPlayerOrAI.height :"+boxPlayerOrAI.height )
        console.log("boxButtons.height :"+boxButtons.height )
    }
}
