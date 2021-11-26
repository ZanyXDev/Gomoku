import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

QQC2.Pane {
    id: control

    property bool flat: control.enabled && control.Material.elevation > 0
    property int radius: 4

    //Material.background: "transparent"
    background: Rectangle {
        border.color: flat ? Qt.rgba(0,0,0,0.2) : "transparent"
        color: control.Material.backgroundColor
        radius: control.Material.elevation > 0 ? control.radius : 0
        //        gradient: Gradient{
        //            GradientStop { position : 0 ;  color: "#33FFFFFF" } //33 ~ 20% transporent white color
        //            GradientStop { position : 1.0; color: "#e5e5e5e5" }
        //        }
        layer.enabled: flat
        layer.effect: ElevationEffect {
            elevation: control.Material.elevation
        }
    }
}
