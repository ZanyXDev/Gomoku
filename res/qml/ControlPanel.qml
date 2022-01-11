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

        font { family: fontSetting.fontName}

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        padding: settings.itemPadding

        Component.onCompleted: {
            //console.log("fontName:" + font.family)
        }
    }

    component ContolButton:FineButton{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left

        font {
            family: fontSetting.fontName
            pointSize: fontSetting.smallFont
        }

        shadowColor: themeSetting.chinesBlack

        padding: settings.itemPadding
    }

    component HSwitch:ToggleSwitch{
        Material.elevation: 6
    }

    ProportionalRect {
        id:boxTimeMoveScore

        Layout.preferredHeight: 120

        InfoLabel {
            id:textTime
            font { pointSize: fontSetting.middleFont}
            text: qsTr("Time")
            Component.onCompleted: {
                //console.log("fontSize:" + font.pointSize)
            }
        }

        InfoLabel {
            id:valueTime

            anchors.top: textTime.bottom

            font { pointSize: fontSetting.smallFont}

            text: backend.gameTime
        }

        InfoLabel {
            id:textMoves

            anchors.top: valueTime.bottom
            font { pointSize: fontSetting.middleFont}
            text: qsTr("Moves")
        }

        InfoLabel {
            id:valueMoves

            anchors.top: textMoves.bottom

            font { pointSize: fontSetting.middleFont}

            text: backend.moves
        }

        InfoLabel {
            id:textScore

            anchors.top: valueMoves.bottom
            font { pointSize: fontSetting.smallFont}
            text: qsTr("Score")
        }

        InfoLabel {
            id:valueScore

            anchors.top: textScore.bottom
            font { pointSize: fontSetting.middleFont}
            text: backend.score
        }
    }

    ProportionalRect {
        id:boxPlayerOrAI
        Layout.preferredHeight: 50

        InfoLabel {
            id:textPlayerName
            font { pointSize: fontSetting.middleFont}
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
        ContolButton{
            id:setupButton
            enabled: backend.moves <= 0 ? true : false
            text: qsTr("Setup")
            onClicked:  {
                console.log("Setup.clicked");
            }
        }

        ContolButton{
            id:playButton
            anchors.top: setupButton.bottom
            // enabled: backend.moves <= 0 ? true : false
            text: qsTr("Play")
            onClicked:  {
                console.log("Play.clicked");
            }
        }

        HSwitch{
            id:musicSwitch
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.top: playButton.bottom

            imageOn:"qrc:/res/images/outline_volume_up_black_24dp.png"
            imageOff:"qrc:/res/images/outline_volume_off_black_24dp.png"
            // status: true

            textOff:qsTr("OFF")
            textOn:qsTr("ON")
            Component.onCompleted: {
                console.log("------------ musicSwitch ------------")
                console.log("musicSwitch.height:"+musicSwitch.height)
                console.log("musicSwitch.width:"+musicSwitch.width)

                console.log("parent.height:"+parent.height)
                console.log("parent.width:"+parent.width)
            }
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
