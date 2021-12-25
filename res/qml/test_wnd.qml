import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "customitem"
import io.github.zanyxdev 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ImageButton
    {
        width: 200
        height: 176

        outLineSource:  "qrc:/res/images/outline_button.png"
        inLineSource:  "qrc:/res/images/inline_button.png"
        enabled: true
        onClicked:
        {
            console.log( "image button clicked" );
        }
    }
}
