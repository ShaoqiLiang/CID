import QtQuick

// 风量滑条（设计稿 1:1，535×19：轨道 #5C626C→#343C4A，滑块 #0532FB→#52E6FB）
Item {
    id: root

    property int value: 4
    property int maxValue: 7

    // 组件不自行改状态，由外部写回（保持 value 可声明式绑定）
    signal valueEdited(int newValue)

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#5C626C" }
            GradientStop { position: 1.0; color: "#343C4A" }
        }
    }

    Rectangle {
        width: root.maxValue > 0 ? parent.width * root.value / root.maxValue : 0
        height: parent.height
        radius: height / 2
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#0532FB" }
            GradientStop { position: 1.0; color: "#52E6FB" }
        }
    }

    MouseArea {
        anchors.fill: parent
        preventStealing: true

        onClicked: (mouse) => root.updateValue(mouse.x)
        onPositionChanged: (mouse) => {
            if (pressed) root.updateValue(mouse.x)
        }

        function updateValue(x) {
            root.valueEdited(Math.max(0, Math.min(root.maxValue, Math.round(x / parent.width * root.maxValue))))
        }
    }
}
