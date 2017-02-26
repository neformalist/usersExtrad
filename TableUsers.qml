import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2

TableView {
   id: tableUsers
   anchors.fill : parent
   anchors.topMargin: addNewUseButtom.height +10
   signal successInsertUser()
   signal successUpdateUser()

   TableViewColumn {
    id:nameUserfromTable
    title: "Имя"
    role: "name"
   }
   TableViewColumn {
    id:vornameUserfromTable
    title: "Фамилия"
    role: "vorname"
   }
   TableViewColumn {
    id:middlenameUserfromTable
    title: "Отчество"
    role: "middlename"
   }
   TableViewColumn {
    id:companyUserfromTable
    title: "Организация"
    role: "company"
   }
   TableViewColumn {
    id:passportUserfromTable
    title: "Паспортные данные"
    role: "passport"
   }
   style: TableViewStyle {
         headerDelegate: Rectangle {
             height: textItemUserTable.implicitHeight * 2
             width: textItemUserTable.implicitWidth * 1.2
             color: "lightsteelblue"
             border.color: "#8493A7"
             Text {
                     id: textItemUserTable
                     anchors.fill: parent
                     verticalAlignment: Text.AlignVCenter
                     horizontalAlignment: styleData.textAlignment
                     anchors.leftMargin: 12
                     text: styleData.value
                     elide: Text.ElideRight
                     color: textColor
                     renderType: Text.NativeRendering
                     font.pixelSize: Window.height/50
                     }
         }
         itemDelegate: Rectangle {
             border.color: "#cccccc"
             color: styleData.selected ? "steelblue" :"white"
             Text {
                     id: textRowUserTable
                     anchors.fill: parent
                     verticalAlignment: Text.AlignVCenter
                     horizontalAlignment: styleData.textAlignment
                     anchors.leftMargin: 12
                     text: styleData.value
                     elide: Text.ElideRight
                     color: styleData.selected ? "white" :"#333333"
                     renderType: Text.NativeRendering
                     font.pixelSize: Window.height/50
                     }
             }
         rowDelegate: Rectangle {
             height: Window.height/20
             MouseArea {
                 anchors.fill: parent
                 acceptedButtons: Qt.RightButton | Qt.LeftButton
                 onClicked: {
                     tableUsers.selection.clear()
                     tableUsers.selection.select(styleData.row)
                     tableUsers.currentRow = styleData.row
                     tableUsers.focus = true

                     switch(mouse.button) {
                     case Qt.RightButton:
                         contextMenuUser.popup() // Вызываем контексткное меню
                         break
                     default:
                         break
                     }
                 }
             }
         }
         handle: Rectangle {
             implicitWidth: 14
             implicitHeight: 16
             color: "steelblue"
             radius: 10
             }
         scrollBarBackground: Rectangle {
                 implicitWidth: 10
                 implicitHeight: 16
                 color: "#ffffff"
                 border.color: "#cccccc"
                 border.width: 2
              }
         decrementControl: Rectangle {
                  implicitWidth: 26
                  implicitHeight: 16
                  color: "steelblue"
                  Text {
                      anchors.centerIn: parent
                      color: "white"
                      text: qsTr("<<")
                  }
              }
         incrementControl: Rectangle {
                  implicitWidth: 26
                  implicitHeight: 16
                  color: "steelblue"
                  Text {
                      anchors.centerIn: parent
                      color: "white"
                      text: qsTr(">>")
                  }
              }
     }
   model: usersModel
   Connections {
    target: usersModel
    onSuccessInsertingToDb: {
        insertUser.textValue = "Новый пользователь успешно создан"
        insertUser.title = "Данные успешно добавлены"
        insertUser.colorButtom = "#5CB85C"
        successInsertUser()
        insertUser.open()
    }
    onNotValidateInsert: {
        insertUser.textValue = "Поля <b>имя</b> или <b>организация</b> не должны быть пустыми"
        insertUser.title = "Ошибка"
        insertUser.colorButtom = "#D9534F"
        insertUser.open()
    }
    onSuccessUpdateToDb : {
        updateUser.textValue = "Пользователь успешно изменен"
        updateUser.title = "Данные успешно изменены"
        updateUser.colorButtom = "#5CB85C"
        successUpdateUser()
        updateUser.open()
    }
    onNotValidateUpdate : {
        updateUser.textValue = "Поля <b>имя</b> или <b>организация</b> не должны быть пустыми"
        updateUser.title = "Ошибка"
        updateUser.colorButtom = "#D9534F"
        updateUser.open()
    }

    onSuccessDeleteUser: {
        deleteUserMessage.textValue = "Пользователь успешно удален"
        deleteUserMessage.title = "Пользователь успешно удален"
        deleteUserMessage.colorButtom = "#5CB85C"
        deleteUserMessage.open()
    }
    onErrorDeleteUser : {
       deleteUser.textValue = "Ошибка при удалении пользователя"
       deleteUser.title =  "Ошибка"
       deleteUser.clickedButton = "#D9534F"
       deleteUser.open()
    }

   }
}
