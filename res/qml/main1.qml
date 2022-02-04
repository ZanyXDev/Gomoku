import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12  as QQC2
import QtQuick.LocalStorage 2.12

import "customitem"
import io.github.zanyxdev 1.0

QQC2.ApplicationWindow {
    id:appWnd
    // ----- Property Declarations

    // Required properties should be at the top.
    readonly property int screenOrientation: Screen.orientation

    // ----- Signal declarations
    signal screenOrientationUpdated(int screenOrientation)

    // ----- Size information
    width:  320 * dp
    height: 480 * dp
    // ----- Then comes the other properties. There's no predefined order to these.
    visible: true
    visibility:  (isMobile) ? Window.FullScreen : Window.Windowed
    title: qsTr("Gomoku")
    Screen.orientationUpdateMask: Qt.PortraitOrientation  |
                                  Qt.LandscapeOrientation |
                                  Qt.InvertedPortraitOrientation |
                                  Qt.InvertedLandscapeOrientation
    // ----- Then attached properties and attached signal handlers.
    // ----- States and transitions.
    // ----- Signal handlers
    onScreenOrientationChanged: {
        screenOrientationUpdated(screenOrientation);
    }
    Component.onCompleted: {
        var component = Qt.createComponent("GamePage.qml");

        if (component.status === Component.Ready) {
            mainStackView.push(component);
        } else {
            console.error(component.errorString());
        }
    }
    // ----- Visual children.
    QQC2.StackView {
        id:           mainStackView
        anchors.fill: parent

        MultiPointTouchArea {
            anchors.fill: parent
            z:            1
            enabled:      mainStackView.busy
        }
    }
    // ----- Qt provided non-visual children
    // ----- Custom non-visual children
    // ----- JavaScript functions
//    ImageButton{
//        id:imgButton
//        // width: 200
//        //height: 176

//        outLineSource:  "qrc:/res/images/outline_button.png"
//        inLineSource:  "qrc:/res/images/inline_button.png"
//        enabled: true
//        onClicked:
//        {
//            console.log( "image button clicked" );
//        }
//    }
}

