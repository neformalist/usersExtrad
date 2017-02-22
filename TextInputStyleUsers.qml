import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4

TextField {
    Layout.fillWidth: true
    font.pixelSize: 21
    color: "#333333"
    selectionColor : "steelblue"
    selectedTextColor : "white"
    selectByMouse : true


    background: Rectangle {
        radius: 5
        implicitWidth: 600
        implicitHeight: 30
        border.color: parent.focus ? "#333333" : "#aaaaaa"

        Rectangle {
            id: lineInputUserField
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            color: "steelblue"
            implicitWidth: parent.width
            implicitHeight: parent.height/15
            visible: parent.parent.focus ? true : false


        }

    }
}
