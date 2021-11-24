import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.4
import "customitem"

RectangleWithGradient {
    id:controlField
    GroupBox{
        id:infoPanel
        anchors.top: parent
        anchors.horizontalCenter: parent.horizontalCenter
        ColumnLayout{

            anchors.fill: parent
            spacing: 2

            Text {
                Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter
                font.family: appWnd.localFont
                font.pointSize: Settings.smallFont
                smooth: true
                color: "black"
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
                font.pointSize: Settings.smallFont
                smooth: true
                color: "black"
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
                text: "13"//gameData.moves
            }
        }
    }
    Button{
        id:testAnimButton
        anchors.top: infoPanel.bottom
        text: qsTr("Quit")


        onClicked: {
            quitAnimation.start()
        }
    }

}
