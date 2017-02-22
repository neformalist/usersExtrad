import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4


Dialog {
    id: messageDialogDelete
    visible: false
    width: 420
    height: 240
    property string textValue: ""
    contentItem: ColumnLayout{
        anchors.fill: parent
        Rectangle {
        Layout.fillHeight: true
        Layout.preferredWidth: parent.width
        color: "white"
        clip: true
        Text {
            width: messageDialogDelete.width
            horizontalAlignment:Text.AlignHCenter
            color: "steelblue"
            anchors.centerIn: parent
            font.pixelSize: 21
            text: textValue
            wrapMode: Text.WordWrap
            }
        }
        Row{
            height: 40
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 4
            Rectangle {
              width: parent.width / 2 - 2
              color: messageDialogDeleteUser.pressed ? Qt.darker("#5CB85C", 1.3) : "#5CB85C"
              radius: 4
              anchors.top: parent.top
              anchors.bottom: parent.bottom
              anchors.leftMargin: 2
              Text {
                  color: "white"
                  anchors.centerIn: parent
                  text: qsTr("ДА")
              }
              MouseArea {
                id: messageDialogDeleteUser
                anchors.fill: parent
                onClicked: {
                    messageDialogDelete.close()
                    usersModel.removeRecord(usersModel.getID(tableUsers.currentRow))
                    usersModel.updateModel()
                }
              }
            }

            Rectangle {
              width: parent.width / 2 - 2
              color: messageDialogDeleteCancelUser.pressed ? Qt.darker("#D9534F", 1.3) : "#D9534F"
              anchors.top: parent.top
              anchors.bottom: parent.bottom
              anchors.rightMargin: 2
              radius: 4
              Text {
                  color: "white"
                  anchors.centerIn: parent
                  text: qsTr("Отмена")
              }
              MouseArea {
                id: messageDialogDeleteCancelUser
                anchors.fill: parent
                onClicked: {
                    messageDialogDelete.close()
                }
              }
            }
        }


    }


}
