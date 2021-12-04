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
    property string virginWhite:"#ffffff"
    property string chinesBlack:"#111111"

    signal flaped

    layer.enabled: true
    layer.effect: DropShadow {
        anchors.fill: control
        horizontalOffset: 3
        verticalOffset: 4
        radius: 5
        samples: 11
        color: chinesBlack
        opacity: 0.75
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            control.flaped()
            anim1.start()
            console.log("QQC2.Button.contol.click");
        }
        onReleased: {
        }
    }

    SequentialAnimation {
        id: anim1

        // Small the button
        PropertyAnimation {
            target: control
            property: "scale"
            to: 0.8
            duration: 200
            easing.type: Easing.InOutQuad
        }

        // Shrink back to normal
        PropertyAnimation {
            target: control
            property: "scale"
            to: 1.0
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

}

//        RectangularGlow {
//            id: effect
//            anchors.fill: rect
//            glowRadius:  10
//            spread:  0.2
//            color:  "white"
//            cornerRadius:  rect.radius + glowRadius
//        }

//        Rectangle {
//            id:  rect
//            color:  "black"
//            anchors.centerIn:  parent
//            width:  Math.round(parent.width / 1.5)
//            height:  Math.round(parent.height / 2)

//            radius:  25
//        }

//        DropShadow {
//            anchors.fill: rect
//            horizontalOffset: 3
//            verticalOffset: 3
//            radius: 8.0
//            samples: 17
//            color: "#80000000"
//            //source: rect
//        }
