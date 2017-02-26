import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4


Dialog {
    id: messageDialog
    visible: false
    width: 320
    height: 240
    property string textValue: ""
    property color colorButtom: "#5CB85C"
    contentItem: ColumnLayout{
        anchors.fill: parent
        Rectangle {
        Layout.fillHeight: true
        Layout.preferredWidth: parent.width-40
        Layout.margins: 20
        color: "white"
        clip: true
        Text {
            width: parent.width-40
            horizontalAlignment:Text.AlignHCenter
            color: "steelblue"
            anchors.centerIn: parent
            font.pixelSize: 21
            text: textValue
            wrapMode: Text.WordWrap
            }
        }
        Rectangle {
          color: messageDialogAddUser.pressed ? Qt.darker(colorButtom, 1.3) : colorButtom
          radius: 6
          Layout.alignment: Qt.AlignBottom
          Layout.preferredWidth: messageDialog.width-40
          Layout.preferredHeight: 40
          Layout.margins: 20
          Text {
              color: "white"
              anchors.centerIn: parent
              text: qsTr("OK")
          }
          MouseArea {
            id: messageDialogAddUser
            anchors.fill: parent
            onClicked: {
                messageDialog.close()
            }
          }
        }

    }


}
