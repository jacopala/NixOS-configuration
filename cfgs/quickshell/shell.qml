import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

PanelWindow {
   id: root

   // Theme
   property color background: "#1e2326"
   property color primary: "#a7c080"
   property color secondary: "#7fbbb3"
   property color tertiary: "#d599b6"
   property color quaternary: "#83c092"
   property string fontFamily: "FantasqueSansM Nerd Font"
   property int fontSize: 15

   property int cpuUsage: 0
   property var lastCpuIdle: 0
   property var lastCpuTotal: 0
   property int memUsage: 0
   property int batLeft: 0
   property var curVolume: -1
   property int curBright: 0
   property int maxBright: 65535

   // CPU measurements
   Process {
      id: cpuProc
      command: ["sh", "-c", "head -1 /proc/stat"]
      stdout: SplitParser {
         onRead: data => {
            var p = data.trim().split(/\s+/)
            var idle = parseInt(p[4]) + parseInt(p[5])
            var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
            if (lastCpuTotal > 0) {
               cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
            }
            lastCpuTotal = total
            lastCpuIdle = idle
         }
      }
      Component.onCompleted: running = true
   }
   // Memory measurements
   Process {
      id: memProc
      command: ["sh", "-c", "free | grep Mem"]
      stdout: SplitParser {
         onRead: data => {
            var p = data.trim().split(/\s+/)
            var total = parseInt(p[1]) || 1
            var used = parseInt(p[2]) || 0
            memUsage = Math.round(100 * used / total)
         }
      }
      Component.onCompleted: running = true
   }
   // Battery measurements
   Process {
      id: batProc
      command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
      stdout: SplitParser {
         onRead: data => {
            batLeft = data
         }
      }
      Component.onCompleted: running = true
   }
   // Volume measurements (WIP)
   Process {
      id: volProc
      command: ["pactl", "get-sink-volume @DEFAULT_SINK@ | sed 's/^[^\/]*//g' | cut -c 4-6"]
      stdout: SplitParser {
         onRead: data => {
            curVolume = data
         }
      }
      Component.onCompleted: running = true
   }
   // Brightness measurements
   Process {
      id: brightProc
      command: ["brightnessctl", "g"]
      stdout: SplitParser {
         onRead: data => {
            curBright = (data/maxBright)*100
         }
      }
      Component.onCompleted: running = true
   }
   Timer {
      interval: 5000
      running: true
      repeat: true
      onTriggered: {
         cpuProc.running = true
         memProc.running = true
         batProc.running = true
         volProc.running = true
         brightProc.running = true
      }
   }

   // Layout
   anchors.top:true
   anchors.left:true
   anchors.right:true
   implicitHeight: 30
   color: background

   RowLayout {
      anchors.fill: parent
      anchors.centerIn: parent
      anchors.leftMargin: 15
      anchors.rightMargin: 15
      spacing: 8

      Text {
         id: clock
         text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
         color: root.primary
         font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
         Timer {
            interval: 10000
            running: true
            repeat: true
            onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
         }
      }

      Item { Layout.fillWidth: true }

      Text {
         id: brightness
         text: "Br: " + curBright + "%" + "  | "
         color: root.primary
         font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
      }

      Text {
         id: memory
         text: "Mem: " + memUsage + "%" + "  | "
         color: root.secondary
         font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
      }

      Text {
         id: cpu
         text: "CPU: " + cpuUsage + "%" + "  | "
         color: root.tertiary
         font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
      }

      Text {
         id: battery
         text: "Bat: " + batLeft + "%"
         color: root.quaternary
         font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
      }
   }
}
