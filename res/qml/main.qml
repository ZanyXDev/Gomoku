import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.4
import Qt.labs.settings 1.0

import "customitem"
import io.github.zanyxdev 1.0


QQC2.ApplicationWindow {
    id:appWnd

    Settings {
        id: appThemeSettings
        category: "Theme"
        // Set dark theme to be default for the very first launch (when settings file is NOT available)
        property int materialTheme: Material.Dark
    }

    Settings {
        id: settings
        //property alias wireless: wirelessSwitch.checked
        property int gameFieldWidth: 690
        property int controlPanelWidth: 180
        property bool largeScreen: Screen.desktopAvailableHeight >= 900
        property double scale: appWnd.width / 1600
    }

    property string localFont: _localFont.name

    title: "Gomoku"
    visible: true

    width: settings.largeScreen  ? 1024 : 920
    height: settings.largeScreen ? 768  : 690

    flags: Qt.Dialog

    FontLoader {
        id: _localFont;
        source: "qrc:/res/fonts/DroidSansFallback.ttf"
    }

    BackEnd{
        id:backend
    }

    ///*** Game View ***
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
                Layout.minimumWidth: settings.gameFieldWidth

                QQC2.Control {
                    anchors.centerIn: parent
                    width: 100
                    height: width
                    background: Rectangle {
                        color: Material.background
                        border.color: Material.foreground
                    }

                    QQC2.Label {
                        anchors.centerIn: parent
                        text: parent.width + 'x' + parent.height
                        font.pixelSize: 12
                    }
                }
            }
            ControlField {
                id: controlField
                Layout.bottomMargin: 2
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumWidth: settings.controlPanelWidth
                Layout.rightMargin: 2
                Layout.topMargin: 2
            }
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
        // On launch, read theme from settings file
        appWnd.Material.theme = appThemeSettings.materialTheme
        // mainPageLoadAnimation.start()
        console.log(Screen.desktopAvailableHeight);
        console.log("Size "+ appWnd.width +"x"+  appWnd.height)
        console.log("moves:"+backend.moves)
    }
    Component.onDestruction:{
        // On close, write theme to settings file
       // appThemeSettings.materialTheme = appWnd.Material.theme
    }

}

