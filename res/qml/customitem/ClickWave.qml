import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    id: control
    // ----- Property Declarations
    property double wave_offset: 0.0
    property color  wave_color:  "red"
    property bool   pressed:     false
    property real   pressX:      0
    property real   pressY:      0

    // ----- Signal declarations
    // ----- In this section, we group the size and position information together.
    implicitWidth:  100
    implicitHeight: 100
    // Do not use empty lines to separate the assignments. Empty lines are reserved
    // for separating type declarations.
    visible: false

    RadialGradient {
        id:waveGradient
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: (control.wave_offset > 0.1) ? (control.wave_offset - 0.1) : 0
                color: "transparent"
            }
            GradientStop {
                position: control.wave_offset + 0.09
                color: control.wave_color
            }
            GradientStop {
                position: control.wave_offset + 0.11
                color: "transparent"
            }
        }
    }

    // ----- States and transitions.
    // this is a standalone animation, it's not running by default

    PropertyAnimation {
        id:         gradientAnimation

        property:   "wave_offset"

        from: 0; to: 0.4

        duration:   750
        running:    false
        target:     control

        onStarted:  { control.visible = true }
        onFinished: { control.visible = false }
    }

    // ----- Signal handlers
    onPressedChanged:{
        if ( control.pressed ){
            control.click( control.pressX, control.pressY );
            //console.trace()
        }

    }

    // ----- Visual children.

    // functions
    function click( ptx,pty ){
        //console.log("click(ptx,pty):"+ptx+":"+pty)
        //console.trace()
        gradientAnimation.stop()
        control.x = ptx - control.width / 2
        control.y = pty - control.height / 2
        gradientAnimation.start()
    }
}
