import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.4
import Qt.labs.settings 1.0
import "customitem"

MaterialCard {
    id:root
    Material.elevation: 6

    ColumnLayout{
        id:infoPanel
        spacing: 2
        anchors.horizontalCenter: parent.horizontalCenter

        QQC2.Label {
            Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.bottomMargin: 10

            font.family: appWnd.localFont
            font.pointSize: settings.middleFont

            color: Material.foreground
            //style: Text.Outline
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            text: qsTr("Time")
            Component.onCompleted: {
                console.log("color: "+Material.primaryColor)
            }
        }
        QQC2.Label {
            Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.bottomMargin: 10

            font.family: appWnd.localFont
            font.pointSize: settings.middleFont

            color: Material.secondaryTextColor//Material.color(Material.BlueGrey)
            //style: Text.Outline
            //styleColor: "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: backend.gameTime
        }
        QQC2.Label {
            Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.bottomMargin: 10

            font.family: appWnd.localFont
            font.pointSize: settings.middleFont

            color: Material.foreground
            //style: Text.Outline
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Moves")
        }
        QQC2.Label {
            id:_moves
            Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.bottomMargin: 10

            font.family: appWnd.localFont
            font.pointSize: settings.middleFont

            color: Material.secondaryTextColor
            //            style: Text.Outline
            //            styleColor: "black"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: backend.moves
        }
        QQC2.Label {
            id:_currentPlayerName
            Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.bottomMargin: 10

            font.family: appWnd.localFont
            font.pointSize: settings.middleFont
            font.bold: true
            color: Material.foreground

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: {
                if (backend.playerSide)
                    qsTr("Human")
                else
                    qsTr("AI")
            }

        }

        QQC2.ToolSeparator {
            orientation: Qt.Horizontal
            padding: vertical ? 10 : 2
            topPadding: vertical ? 2 : 10
            bottomPadding: vertical ? 2 : 10

            contentItem: Rectangle {
                implicitWidth: parent.vertical ? 1 : infoPanel.width - 10
                implicitHeight: parent.vertical ? infoPanel.height - 10 : 1
                color:  Material.accentColor
            }
        }
        ToggleSwitch{
            Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true

            width: infoPanel.width - 10
            fontName: appWnd.localFont
            fontSize: settings.smallFont
            textOff: "OFF"
            textOn: "ON"

        }


    }


    //    Rectangle {
    //        anchors.horizontalCenter: parent.horizontalCenter
    //        anchors.bottom: parent.bottom
    //        width: parent.width * 0.85
    //        height: parent.height * 0.05
    //        radius: height*0.5
    //        color: Material.backgroundColor
    //    }
}


