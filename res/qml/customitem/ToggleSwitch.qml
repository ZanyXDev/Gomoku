import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.4

Item{
    function toggle() {
        console.log("toggleswitch.state"+toggleswitch.state)
        if (toggleswitch.state === "on")
            toggleswitch.state = "off"
        else toggleswitch.state = "on"
        console.log("toggleswitch.state"+toggleswitch.state)
    }

    id:toggleswitch
    property bool on: false
    property string fontName: _fontName
    property int fontSize: _fontSize
    property alias textOn: switchTextOn.text
    property alias textOff: switchTextOff.text

    implicitWidth: switchTextOn.implicitWidth + switchTextOff.implicitWidth +10
    implicitHeight: switchTextOn.implicitHeight + switchTextOff.implicitHeight +10

    width: implicitWidth
    height: implicitHeight

    state: "off"

    MaterialCard {
        id:background
        Material.elevation: 4

        anchors.fill: parent

        radius: 3
        QQC2.Label{
            id: switchTextOff
            font.family: fontName
            font.pointSize: fontSize

            color: Material.foreground
            text: textOff
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }
        QQC2.Label{
            id: switchTextOn
            font.family: fontName
            font.pointSize: fontSize

            color: Material.foreground
            text: textOn
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }
    }
    MaterialCard {
        id:knob
        Material.elevation: 6
        radius:5
        x: 2
        y: 2
        height: background.height - 4
        width: background.width / 2
        bgrColor: Material.accentColor

        QQC2.Label{
            id: switchText
            font.family: fontName
            font.pointSize: fontSize

            color: Material.foreground
            text: textOff
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: toggle()
    }
    states: [
        State {
            name: "on"
            PropertyChanges { target: knob; x: background.width - knob.width - 2 }
            PropertyChanges { target: toggleswitch; on: true }
            PropertyChanges { target: switchText; text: textOn }
        },
        State {
            name: "off"
            PropertyChanges { target: knob; x: 2 }
            PropertyChanges { target: toggleswitch; on: false }
            PropertyChanges { target: switchText; text: textOff }
        }
    ]
}
/**
Item {
    id: toggleswitch
    property bool on: false
    property string textOn
    property string textOff

    property string whiteColor:"#ffffff"
    property string grey80Color:"#cccccc"
    property string whiteGreyColor:"#999999"
    property string greyColor:"#666666"
    property string darkGreyColor1:"#222222"
    property string darkGreyColor2:"#333333"

    property alias textOn: switchTextOn.text
    property alias textOff: switchTextOff.text
    property string fontName:  "Helvetica"
    property int fontSize: 14

    implicitWidth: switchTextOn.implicitWidth + switchTextOff.implicitWidth +10
    implicitHeight: switchTextOn.implicitHeight + switchTextOff.implicitHeight +10
    width: implicitWidth
    height: implicitHeight

    state: "off"

    function toggle() {
        if (toggleswitch.state == "on")
            toggleswitch.state = "off"
        else toggleswitch.state = "on"
    }

    function dorelease() {
        if (knob.x === 2 && toggleswitch.state == "off")
            return

        if (knob.x === background.width - knob.width - 2 && toggleswitch.state == "on")
            return

        toggle()
    }

    Rectangle {
        id: background
        anchors.fill: parent
        border.color: toggleswitch.whiteGreyColor
        border.width: 1
        radius: 10
        smooth: true
        gradient: Gradient {
            GradientStop { position: 0.0; color: toggleswitch.grey80Color }
            GradientStop { position: 1.0; color: toggleswitch.whiteGreyColor }
        }
        Text {
            id: switchTextOff
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: knob.width/2 - switchTextOff.width/2

            smooth: true
            color: toggleswitch.grey80Color


            font.family: toggleswitch.fontName
            font.pointSize: toggleswitch.fontSize
            text: textOff
        }
        Text {
            id: switchTextOn
            font.family: toggleswitch.fontName
            font.pointSize: toggleswitch.fontSize
            smooth: true
            color:toggleswitch.grey80Color
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: knob.width/2 - switchTextOn.width/2
            text: textOn
        }
        MouseArea {
            anchors.fill: parent
            onClicked: toggle()
        }
    }
    Rectangle {
        id: knob
        x: 2
        y: 2
        height: background.height - 4
        width: background.width / 2
        color: toggleswitch.grey80Color
        border.color: toggleswitch.whiteGreyColor
        border.width: 1
        radius: 10
        smooth: true
        gradient: Gradient {
            GradientStop { position: 0.0; color: toggleswitch.greyColor }
            GradientStop { position: 1.0; color: toggleswitch.darkGreyColor1 }
        }
        Text {
            id: switchText
            font.family: toggleswitch.fontName
            font.pointSize: toggleswitch.fontSize
            smooth: true
            color:toggleswitch.whiteColor
            anchors.centerIn: parent
            text: textOff
        }
        MouseArea {
            anchors.fill: parent
            drag.target: knob;
            drag.axis: "XAxis"
            drag.minimumX: 2
            drag.maximumX: background.width - knob.width - 2
            onClicked: toggle()
            onReleased: dorelease()
        }
    }
    states: [
        State {
            name: "on"
            PropertyChanges { target: knob; x: background.width - knob.width - 2 }
            PropertyChanges { target: toggleswitch; on: true }
            PropertyChanges { target: switchText; text: textOn }
        },
        State {
            name: "off"
            PropertyChanges { target: knob; x: 2 }
            PropertyChanges { target: toggleswitch; on: false }
            PropertyChanges { target: switchText; text: textOff }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x"; /*easing: "easeInOutQuad";* duration: 200 }
    }
}
*/
