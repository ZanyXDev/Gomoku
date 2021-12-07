import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.4
import QtGraphicalEffects 1.0

import QtQuick.Controls.impl 2.2
import QtQuick.Controls.Material.impl 2.2

QQC2.Button{
    id: control

    property string fontName: "Helvetica"
    property int fontSize: 14
    property color shadowColor: "black"

    layer.enabled: true
    layer.effect: DropShadow {
        anchors.fill: control
        horizontalOffset: 3
        verticalOffset: 4
        radius: 5
        samples: 11
        color: control.shadowColor
        opacity: 0.75
    }

    state: pressed ? "buttonDown": "buttonUp"

    states: [
        State {
            name: "buttonDown"
            PropertyChanges {
                target: control
                scale: 0.7
            }
        },
        State {
            name: "buttonUp"
            PropertyChanges {
                target: control
                scale: 1.0
            }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: scale; easing.type: Easing.InOutQuad; duration: 200 }
    }
}

