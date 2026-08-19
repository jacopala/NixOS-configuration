import Quickshell
import Quickshell.Io

ShellRoot {
    // Option A: Toggle via a global property or track state
    property bool panelVisible: false

    IpcHandler {
        target: "elements"
        function appear() {
            panelVisible = true;
        }
        function disappear() {
            panelVisible = false;
        }
    }

    PanelWindow {
       visible: panelVisible
       anchors {
         top: true
         left: true
       }
    }
}

