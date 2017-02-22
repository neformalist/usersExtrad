import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4


Dialog {
    visible: false
    title: "Новый пользователь"
    width: 640
    height: 480
    id: dialogAddUser
    property string textButtom: ""
    property string name: ""
    property string vorname: ""
    property string middlename: ""
    property string company: ""
    property string passport: ""

    contentItem: Rectangle {
        color: "white"

        GridLayout {
                columns: 2
                anchors.fill: parent
                anchors.margins: 10
                rowSpacing: 10

                LabelAddUser{text: "Имя "}
                TextInputStyleUsers {id: name; text: name}
                LabelAddUser{text: "Фамилия "}
                TextInputStyleUsers {id: vorname; text: vorname}
                LabelAddUser{text: "Отчество "}
                TextInputStyleUsers {id: middlename; text: middlename}
                LabelAddUser{text: "Организация "}
                TextInputStyleUsers {id: company; text: company}
                LabelAddUser{text: "Паспортные данные "}
                TextInputStyleUsers {id: passport; text: passport}

                Rectangle {
                    id: divider
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.rowSpan: 1

                }

                Item {
                    id: addUserButtomGroup
                    Layout.columnSpan: 1
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 30
                    Layout.fillWidth: true
                    implicitHeight: buttonAddUser.height

                        Rectangle {
                           id: buttonAddUserRect
                           anchors.left: parent.left
                           implicitWidth: 200
                           implicitHeight: 50
                           radius: 5
                           border.width: 2
                           color: buttonAddUserMouseArea.pressed ? Qt.darker("#5CB85C", 1.3) : "#5CB85C"
                           border.color: buttonAddUserMouseArea.pressed ? "#5CB85C" : "#00000000"
                           Text {
                                   id: buttonAddUser
                                   anchors.centerIn: parent
                                   anchors.leftMargin: 12
                                   text: textButtom
                                   color:  "white"
                                   font.pixelSize: 21
                           }
                           MouseArea {
                                id: buttonAddUserMouseArea
                                anchors.fill: parent
                                onClicked: {
                                    usersModel.insertUser(name.text, vorname.text, middlename.text, company.text, passport.text)
                                }

                           }

                        }
                        Rectangle {
                           anchors.left: buttonAddUserRect.right
                           anchors.margins: 10
                           implicitWidth: 200
                           implicitHeight: 50
                           radius: 5
                           border.width: 2
                           color: buttonAddUserCloseMouseArea.pressed ? Qt.darker("#D9534F", 1.3) : "#D9534F"
                           border.color: buttonAddUserCloseMouseArea.pressed ? "#D9534F" : "#00000000"
                           Text {
                                   id: buttonAddUserClose
                                   anchors.centerIn: parent
                                   anchors.leftMargin: 12
                                   text: "Отмена"
                                   color:  "white"
                                   font.pixelSize: 21                           }
                           MouseArea {
                                id: buttonAddUserCloseMouseArea
                                anchors.fill: parent
                                onClicked: dialogAddUser.close()
                           }
                        }

                    }
                }

        }
        function clearField(){
            name.clear()
            vorname.clear()
            middlename.clear()
            company.clear()
            passport.clear()
        }

}
