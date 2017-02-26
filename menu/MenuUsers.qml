import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4


Menu {
id: contextMenuUser
__minimumWidth : 200
function loadDataForEdit(){
    updateUserDialog.nameText = usersModel.get(tableUsers.currentRow).name;
    updateUserDialog.vornameText = usersModel.get(tableUsers.currentRow).vorname;
    updateUserDialog.middlenameText = usersModel.get(tableUsers.currentRow).middlename;
    updateUserDialog.companyText = usersModel.get(tableUsers.currentRow).company;
    updateUserDialog.passportText = usersModel.get(tableUsers.currentRow).passport;
    updateUserDialog.fillField()
}
    MenuItem {
        text: qsTr("Удалить")
        iconSource: "../icons/delete.png"
        onTriggered: {
                deleteUser.objectName = "deleteUser"
                deleteUser.textValue = "Вы действительно хотите удалить пользователя?"
                deleteUser.open()
        }
    }
    MenuItem {
       text: qsTr("Редактировать")
       iconSource: "../icons/edit.png"
       onTriggered: {
            contextMenuUser.loadDataForEdit()
            updateUserDialog.open()
       }
    }
style: MenuStyle {
    function loadMenuImage(index) {
       return index;
    }
    frame: Rectangle {
        color: "#fff"
        border.width: 2
        radius: 5

      }

    itemDelegate.label: Row {
        id: menuRow
        spacing: 10
        Image {
            anchors.top: menuRow.top
            anchors.topMargin: 3
            id: img
            source: loadMenuImage(styleData.iconSource)
            width: 18
            height: 18
        }
        Text {
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 12
            color: styleData.selected ? "white" : "black"
            text: styleData.text
        }

      }

   itemDelegate.background: Rectangle {
        width: 500
        height: 300
        radius: 2
        color: styleData.selected ? "steelblue" : "transparent"
     }
    }

}
