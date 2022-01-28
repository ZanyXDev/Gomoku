

/***************************************************************************
* Copyright (c) 2013 Reza Fatahilah Shah <rshah0385@kireihana.com>
* Copyright (c) 2013 Abdurrahman AVCI <abdurrahmanavci@gmail.com>
* Copyright (c) 2021 ZanyxDev <zanyxdev@gmail.com>
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge,
* publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included
* in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
* OR OTHER DEALINGS IN THE SOFTWARE.
*
***************************************************************************/
import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    id: control
    //  anchors.fill: parent
    // ----- Property Declarations
    property alias text: cmdName.text
    property alias textColor: cmdName.color
    property alias textFontFamily: cmdName.font.family
    property alias textFontPointSize: cmdName.font.pointSize

    property bool enabled: true
    property bool isFocused: activeFocus || mouseArea.containsMouse
    property bool isPressed: mouseArea.pressed

    property string outLineSource: string
    property string inLineSource: string

    property color waveColor: "#55c9c9c9"
    property color shadowColor: "black"

    property real pressX: 0.0
    property real pressY: 0.0

    // ----- Signal declarations
    signal pressed
    signal released
    signal clicked
    // Do not use empty lines to separate the assignments. Empty lines are reserved
    // for separating type declarations.
    opacity: 0.8
    clip: true
    smooth: true

    layer.enabled: true
    layer.effect: DropShadow {
        horizontalOffset: 3
        verticalOffset: 4
        radius: 5
        samples: 11
        color: control.shadowColor
        opacity: 0.75
    }

    // ----- States and transitions.
    states: [
        State {
            name: "disabled"
            when: (control.enabled === false)
            PropertyChanges {
                target: control
                opacity: 0.4
            }
        },
        State {
            name: "active"
            when: control.enabled && control.isFocused && !control.isPressed
            PropertyChanges {
                target: control
                opacity: 0.9
            }
        },
        State {
            name: "pressed"
            when: control.enabled && control.isPressed
            PropertyChanges {
                target: inlineImage
                scale: 0.9
            }
        },
        State {
            name: "released"
            when: control.released
        },
        State {
            name: "hover"
            when: control.enabled && control.isFocused && !control.isPressed
            PropertyChanges {
                target: control
                opacity: 1.0
            }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            properties: scale
            easing.type: Easing.InOutQuad
            duration: 200
        }
        NumberAnimation {
            properties: opacity
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton

        onPressed: {
            control.focus = true
            control.pressed()
        }
        onClicked: {
            control.focus = true
            control.clicked()
        }
        onReleased: {
            control.focus = true
            control.released()
        }
        onPressedChanged: {
            pressX = mouseArea.mouseX
            pressY = mouseArea.mouseY
            clickWave.pressed = isPressed
        }

        onHoveredChanged: {
            control.state == 'hover' ? control.state = "" : control.state = 'hover'
        }
    }
    // ----- Signal handler
    onStateChanged: {

        // console.log("State: " + state);
    }

    // ----- Visual children.
    Image {
        id: outlineImage
         width: control.width
         height: control.height
        fillMode: Image.PreserveAspectFit
        source: outLineSource
    }

    Image {
        id: inlineImage

        width: control.width
        height: control.height

        source: inLineSource
        fillMode: Image.PreserveAspectFit
        Text {
            id: cmdName
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            // text: "OK"
        }
    }

    ClickWave {
        id: clickWave

        width: Math.max(control.width, control.height)
        height: width

        pressX: control.pressX
        pressY: control.pressY
        wave_color: control.waveColor
    }

    Component.onCompleted: {
        console.log("H:" + control.height + " W:" + control.width)
        //        console.log("Name of first state:", states[0].name)
        //        for (var i = 0; i < states.length; i++) {
        //            console.log("state", i, states[i].name)
        //        }
    }
}
