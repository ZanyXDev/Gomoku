import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
//import QtQuick.Layouts 1.12

Window {
    id: mainWindow
    title: "Gomoku"
    visible: true

    height: Settings.screenHeight
    width: Settings.screenWidth

    flags: Qt.Dialog

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
            rows: 5
            columns: 5
            spacing: 2
            x:20
            y:20
            Repeater {
                model: tileModel
                Item{
                    id:tile
                    width: 80
                    height: 80
                    Image {

                        source: "qrc:/res/images/tile_background.png"
                        //                    opacity: {
                        //                        if (modelData.highlighted)
                        //                            return 1.0
                        //                        else
                        //                            return 0.6
                        //                    }
                        //                    Behavior on opacity {
                        //                        enabled: gameData.moves !== 0
                        //                        NumberAnimation {
                        //                            properties:"opacity"
                        //                            duration: 500
                        //                        }
                        //                    }
                    }
                    MouseArea {
                        anchors.fill: parent
                        //enabled: !modelData.hasButton1 && !modelData.hasButton2
                        onClicked: {
                            //explosion.explode()
                            console.log("index:"+index)
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
