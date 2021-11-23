import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.4
import "customitem"

Window {
    id: mainWindow

    property bool largeScreen: Screen.desktopAvailableHeight >= 90
    property double scale: width / 1600

    title: "Gomoku"
    visible: true
    Material.theme: Material.Light

    width: largeScreen  ? Settings.screenWidth : 920
    height: largeScreen ? Settings.screenHeight : 690

    flags: Qt.Dialog

    FontLoader {
        id: _localFont;
        source: "qrc:/res/fonts/DroidSansFallback.ttf"
    }

    // *** Game View ***
    GameView {
        id: gameView
        anchors.fill: parent
        RowLayout {
            id: layout
            anchors.fill: parent
            spacing: 2

            Rectangle {
                id:gameField
                border{
                    color: Qt.lighter("gray")
                    width:1

                }

                color: 'transparent'
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 2
                Layout.topMargin: 2
                Layout.bottomMargin: 2
                Layout.minimumWidth: Settings.tileWidth * 15
                Text {
                    anchors.centerIn: parent
                    text: parent.width + 'x' + parent.height
                }
            }
            RectangleWithGradient {
                id:controlField

                color: 'transparent'

                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumWidth: Settings.controlPanelWidth
                Layout.rightMargin: 2
                Layout.topMargin: 2
                Layout.bottomMargin: 2

                Text {
                    anchors.centerIn: parent
                    text: parent.width + 'x' + parent.height
                }
            }
        }
    }

    Button{
        x:100
        text: "Quit"
        id:testAnimButton
        onClicked: {
            quitAnimation.start()
        }
    }

    Image {
        id: backGround
        z: -1
        source: "qrc:/res/images/background.jpg"
        anchors.fill: parent
        fillMode: Image.Stretch
    }

    SequentialAnimation{
        id: quitAnimation
        running: false
        PauseAnimation {
            duration: 200
        }
        ParallelAnimation{
            PropertyAnimation{
                target: gameView;
                property: "opacity"
                duration: 750;
                from: 1.0;
                to: 0.0

            }
            PropertyAnimation {
                target: backGround;
                property: "opacity"
                duration: 900;
                from: 1.0;
                to: 0.0
            }
        }
        ScriptAction {
            script: Qt.quit()
        }
    }

    Component.onCompleted: {
        title.state = "shown"
        // mainPageLoadAnimation.start()
        console.log(Screen.desktopAvailableHeight);
        console.log("Size "+ mainWindow.width +"x"+  mainWindow.height)
    }
}

