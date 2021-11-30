import QtQuick.Controls 2.12
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

Item{
    id: menuPanel
    width: parent.width
    height: parent.height
    Frame {
        id: menuPanelFrame
        width: parent.width - (parent.width /10)
        height: parent.height - (parent.height /10)
        anchors.centerIn: parent
    }
}
