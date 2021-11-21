import QtQuick.Controls 2.12
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

Window {
    id: mainWindow
    title: "Gomoku"
    visible: true
    color:"black"

    property bool largeScreen: Screen.desktopAvailableHeight >= 900
    property double scale: width / 1600

    width: largeScreen  ? Settings.screenWidth : 920
    height: largeScreen ? Settings.screenHeight : 690

    flags: Qt.Dialog

    // *** Game View ***
    GameView {
        id: gameView
        anchors.fill: parent
        Rectangle{
            width: Screen.pixelDensity * 10
            height: width
            color:"red"
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
                target: gameView; property: "opacity"
                duration: 750; from: 1.0; to: 0.0

            }
            PropertyAnimation {
                target: backGround; property: "opacity"
                duration: 900; from: 1.0; to: 0.0
            }
        }
        ScriptAction {
            script: Qt.quit()
        }
    }
    Component.onCompleted: {
        title.state = "shown"
        mainPageLoadAnimation.start()
    }
}

