import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4

TextField {
    id: mainTextField
    Layout.fillWidth: true
    font.pixelSize: 21
    color: "#333333"
    selectionColor : "steelblue"
    selectedTextColor : "white"
    selectByMouse : true
    property int widthValue: 600

    background: Rectangle {
        id: input
        radius: 5
        implicitWidth: widthValue
        implicitHeight: 30
        border.width: 2
        border.color: parent.focus ? "#4682B4" : "#aaaaaa"
        Rectangle {
            id: lineInputUserField
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            //anchors.right: parent.right
            color: "steelblue"
            //implicitWidth: parent.width
            implicitHeight: parent.height/10
            visible: parent.parent.focus ? true : false

            PropertyAnimation {
                id: opacityAnimation
                target: lineInputUserField
                property: "opacity"
                from: 0
                to: 1
                duration: 500
                easing.type: Easing.OutCurve
            }

        }
    }
    onFocusChanged: {
        opacityAnimation.start()
    }
}
