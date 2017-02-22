import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

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
            title: "Новая выдача"
            Rectangle {
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
                MessageDialogDelete {id: deleteUser}
                MessageDialogs{id: deleteUserMessage}
                Connections {
                    target: tableUsers
                    onSuccessInsertUser: {
                        newUserDialog.clearField()
                        newUserDialog.close()
                    }
                }
                Menu {
                id: contextMenuDeleteUser
                    MenuItem {
                        text: qsTr("Удалить")
                        onTriggered: {
                                deleteUser.objectName = "deleteUser"
                                deleteUser.textValue = "Вы действительно хотите удалить пользователя?"
                                deleteUser.open()
                        }
                    }
                    MenuItem {
                       text: qsTr("Редактировать")
                       onTriggered: {
                            console.log(usersModel.data(usersModel.index(tableUsers.currentRow, 2), 103))
                            updateUserDialog.open()
                       }
                    }
                style: MenuStyle {

                    frame: Rectangle {
                       color: "#fff"
                        border.width: 2
                        radius: 5
                      }
                    itemDelegate.label: Text {
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 8
                        color: styleData.selected ? "white" : "black"
                        text: styleData.text
                      }

                   itemDelegate.background: Rectangle {
                        width: 500
                        height: 300
                        radius: 2
                        color: styleData.selected ? "darkGray" : "transparent"
                     }
                    }

                }
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
        DialogsNewUser {
            id: newUserDialog
            textButtom: "Добавить"
        }
        DialogsNewUser {
            id: updateUserDialog
            textButtom: "Изменить"
        }

    }
}
