import QtQuick.Controls 2.12
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

Window {
    id: mainWindow
    title: "Gomoku"
    visible: true

    height: Settings.screenHeight
    width: Settings.screenWidth

    flags: Qt.Dialog
    ListModel {
        id: tileModel

        ListElement {
            color: "orange"
            text: "first"
        }
        ListElement {
            color: "skyblue"
            text: "second"
        }
    }

    Grid {
        columns: 19
        spacing: 19
        Repeater{
            model: tileModel
            Rectangle {
                color: model.color
                width: 20;
                height: 20
            }
        }

    }
}

