import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.4
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

    ProportionalRect {
        id:boxTimeMoveScore

        Layout.preferredHeight: 100

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
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("textPlayerName.onClick")
                    flipable.flipped = !flipable.flipped
                }
            }
        }

        Flipable {
            id: flipable
            property bool flipped: false

            anchors.top: textPlayerName.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            front: Image {
                width: 64
                height: 64
                source: "qrc:/res/images/tile_black.png";
                anchors.horizontalCenter: parent.horizontalCenter
            }
            back: Image {
                width: 64
                height: 64
                source: "qrc:/res/images/tile_white.png";
                anchors.horizontalCenter: parent.horizontalCenter
            }

            transform: Rotation {
                id: rotation
                origin.x: flipable.width/2
                origin.y: flipable.height/2
                axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                angle: 0    // the default angle
            }

            states: State {
                name: "back"
                PropertyChanges { target: rotation; angle: 180 }
                when: flipable.flipped
            }

            transitions: Transition {
                NumberAnimation { target: rotation; property: "angle"; duration: 4000 }
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
