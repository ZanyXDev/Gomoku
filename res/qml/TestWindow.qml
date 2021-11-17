import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
//import QtQuick.Layouts 1.12

import io.github.zanyxdev 1.0

Window {
    id: mainWindow
    title: "Gomoku"
    visible: true

    height: Settings.screenHeight
    width: Settings.screenWidth

    flags: Qt.Dialog

    BackEnd {
        id: backend
    }

    Item {
        id: gameViewBord
        anchors.fill: parent
        // *** Background image ***
        Rectangle {
            id: background
            anchors.fill: parent;

            Image {
                id: backgroundImage
                source: "qrc:/res/images/background.jpg"
                fillMode: Image.Stretch;
                anchors.fill: parent;
                opacity: 0.5
            }
        }
        Grid {
            // Board is 15x15 tiles
            id: boardGrid
            rows: 15
            columns: 15
            spacing: 2
            x:20
            y:20
            Repeater {
                model: tileModel
                Item{
                    id:tile
                    width: 40
                    height: 40

                    Image {
                        fillMode: Image.Stretch;
                        anchors.fill: parent;
                        source: "qrc:/res/images/tile_background.png"
                        opacity: {
                            if (model.highlighted)
                                return 1.0
                            else
                                return 0.6
                        }
                        Behavior on opacity {
                            enabled: backend.moves != 0
                            NumberAnimation {
                                properties:"opacity"
                                duration: 500
                            }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        //enabled: !modelData.hasButton1 && !modelData.hasButton2
                        onClicked: {
                            //explosion.explode()
                            console.log("index:"+index)
                             console.log ("highlighted:"+model.highlighted)
                        }
                    }
                }
            }
        }


    }

    LoggingCategory {
        id: category
        name: "io.github.zanyxdev"
    }

    Component.onCompleted: {
        console.log(category, "Main window complete");
        console.log(category,qsTr("Row count:")+ tileModel.rowCount());
    }
}
