import QtQuick 2.12
//import QtQuick.Controls 2.12
import QtQuick.Window 2.12
//import QtQuick.Layouts 1.12

Window {
        width: 640
        height: 480

        visible: true

        ListView {
            id: view

            anchors.margins: 10
            anchors.fill: parent
            spacing: 10
            model: tileModel

            delegate: Rectangle {
                width: view.width
                height: 25
                color: "red"

                Text {
                    anchors.centerIn: parent
                    renderType: Text.NativeRendering
                    text: model.teststring

                }

            }
        }

        LoggingCategory {
            id: category
            name: "com.qt.category"
        }

        Component.onCompleted: {
            console.log(category, "message");
        }


}
