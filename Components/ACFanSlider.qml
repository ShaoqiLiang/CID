import QtQuick

// 风量滑块组件
Item {
    id: root

    property int minValue: 0
    property int maxValue: 7
    property int value: 3
    property string startColor: "#0532FB"
    property string endColor: "#52E6FB"
    property string backgroundColor: "#80000000"

    // 背景
    Rectangle {
        id: bgRect
        anchors.fill: parent
        color: root.backgroundColor
        radius: height / 2

        // 进度条
        Rectangle {
            id: progressRect
            width: getWidth()
            height: parent.height
            radius: height / 2

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: root.startColor }
                GradientStop { position: 1.0; color: root.endColor }
            }

            Behavior on width {
                NumberAnimation { duration: 150 }
            }

            function getWidth() {
                var step = bgRect.width / (root.maxValue + 1)
                var w = root.value * step
                if (root.value === root.maxValue) w = bgRect.width
                return Math.min(w, bgRect.width)
            }
        }

        // 滑块交互
        MouseArea {
            anchors.fill: parent
            onClicked: (mouse) => {
                var step = bgRect.width / (root.maxValue + 1)
                var newValue = Math.round(mouse.x / step)
                newValue = Math.max(root.minValue, Math.min(root.maxValue, newValue))
                root.value = newValue
            }
        }
    }
}
