import Quickshell
import Quickshell.Widgets
import QtQuick

PanelWindow {
   anchors.top:true
   anchors.left:true
   anchors.right:true
   implicitHeight: 30
   color: "#00000000"
   Rectangle {
      anchors.verticalCenter: parent
      anchors.fill: parent
      color: "#414b50"
      radius: 30
      Text {
         anchors.verticalCenter: Rectangle
         text: "Hello"
         color: "#a7c080"
         font.pixelSize: 14
      }
   }
}
