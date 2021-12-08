import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id:debugRect

    anchors.fill: parent
    border.color: "#ff0000"
    color: "#ffffff"
    opacity: 0.8
    visible: true

    /**
     *usage Text {
    *             visible: logAndReturnValue(varName)
    *             text: "Example Text"
    *      }
    */
    function logAndReturnValue(varToLog)
    {
      console.log("value: " + varToLog);
      return varToLog;
    }

    Component.onCompleted: {
        console.log("------------ debugRect ----------")
        console.log("debugRect.height:"+debugRect.height)
        console.log("debugRect.width:"+debugRect.width)

        console.log("parent.height:"+parent.height)
        console.log("parent.width:"+parent.width)
        for (var prop in debugRect) {
            print(prop += " (" + typeof(debugRect[prop]) + ") = " + debugRect[prop]);
        }
    }
}
