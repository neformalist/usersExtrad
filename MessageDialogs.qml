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
        Layout.preferredWidth: parent.width
        color: "white"
        clip: true
        Text {
            width: messageDialog.width
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
          radius: 4
          Layout.alignment: Qt.AlignBottom
          Layout.preferredWidth: parent.width
          Layout.preferredHeight: 60
          Text {
              color: "white"
              anchors.centerIn: parent
              text: qsTr("ОKEY")
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
