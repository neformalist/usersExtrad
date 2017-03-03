import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4

Dialog {
    visible: false
    width: 640
    height: 480
    id: dialogAddUserToMain
   contentItem: Rectangle {
        color: "white"

        ListView {
         id: list_view1
         model: usersModel
         width: parent.width
         height: parent.height
         anchors.fill: parent
         anchors.margins: 15
         spacing : 7
         highlight: Rectangle {
             color: "#E6F0FB"
             radius: 5;
             border.color: "#777777"
             border.width: 2
             Image {
                 id: addUserIcon
                 source: "icons/AddUser.png"
                 width: mouseAreaAddUserIcon.pressed ? parent.width/11 : parent.width/10
                 height: mouseAreaAddUserIcon.pressed ? parent.height - 12 : parent.height - 10
                 anchors.right: parent.right
                 anchors.top: parent.top
                 //anchors.bottom: parent.bottom
                 anchors.rightMargin: 15
                 anchors.topMargin: 5
                 //anchors.bottomMargin: 5
                 MouseArea {
                    id: mouseAreaAddUserIcon
                    anchors.fill: parent
                    hoverEnabled: true
                    //cursorShape: Qt.ClosedHandCursor
                    onEntered: {cursorShape = Qt.PointingHandCursor}
                    onExited: {cursorShape = Qt.ArrowCursor}
                    onClicked: {
                          userNameMain.text = usersModel.get(list_view1.currentIndex).name + " " + usersModel.get(list_view1.currentIndex).vorname + " " + usersModel.get(list_view1.currentIndex).middlename
                          userNameMain.idUser = usersModel.get(list_view1.currentIndex).id
                          userCompanyMain.text = usersModel.get(list_view1.currentIndex).company
                          dialogAddUserToMain.close()
                    }
                 }
             }
         }
         highlightMoveDuration : 200
         focus: true

         delegate: Item {
             id: delegate
             width: delegate.ListView.view.width;
             height: 60
             clip: true

             Column {
                 anchors.margins: 5
                 anchors.fill: parent
                 spacing: 2
                    Text {text: name + " " + vorname + " " + middlename; color: "#333333"; anchors.left: parent.left; anchors.leftMargin: 5; elide: Text.ElideRight; width: dialogAddUserToMain.width-120}
                    Text {text: company; color: "#999999"; anchors.left: parent.left; anchors.leftMargin: 8; elide: Text.ElideRight; width: dialogAddUserToMain.width-120}
             }

             MouseArea {
               id : mouseAreaListUser
               anchors.left: parent.left
               width: delegate.ListView.view.width - delegate.ListView.view.width/10 - 15
               height: parent.height
               onClicked: {
                 list_view1.currentIndex = index;
               }
             }
         }


        }
   }
}
