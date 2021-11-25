import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.4
import "customitem"

RectangleWithGradient {
    id:root
    property string currentPlayerName:_currentPlayerName.text
    property bool playerTurn: flipableArea.flipped

    ColumnLayout{
        id:infoPanel
        spacing: 2
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter

            font.family: appWnd.localFont
            font.pointSize: Settings.middleFont
            smooth: true
            color: "black"
            style: Text.Outline
            text: qsTr("Time")
        }
        Text {
            Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter

            font.family: appWnd.localFont
            font.pointSize: Settings.middleFont
            smooth: true
            color: "gray"
            style: Text.Outline
            styleColor: "black"
            text: backend.gameTime
        }
        Text {
            Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter

            font.family: appWnd.localFont
            font.pointSize: Settings.middleFont
            smooth: true
            color: "black"
            style: Text.Outline
            text: qsTr("Moves")
        }
        Text {
            id:_moves
            Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter

            font.family: appWnd.localFont
            font.pointSize: Settings.middleFont
            smooth: true
            color: "gray"
            style: Text.Outline
            styleColor: "black"
            text: backend.moves
        }
        Text {
            id:_currentPlayerName
            Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter

            font.family: appWnd.localFont
            font.pointSize: Settings.middleFont
            smooth: true
            color: "gray"
            style: Text.Outline
            styleColor: "black"
            text: {
                if (backend.playerSide)
                     qsTr("Human")
                else
                    qsTr("AI")
            }
        }
    }
    Flipable {
        id: flipableArea
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: infoPanel.bottom

        width: 96
        height: 96

        property bool flipped: false

        front:Image{
            source: "qrc:/res/images/tile_black.png";
            anchors.centerIn: parent
        }

        back: Image {
            source: "qrc:/res/images/tile_white.png";
            anchors.centerIn: parent
        }

        transform: Rotation {
            id: rotation
            origin.x: flipableArea.width/2
            origin.y: flipableArea.height/2
            axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
            angle: 0    // the default angle
        }

        states: State {
            name: "back"
            PropertyChanges { target: rotation; angle: 180 }
            when: flipableArea.flipped
        }

        transitions: Transition {
            NumberAnimation { target: rotation; property: "angle"; duration: 4000 }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: flipableArea.flipped = !flipableArea.flipped
        }
    }
    FineButton {
        id: buttonUndo
        anchors.top: flipableArea.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        height: 60
        width: parent.width - 20

        fontName: appWnd.localFont
        fontSize: Settings.middleFont

        disabled: !backend.moves

        text:  qsTr("Undo")
        opacity: backend.gameOn

        onClicked: {
            backend.undoTile()
        }
    }
    FineButton{
        id:testAnimButton

        anchors.bottom: root.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 10

        height: 60
        width: parent.width - 20

        fontName: appWnd.localFont
        fontSize: Settings.middleFont

        text: qsTr("Quit")

        onClicked: {
            flipableArea.flipped = !flipableArea.flipped
            //quitAnimation.start()
            backend.setGameOn(true)
        }
    }
}
