import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12 as QQC2
import QtMultimedia 5.12
import QtGraphicalEffects 1.0

import "customitem"

Item {
    id:gamePage
    // ----- Property Declarations
    // Required properties should be at the top.
    readonly property bool appInForeground:     Qt.application.state === Qt.ApplicationActive
    readonly property bool pageActive:          QQC2.StackView.status === QQC2.StackView.Active
    property double lastGameTime:               (new Date()).getTime()
    property bool animationEnabled:             false
    // ----- Signal declarations

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.
    // ----- Then attached properties and attached signal handlers.
    // ----- States and transitions.
    // ----- Signal handlers
    Component.onCompleted: {
        console.log("GamePage completed")
    }
    // ----- Visual children.

    ColumnLayout{
        id:mainScreenLayout
        anchors.fill: parent
        spacing: 1

        component ProportionalRect:Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 1
            Layout.preferredHeight: 1
        }
        component InfoLabel:QQC2.Label{
            anchors.horizontalCenter: parent.horizontalCenter
            font { family: font_families}
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            padding: 2 * dp
            color:"black"
        }

        ProportionalRect {
            id:boxMoveScore
            Layout.preferredHeight: 80 * dp
            RowLayout{
                id:infoLayout
                spacing: 4 * dp

                Item {
                    // spacer item
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
                Image{
                    id:movePanel
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    Layout.preferredWidth:  120 * dp
                    Layout.preferredHeight: 80 * dp
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    source: "qrc:/res/images/infopanel.png"
                    opacity: 0.9
                }
                Image{
                    id:scorePanel
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    Layout.preferredWidth:  120 * dp
                    Layout.preferredHeight: 80 * dp
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    opacity: 0.9
                    source: "qrc:/res/images/infopanel.png"
                }
                Item{
                    id:controlButton
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    Layout.preferredWidth:  62 * dp
                    Layout.preferredHeight: 62 * dp
                    ImageButton{
                        id: settingsBtn
                        width:  62 * dp
                        height:  62 * dp

                        outLineSource: "qrc:/res/images/sq_out_button.png"
                        inLineSource: "qrc:/res/images/sq_in_button.png"
                        onClicked: {
                            console.log("settingsBtn clicked")

                            var component = Qt.createComponent("SettingsPage.qml");

                            if (component.status === Component.Ready) {
                                var object = component.createObject(null);

                                mainStackView.push(object);
                            } else {
                                console.error(component.errorString());
                            }

                        }

                        // MyDebugRect{}
                    }
                }
            }
        }
        ProportionalRect {
            id:boxGameField

            Layout.preferredHeight: 360 * dp
            Rectangle{
                anchors.fill: parent
                color:"green"
                InfoLabel{

                    text:"[H:"+parent.height+",W:"+parent.width+"]"
                }

            }
        }
        ProportionalRect {
            id:boxControl

            Layout.preferredHeight: 40 * dp
            Rectangle{
                anchors.fill: parent
                color:"yellow"
                InfoLabel{
                    text:"[H:"+parent.height+",W:"+parent.width+"]"
                }
            }
        }
    }
    // ----- Qt provided non-visual children
    // ----- Custom non-visual children
    // ----- JavaScript functions
}

