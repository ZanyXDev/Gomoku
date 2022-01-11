import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Item{
    id:toggleSwitch

    property alias textOn: switchTextOn.text
    property alias textOff: switchTextOff.text

    property string imageOn: ""
    property string imageOff: ""

    property bool on: false

    property int m_elevation: 4
    property int m_radius:3

    property color shadowColor: "black"


    readonly property bool hovered: false;

    width: background.implicitWidth
    height: background.implicitHeigh

    state: "off"

    MaterialCard {
        id:background

        contentWidth: Math.max(100, (switchTextOff.implicitWidth +switchTextOn.implicitWidth))
        contentHeight: Math.max(40, switchTextOff.implicitHeight)

        Material.elevation: m_elevation

        radius: m_radius

        layer.enabled: false
        layer.effect: DropShadow {
            anchors.fill: background
            horizontalOffset: 3
            verticalOffset: 4
            radius: 5
            samples: 11
            color: toggleSwitch.shadowColor
            opacity: 0.75
        }

        QQC2.Label{
            id: switchTextOff

            anchors{
               // left: parent.left
                //                top: parent.top
                //                bottom: parent.bottom
            }

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font {
                family: fontSetting.fontName
                pointSize: fontSetting.smallFont
            }
            text: textOff
        }

        QQC2.Label{
            id: switchTextOn

            anchors {
                //right: parent.right
                //                top: parent.top
                //                bottom: parent.bottom
            }

            enabled: false

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font {
                family: fontSetting.fontName
                pointSize: fontSetting.smallFont
            }
            text: textOn
        }
    }
    //        Rectangle {
    //            id:knob
    //            //anchors.top: parent.top
    //            //anchors.verticalCenter: parent.verticalCenter

    //            Material.elevation: m_elevation + 2
    //            radius: m_radius + 2

    //            height: background.height - 4
    //            width: background.width / 2

    //            color: Material.accentColor

    //            QQC2.ToolTip.visible: hovered
    //            QQC2.ToolTip.text: qsTr("This switch On | Off music")
    //        }
    states: [
        State {
            name: "on"
            PropertyChanges {
                //                target: swPicture;
                //                source:imageOn
                //                anchors.rightMargin: -200
            }

            PropertyChanges {
                //                target: knob
                //                radius: 2
                //                rightPadding: 2
                //                transformOrigin: Item.Top
                //                anchors.leftMargin: 4
                //                anchors.bottomMargin: 4
                //                anchors.topMargin: 4
                //                layer.enabled: false
                //                activeFocusOnTab: true
                //                antialiasing: true
                //                padding: 2
                //                leftPadding: 2
                //                bottomPadding: 2
                //                topPadding: 2
            }
        },
        State {
            name: "off"
            PropertyChanges {
                //target: swPicture;
                //source:imageOff
            }
        }
    ]
    Component.onCompleted: {
        console.log("toggleSwitch.implicitWidth:"+implicitWidth)
        console.log("parent.implicitWidth:"+parent.implicitWidth)

        console.log("toggleSwitch.implicitHeight:"+implicitHeight)
        console.log("parent.implicitHeight:"+parent.implicitHeight)
    }
}
/**


//            QQC2.Label{
//                id: switchText

//                anchors{
//                    left: parent.left
//                    verticalCenter:  parent.verticalCenter
//                }

//                font {
//                    family: fontSetting.fontName
//                    pointSize: fontSetting.smallFont
//                }

//                text: textOff
//            }

//            Rectangle {
//                id: divVertical

//                anchors{
//                    left: switchText.right
//                    top: parent.top
//                    bottom: parent.bottom
//                }

//                color: "transparent"

//                width: 4
//            }

//            Image {
//                id: swPicture

//                anchors {
//                    left: divVertical.right
//                    verticalCenter:  parent.verticalCenter
//                }

//                source: imageOn
//                sourceSize {
//                    width: 32
//                    height: 32
//                }
//                fillMode:Image.PreserveAspectFit;
//                clip:true
//            }

-------------

Item{
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

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            text: textOff
        }
    }
    MouseArea {
        anchors.fill: parent
        drag.target: knob;
        drag.axis: "XAxis"
        drag.minimumX: 2
        drag.maximumX: background.width - knob.width - 2

        onClicked: toggle()
        onReleased: dorelease() //when user drag knob
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

    function toggle() {
        console.log("toggleswitch.state"+toggleswitch.state)
        if (toggleswitch.state === "on")
            toggleswitch.state = "off"
        else toggleswitch.state = "on"
        console.log("toggleswitch.state"+toggleswitch.state)
    }

    function dorelease() {
        if (knob.x === 2 && toggleswitch.state == "off")
            return

        if (knob.x === background.width - knob.width - 2 && toggleswitch.state == "on")
            return

        toggle()
    }
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
        border.c        x: 2
        y: 2olor: toggleswitch.whiteGreyColor
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

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}
}
##^##*/
