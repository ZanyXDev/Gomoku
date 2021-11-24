import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.4
import "customitem"

RectangleWithGradient {
    id:controlField
    property string currentPlayerName:_currentPlayeName.text

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
            text: "00:00"//gameData.gameTime
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
            Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter

            font.family: appWnd.localFont
            font.pointSize: Settings.middleFont
            smooth: true
            color: "gray"
            style: Text.Outline
            styleColor: "black"
            text: "999"//gameData.moves
        }
        Text {
            id:_currentPlayeName
            Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter

            font.family: appWnd.localFont
            font.pointSize: Settings.middleFont
            smooth: true
            color: "gray"
            style: Text.Outline
            styleColor: "black"
            text: "Player"//gameData.moves
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
    Button{
        id:testAnimButton
        anchors.bottom: controlField.bottom

        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Quit")

        onClicked: {
            quitAnimation.start()
        }
    }

}
