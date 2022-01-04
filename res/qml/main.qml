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

 Screen.orientationUpdateMask: Qt.PortraitOrientation         | Qt.LandscapeOrientation |
                                  Qt.InvertedPortraitOrientation | Qt.InvertedLandscapeOrientation

    readonly property int screenOrientation: Screen.orientation

    
    signal screenOrientationUpdated(int screenOrientation)

    onScreenOrientationChanged: {
        screenOrientationUpdated(screenOrientation);
    }

    Settings {
        id: m_settings
        //property alias wireless: wirelessSwitch.checked
        property int gameFieldSize: 690
        property int controlPanelWidth: 180

        property bool largeScreen: Screen.desktopAvailableHeight >= 900
        property double scale: appWnd.width / 1600
        property int itemPadding: 6
    }

    Settings {
        id: m_themeSettings
        category: "Theme"
        // Set dark theme to be default for the very first launch (when settings file is NOT available)
        property int materialTheme: Material.Dark
        property string virginWhite:"#ffffff"
        property string chinesBlack:"#111111"
    }

    Settings {
        id: m_fontSettings
        category: "Font"
        property string fontName: m_localFont.name
        property real largeFont: 64
        property real middleFont: 32
        property real smallFont: 16
        property real tinyFont: 8
    }

    // We need the settings object both here and in other page,
    // so for convenience, we declare it as a property of the root object so that
    // it will be available to all of the QML files that we load.
    property alias settings: m_settings
    property alias themeSetting: m_themeSettings
    property alias fontSetting: m_fontSettings

    title: "Gomoku"
    visible: true

    width: settings.largeScreen  ? 1024 : 920
    height: settings.largeScreen ? 768  : 690

    minimumHeight: settings.gameFieldSize + 8
    minimumWidth: settings.gameFieldSize + settings.controlPanelWidth +12

    Material.theme: m_themeSettings.materialTheme
    Material.accent: Material.color(Material.Indigo)

    flags: Qt.Dialog

    FontLoader {
        id: m_localFont;
        source: "qrc:/res/fonts/China.ttf"
    }

    BackEnd{
        id:backend
    }

    ///*** Game View ***
    Item {
        id: gameView
        anchors.fill: parent
        RowLayout {
            id: layout
            anchors.fill: parent
            spacing: 2
            MaterialCard {
                id:gameField
                Material.elevation: 6

                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 2
                Layout.topMargin: 2
                Layout.bottomMargin: 2
                Layout.minimumWidth: settings.gameFieldSize
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
                        color: Material.foreground
                        text: parent.width + 'x' + parent.height
                        font { pointSize: fontSetting.smallFont }
                    }

                }
            }

            ControlPanel {
                id: controlPanel
                Layout.fillHeight: true
                Layout.fillWidth: true

                Layout.topMargin: 2
                Layout.bottomMargin: 2
                Layout.rightMargin: 2

                Layout.preferredWidth: settings.controlPanelWidth

                spacing: 2

                onQuitApp: {
                    console.log("Send onQuitApp clicked")
                    quitAnimation.start()
                }
            }
        }
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
                from: 1.0; to: 0.0
            }
            PropertyAnimation {
                target: controlPanel;
                property: "opacity"
                duration: 900;
                from: 1.0; to: 0.0
            }
        }
        ScriptAction {
            script: Qt.quit()
        }
    }

    Component.onCompleted: {
        title.state = "shown"
        //        console.log("Theme:"+themeSettings.materialTheme);
        //        console.log("Size "+ appWnd.width +"x"+  appWnd.height)
        //        console.log("moves:"+backend.moves)
        //        console.log("Screen.pixelDensity:"+Screen.pixelDensity)
    }
}

