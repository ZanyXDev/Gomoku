import QtQuick 2.12
/**
  Simple push button like component
  No support for theming or icons are provided
  */
Item {
    id: root
    property alias text: textItem.text
    property alias fontName: textItem.font.family
    property alias fontSize: textItem.font.pointSize

    property bool disabled: false
    property string whiteColor:"#ffffff"
    property string grey80Color:"#cccccc"
    property string whiteGreyColor:"#999999"
    property string greyColor:"#666666"
    property string darkGreyColor1:"#222222"
    property string darkGreyColor2:"#333333"

    /// The signal is emitted when the user clicked on the button
    signal clicked()

    // Suitable default size
    implicitWidth: textItem.implicitWidth
    implicitHeight: textItem.implicitHeight
    width: implicitWidth
    height: implicitHeight

    Rectangle {
        id: normal
        anchors.fill: parent
        border.color: root.whiteGreyColor
        border.width: 1
        radius: 10
        smooth: true
        gradient: Gradient {
            GradientStop { position: 0.0; color: root.greyColor }
            GradientStop { position: 1.0; color: root.darkGreyColor1 }
        }
    }
    Rectangle {
        id: pressed
        anchors.fill: parent
        border.color: root.whiteGreyColor
        border.width: 1
        radius: 10
        smooth: true
        opacity: 0
        gradient: Gradient {
            GradientStop { position: 0.0; color: root.whiteGreyColor }
            GradientStop { position: 1.0; color: root.darkGreyColor2 }
        }
    }
    Rectangle {
        id: disabled
        anchors.fill: parent
        border.color: root.whiteGreyColor
        border.width: 1
        radius: 10
        smooth: true
        opacity: 0
        gradient: Gradient {
            GradientStop { position: 0.0; color: root.grey80Color }
            GradientStop { position: 1.0; color: root.whiteGreyColor}
        }
    }
    Text {
        id: textItem
        font.family: "Helvetica"
        font.pointSize: 14
        smooth: true
        color: {
            if (root.disabled)
                root.grey80Color
            else
                root.whiteColor
        }

        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (!root.disabled)
                root.clicked()
            console.log("button clicked")
        }
        onPressed: {
            if (!root.disabled)
                root.state = "Pressed"
        }
        onReleased: {
            if (!root.disabled)
                root.state = ""
        }
    }
    states: [
        State {
            name: "Pressed"
            PropertyChanges { target: pressed; opacity: 1 }
        },
        State {
            name: "Disabled"
            when: root.disabled === true
            PropertyChanges { target: disabled; opacity: 1 }
        }
    ]
    transitions: Transition {
        NumberAnimation { properties: "opacity"; duration:100 }
    }
}
