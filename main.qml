import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import "menu"

Window {
    visible: true
    title: qsTr("Выдача материала")
    minimumWidth: 740
    minimumHeight: 480
    id: mainWindowProgramm
    Gradients {id: clubcolors}

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#618CC5" }
            GradientStop { position: 1.0; color: "#ffffff" }
        }
        border.color: "#618CC5"
    }

    TabView {
        anchors.fill: parent
        anchors.margins: Math.max(Window.width/100)
        Tab {
            title: "Последние события"
            TableView {
                id: mainTabTable

                TableViewColumn {
                    id : tableTitle
                    role: "title"
                    title: "Шифр"
                    //width: 200

                }
                TableViewColumn {
                    id: tableAuthor
                    role: "author"
                    title: "Автор (Фамилия)"
                    //width: 200
                    width: contentItem.width
                }
              style: TableViewStyle {
                    headerDelegate: Rectangle {
                        height: textItem.implicitHeight * 2
                        width: textItem.implicitWidth * 1.2
                        color: "lightsteelblue"
                        border.color: "#8493A7"
                        Text {
                                id: textItem
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
                                id: textRow
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
                model: libraryModel
            }
        }
        Tab {
            id: newExtrad
            title: "Новая выдача"
            Rectangle {
                id: tabExtrad
                anchors.fill: parent

                RowLayout {
                    spacing: Math.max(Window.width/40)
                    anchors.fill: parent
                    anchors.margins: Math.max(Window.width/40)

                   ColumnLayout{
                       //anchors.fill: parent
                       //Layout.fillWidth: true
                      // Layout.fillHeight: true
                       anchors.top: parent.top
                       RowLayout {
                            id: firstGrid
                            anchors.top: parent.top
                            spacing: 10
                            LabelAddUser{text: "Выберите пользователя "; color: "#777777"}
                            Rectangle {
                                width: 140
                                height: 50
                                color: addUserButtom.pressed ? Qt.darker("#5CB85C", 1.3) : "#5CB85C"
                                radius: 4
                                Text {
                                    text: userNameMain.text.length == 0 ? qsTr("Добавить") : qsTr("Заменить")
                                    color: "white"
                                    anchors.centerIn: parent
                                }
                                MouseArea {
                                    id: addUserButtom
                                    anchors.fill: parent
                                    onClicked: {
                                       dialogAddUser.open()
                                    }
                                }
                            }
                            Rectangle {
                                visible: userNameMain.text.length > 0 ? true : false
                                width: 140
                                height: 50
                                color: addUserButtomClear.pressed ? Qt.darker("#D9534F", 1.3) : "#D9534F"
                                radius: 4
                                Text {
                                    text: qsTr("Очистить")
                                    color: "white"
                                    anchors.centerIn: parent
                                }
                                MouseArea {
                                    id: addUserButtomClear
                                    anchors.fill: parent
                                    onClicked: {
                                       userNameMain.text = ""
                                       userCompanyMain.text = ""
                                    }
                                }
                            }
                        }
                       Rectangle {
                        id: nameUserPanel
                        implicitHeight: columnUserData.implicitHeight+10
                        Layout.fillWidth: true
                        //Layout.fillHeight: true
                        //border.color: "black"
                        ColumnLayout {
                               id : columnUserData
                               anchors.top: parent.top
                               anchors.left: parent.left
                               anchors.topMargin: 10
                               anchors.leftMargin: 10
                               spacing: 10
                               Row {
                                spacing: 10
                                Rectangle {
                                width: 50
                                height: userNameMain.text.length > 0 ? textNameUser.height : 0
                                Text{id: textNameUser; text: "ФИО "; color: "#777777"; visible: (userNameMain.text.length > 0) ? true : false; padding: 5}
                                }
                                Rectangle {
                                x: 50
                                radius: 2
                                width: userNameMain.width > userNameMain.implicitWidth ? userNameMain.implicitWidth : userNameMain.width
                                height: userNameMain.text.length > 0 ? userNameMain.height : 0
                                border.color: userNameMain.text.length > 0 ? "#aaaaaa" : "transparent"
                                Text {id: userNameMain; wrapMode: Text.WordWrap; width: 250; padding: 5}
                                }

                               }
                               Row {
                                spacing: 10
                                Rectangle {
                                    width: 130
                                    height: userNameMain.text.length > 0 ? userCompanyMain.height : 0
                                    Text{text: "Организация ";  color: "#777777"; visible: (userNameMain.text.length > 0) ? true : false; padding: 5}
                                }
                                Rectangle {
                                    radius: 2
                                    border.color: userNameMain.text.length > 0 ? "#aaaaaa" : "transparent"
                                    width: userCompanyMain.width > userCompanyMain.implicitWidth ? userCompanyMain.implicitWidth : userCompanyMain.width
                                    height: userNameMain.text.length > 0 ? userCompanyMain.height : 0
                                    Text {id: userCompanyMain;  wrapMode: Text.WordWrap; width: 200; padding: 5}
                                }
                               }
                            }
                        }
                       GridLayout{
                           Layout.fillHeight: true
                           Layout.fillWidth: true

                           columns: 2
                           LabelAddUser{text: "Примечания "; color: "#777777"}
                           Rectangle{
                            clip: true
                            Layout.fillWidth: true
                            height: 150
                            border.width: noteTextEdit.focus ? 2 : 1
                            border.color: noteTextEdit.focus ? "steelblue" : "#aaaaaa"
                            TextEdit {id: noteTextEdit; anchors.fill:parent; color: "#333333"; wrapMode: TextEdit.WordWrap; textMargin: 5; selectByMouse : true}
                           }
                           LabelAddUser{text: "Комментарии "; color: "#777777"}
                           Rectangle{
                            clip: true
                            Layout.fillWidth: true
                            height: 150
                            border.width: commentTextEdit.focus ? 2 : 1
                            border.color: commentTextEdit.focus ? "steelblue" : "#aaaaaa"
                            TextEdit {id: commentTextEdit; anchors.fill:parent; color: "#333333"; wrapMode: TextEdit.WordWrap; textMargin: 5; selectByMouse : true}
                           }

                       }
                    }



                   DialogAddUser {id: dialogAddUser; title: "Выберите пользователь"}

                    Rectangle {
                        Layout.fillHeight: true
                        id: secondGrid
                        Layout.fillWidth: true
                        width: tabExtrad.width
                        implicitHeight: parent.height
                        border.color: "black"
                        clip: true
                        RowLayout {
                            //Layout.fillWidth: true
                            //width: parent.width
                            anchors.top: parent.top
                            anchors.left: parent.left
                            //anchors.right: parent.right
                            anchors.topMargin: 10
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10
                            spacing: 10
                            LabelAddUser{text: "Введите шифр "}
                            TextInputStyleUsers {id: addCodeInput; widthValue: 150}
                            Rectangle {
                                radius: 4
                                implicitWidth: 150
                                height: 50
                                color: "#5CB85C"
                                Text{text: "Добавить"; anchors.centerIn: parent; color: "white"}
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {

                                    }
                                }
                            }
                        }
                        TableView{
                            anchors.fill: secondGrid
                            anchors.topMargin: 70
                            id: tableAddCode
                            TableViewColumn{title: "Шифр"}
                            TableViewColumn{title: "Фамилия автора"}
                            TableViewColumn{title: "Имя автора"}
                            TableViewColumn{title: "Название произведения"}
                            TableViewColumn{title: "Материал"}
                            TableViewColumn{title: "-------"}
                            TableViewColumn{title: "------"}
                            TableViewColumn{title: "-----"}
                            TableViewColumn{title: "-------"}
                            TableViewColumn{title: "-------"}
                        }
                    }



                }

            }
        }
        Tab {
            title: "Пользователи"
            Rectangle {
                id: mainUser
                color: "steelblue"
                Rectangle {
                   id: addNewUseButtom
                   anchors.top: parent.top
                   anchors.left: parent.left
                   anchors.margins: 5
                   implicitWidth: Math.max(textButtomAddUserBlock.implicitWidth + imageAddUserBlock.implicitWidth + 50)
                   implicitHeight: Math.max(Window.height/15)
                   radius: 5
                   color: newUserDialogMouseArea.pressed ? Qt.darker("#D9534F", 1.3) : "#D9534F"
                   border.color: newUserDialogMouseArea.pressed ? "#D9534F" : "#00000000"

                   RowLayout {
                   id: addButtomAddUserBlock
                   anchors.fill: parent
                   spacing: 2
                       Text {
                               id: textButtomAddUserBlock
                               anchors.left: parent.left
                               anchors.leftMargin: 20
                               text: "Добавить"
                               color:  "white"
                               font.pixelSize: Window.height/50
                             }
                       Image {
                          id: imageAddUserBlock
                          anchors.left: textButtomAddUserBlock.right
                          anchors.leftMargin: 10
                          source: "icons/Add.png"
                          sourceSize.width: Math.max(Window.width/30)
                          sourceSize.height: Math.max(Window.height/30)
                       }
                   }
                   MouseArea {
                        id: newUserDialogMouseArea
                        anchors.fill: parent
                        onClicked: newUserDialog.open()
                   }
                }
                TableUsers{id : tableUsers}
                MessageDialogs{id: insertUser}
                MessageDialogs{id: updateUser}
                MessageDialogDelete {id: deleteUser}
                MessageDialogs{id: deleteUserMessage}
                DialogsNewUser {
                    id: updateUserDialog
                    textButtom: "Изменить"
                    title: "Изенить пользователя"
                    typeCall: 2
                }
                DialogsNewUser {
                    id: newUserDialog
                    title: "Новый пользователь"
                    textButtom: "Добавить"
                    typeCall: 1
                }

                Connections {
                    target: tableUsers
                    onSuccessInsertUser: {
                        newUserDialog.clearField()
                        newUserDialog.close()  
                    }
                    onSuccessUpdateUser : {
                        updateUserDialog.close()
                    }

                }
                MenuUsers{id: contextMenuUser}
            }
        }
        Tab {
            title: "Поиск"
            Rectangle {}
        }
        style: TabViewStyle {
                frameOverlap: 1
                tab: Rectangle {
                    function loadImage(index) {
                       return "icons/tab"+index+".png";
                    }
                    gradient: styleData.selected ? clubcolors : null
                    border.color:  "steelblue"
                    color: "lightsteelblue"
                    implicitWidth: (Math.max(Window.width/10) < Math.max(imageTabBlock.implicitWidth + textTabBlock.implicitWidth)) ? Math.max(imageTabBlock.implicitWidth + textTabBlock.implicitWidth + 50) : Math.max(Window.width/10+50)
                    implicitHeight: Math.max(Window.height/12)
                    radius: 2
                    RowLayout {
                    id: tabBlock
                    anchors.fill: parent
                    spacing: 2
                        Image {
                           id: imageTabBlock
                           anchors.left: parent.left
                           anchors.leftMargin: 10
                           source: loadImage(styleData.index)
                           sourceSize.width: Math.max(Window.width/20)
                           sourceSize.height: Math.max(Window.height/20)
                        }
                        Text {
                            id: textTabBlock
                            anchors.left: imageTabBlock.right
                            anchors.leftMargin: 10
                            text: styleData.title
                            font.pixelSize: Window.height/50
                            color: styleData.selected ? "white" : "black"
                        }
                    }

                    /*Rectangle {
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height : 3
                        color: styleData.selected ? "white" :"lightsteelblue"
                    }*/

                }
            }
        ListModel {
            id: libraryModel
            ListElement {
                title: "AAA"
                author: "Gabriel Brilliance Outstanding"
            }
            ListElement {
                title: "Brilliance"
                author: "Jens"
            }
            ListElement {
                title: "Outstanding"
                author: "Frederik"
            }
        }


    }
}
