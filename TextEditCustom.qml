import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4



Rectangle{
 radius: 10
 clip: true
 Layout.fillWidth: true
 height: 150
 border.width: commentTextEdit.focus ? 2 : 1
 border.color: commentTextEdit.focus ? "steelblue" : "#aaaaaa"
 TextEdit {
     id: commentTextEdit;
     anchors.fill:parent;
     color: "#333333";
     wrapMode: TextEdit.WordWrap;
     textMargin: 5;
     selectByMouse : true}
    }
