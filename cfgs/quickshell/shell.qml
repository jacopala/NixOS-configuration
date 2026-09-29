import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

PanelWindow {
   anchors.top:true
   anchors.left:true
   anchors.right:true
   implicitHeight: 30
   color: "#1a1b26"

   Text {
      anchors.centerIn: parent
      text: "Hello"
      color: "#0db9d7"
      font.pixelSize: 14
   }
}
