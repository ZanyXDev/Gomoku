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

Item {
    id: container

    opacity: 0.8

    property bool enabled: true
    property bool isFocused: activeFocus || mouseArea.containsMouse
    property bool isPressed: mouseArea.pressed
    property string outLineSource: string
    property string inLineSource: string

    signal pressed()
    signal released()
    signal clicked()

    states: [
        State {
            name: "disabled"; when: (container.enabled === false)
            PropertyChanges { target: container; opacity: 0.4 }
        },
        State {
            name: "active"; when: container.enabled && container.isFocused && !container.isPressed
            PropertyChanges { target: container; opacity: 0.9 }
        },
        State {
            name: "pressed"; when: container.enabled && container.isPressed
            PropertyChanges { target: inlineImage;scale: 0.9 }
        },
        State {
            name: "released" ; when: container.released
        },
        State{
            name:"hover";when: container.enabled && container.isFocused && !container.isPressed
            PropertyChanges { target: container; opacity: 1.0 }
        }

    ]


    transitions: Transition {
        NumberAnimation { properties: scale; easing.type: Easing.InOutQuad; duration: 200 }
        NumberAnimation { properties: opacity; easing.type: Easing.InOutQuad; duration: 200 }
    }

    clip: true
    smooth: true
    Image{
        id:outlineImage
        fillMode: Image.PreserveAspectFit
        source: outLineSource
    }
    Image{
        id:inlineImage
        source: inLineSource
        fillMode: Image.PreserveAspectFit
    }
    MouseArea {
        id: mouseArea

        anchors.fill: parent

        cursorShape: Qt.PointingHandCursor

        hoverEnabled: true

        acceptedButtons: Qt.LeftButton

        onPressed: { container.focus = true; container.pressed() }
        onClicked: { container.focus = true; container.clicked() }
        onReleased: { container.focus = true; container.released() }
        onHoveredChanged: {container.state == 'hover' ? container.state ="":container.state ='hover'}
    }


    onStateChanged: {
        console.log("State: " + state);
    }

    Component.onCompleted: {
        console.log("Name of first state:", states[0].name)
        for (var i = 0; i < states.length; i++){
            console.log("state", i, states[i].name)
        }
        console.log("inlineImage.scale: " + inlineImage.scale);
    }
}
