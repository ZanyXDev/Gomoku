import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import Qt.labs.settings 1.0

import "customitem"

import io.github.zanyxdev 1.0

QQC2.ApplicationWindow {
    id: appWnd

    // ----- Property Declarations
    property alias fontSetting: m_fontSettings
    property alias themeSetting: m_themeSettings

    // ----- Signal declaration
    // Do not use empty lines to separate the assignments. Empty lines are reserved
    // for separating type declarations.
    title: "Gomoku"
    visible: true
    visibility: isMobile ? Window.FullScreen : Window.Windowed

    width: 320
    height: 480
    //https://webhamster.ru/mytetrashare/index/mtb0/1518088874t7qf07qzc1
    QQC2.StackView {
        id: stackView

        anchors.fill: parent
        focus: true
        initialItem: mainMenuStackComponent

        // ----- Visual children.
        Component {
            id: mainMenuStackComponent

            MenuPanel {
                id: mainMenu
                anchors.fill: parent
                enabled: stackView.status === stackView.Active
            }
        }


        /*
        Component {
            id: gamePanelStackComponent
            // Primary game panel
            GamePanel {
                id: gamePanel
                anchors.fill: parent
                enabled: Stack.status === Stack.Active
            }
        }
        Component {
            id: optionsMenuStackComponent

            OptionsMenu {
                id: propertiesMenu
                anchors.fill: parent
                enabled: Stack.status === Stack.Active
            }
        }
        Component {
            id: aboutMenuStackComponent

            AboutMenu {
                id: propertiesMenu
                anchors.fill: parent
                enabled: Stack.status === Stack.Active
            }
        }
*/


        /*!
          \brief Setup transitions on the page
          */
        pushEnter: Transition {
            PropertyAnimation {
                property: "scale"
                from: 0
                to: 1
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "scale"
                from: 1
                to: 0
                duration: 200
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "scale"
                from: 0
                to: 1
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "scale"
                from: 1
                to: 0
                duration: 200
            }
        }


        /*!
          \brief Return to Previous Page Implementation
          \note  When pressing Key_Back on mobile device. Works for all pages
        */
        Keys.onReleased: {
            if (event.key === Qt.Key_Back)
                pageBack(event)
        }


        /*!
          \brief Return to Previous Page Implementation
          \note  When pressing Key_ESQ on desktop device. Works for all pages
        */
        Keys.onPressed: {
            if (event.key === Qt.Key_Escape)
                pageBack(event)
        }

        onCurrentItemChanged: {
            title: "11"
            console.log("item Changed :" + stackView.depth) /// at here,you can update view title
        }

        function pageBack(event) {
            if (stackView.depth > 1) {
                stackView.pop()
                event.accepted = true
            }
        }
    }

    // ----- Visual children.
    Image {
        id: backGround
        z: -1
        source: "qrc:/res/images/background.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }
    // ----- Nonvisual children.
    BackEnd {
        id: backend
    }

    FontLoader {
        id: m_localFont
        source: "qrc:/res/fonts/China.ttf"
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

    Settings {
        id: m_themeSettings
        category: "Theme"
        property string virginWhite: "#ffffff"
        property string chinesBlack: "#111111"
    }

    Connections {
        target: Qt.application

        onStateChanged: {
            console.debug("App state changed to", Qt.application.state)
            if (Qt.application.state === Qt.ApplicationActive) {

                // Application go in active state
            } else {

                // Application go in suspend state
            }
        }
    }

    Component.onCompleted: {
        console.log("Screen.desktopAvailableHeight:" + Screen.desktopAvailableHeight)
        console.log("Screen.desktopAvailableWidth:" + Screen.desktopAvailableWidth)
        console.log("Size HxW [" + appWnd.height + "," + appWnd.width + "]")
        console.log("moves:" + backend.moves)
        console.log("Screen.pixelDensity:" + Screen.pixelDensity)
    }
}
