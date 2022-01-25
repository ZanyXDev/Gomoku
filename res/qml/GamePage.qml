import QtQuick 2.12
import QtQuick.Controls 2.5
import QtMultimedia 5.12
import QtSensors 5.12

Item {
    id:gamePage
    // ----- Property Declarations
    // Required properties should be at the top.
    readonly property bool appInForeground:     Qt.application.state === Qt.ApplicationActive
    readonly property bool pageActive:          StackView.status === StackView.Active
    property double lastGameTime:               (new Date()).getTime()
    property bool animationEnabled:             false
    // ----- Signal declarations

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.
    // ----- Then attached properties and attached signal handlers.
    // ----- States and transitions.
    // ----- Signal handlers

    // ----- Visual children.
    // ----- Qt provided non-visual children
    // ----- Custom non-visual children
    // ----- JavaScript functions
}
