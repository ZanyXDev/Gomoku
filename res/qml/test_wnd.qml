import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12  as QQC2
import QtQuick.LocalStorage 2.12
import QtGraphicalEffects 1.0

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
    QQC2.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      StackView {
        id:           mainStackView
        anchors.fill: parent
        focus:true

        MultiPointTouchArea {
            anchors.fill: parent
            z:            1
            enabled:      mainStackView.busy
        }
        // Настройка механизма перехода между страницами
        delegate: StackViewDelegate {
            // Настройка анимации перехода
            pushTransition: StackViewTransition {

                // Для упрощения анимация отключена
                // Данное место переопределяет
                // стандартную анимацию с полупрозрачностью
                // Пример анимации с уменьшением масштаба - она лучше
                // стандартного перехода прозрачности,
                // так как нет наложения картинок, которое медленно рендерится


                PropertyAnimation {
                    target: enterItem
                    property: "scale"
                    from: 0
                    to: 1
                }
                PropertyAnimation {
                    target: exitItem
                    property: "scale"
                    from: 1
                    to: 0
                }

            }

        }
        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                pageBack(event)
                console.log("Qt.Key_Back Released")
            }
        }

        Keys.onPressed: {
            if (event.key === Qt.Key_Escape){
                pageBack(event)
                console.log("Qt.Key_Escape pressed")
            }
        }
        // ----- JavaScript functions
        // Обработка нажатия кнопки выхода с текущей страницы
        function pageBack(event) {
            if( mainStackView.depth > 1 ) {
                mainStackView.pop()
                event.accepted = true
            }
        }
    }

    Image {
        id: backGround
        z: -1
        source: "qrc:/res/images/background.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }


    // ----- Qt provided non-visual children

    // ----- Custom non-visual children
    BackEnd {
        id: backend
    }

    // ----- JavaScript functions
    // Обработка нажатия кнопки выхода с текущей страницы

}

