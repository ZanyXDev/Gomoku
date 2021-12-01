import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.4
import Qt.labs.settings 1.0

import "customitem"
import io.github.zanyxdev 1.0


ColumnLayout{
    id:controlPanel

    property string  fontFamily: "Helvetica"
    property int fontSize: 16

    component ProportionalRect: MaterialCard {
        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.preferredWidth: 1
        Layout.preferredHeight: 1
        Material.elevation: 6

        radius: 4
    }

    ProportionalRect {
        id:boxTimeMoveScore

        Layout.preferredHeight: 60

    }
    ProportionalRect {
        id:boxPlayerOrAI
        Layout.preferredHeight: 40

    }
    ProportionalRect {
        id:boxButtons
        Layout.preferredHeight: 120

    }
    Component.onCompleted: {
        console.log("controlPanel.width:"+controlPanel.width)
        console.log("controlPanel.height :"+controlPanel.height )
        console.log("boxTimeMoveScore.height :"+boxTimeMoveScore.height )
        console.log("boxPlayerOrAI.height :"+boxPlayerOrAI.height )
        console.log("boxButtons.height :"+boxButtons.height )
    }
}
