import QtQuick 2.12

Rectangle {
    width: parent.width
    height: parent.height

    border.color:"#999999"
    border.width: 2
    radius: 10
    smooth: true

    gradient: Gradient{
        GradientStop { position : 0 ;  color: "#33FFFFFF" } //33 ~ 20% transporent white color
        GradientStop { position : 0.3; color: "#45FFFFFF" }
        GradientStop { position : 0.8; color: "#33FFFFFF" }
        GradientStop { position : 1.0; color: "#e5e5e5e5" }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            // This will just block clicks inside frame for not going into board
        }
    }
}


