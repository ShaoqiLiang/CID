import QtQuick

Rectangle {
    id: slider
    width: parent.width
    height: 19
    radius: 10
    color: "#21262D"

    property real value: 0.5  // 0.0 - 1.0
    property real minimumValue: 0.0
    property real maximumValue: 1.0

    // 用户拖动后发出，外部写回状态；value 保持声明式绑定
    signal valueEdited(real value)

    // 进度条
    Rectangle {
        id: progress
        width: Math.max(10, parent.width * slider.value)
        height: parent.height
        radius: 10
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#0532FB" }
            GradientStop { position: 1.0; color: "#52E6FB" }
        }

        Behavior on width {
            NumberAnimation { duration: 100 }
        }
    }

    // 滑动指示器（圆形手柄）
    Rectangle {
        id: handle
        width: 28
        height: 28
        radius: 14
        color: "white"
        anchors.verticalCenter: parent.verticalCenter
        x: Math.max(0, Math.min(parent.width - width, progress.width - width / 2))

        // 添加阴影效果
        Rectangle {
            anchors.fill: parent
            anchors.margins: -2
            radius: 16
            color: "#40000000"
            z: -1
        }

        Behavior on x {
            NumberAnimation { duration: 100 }
        }
    }

    // 鼠标区域 - 支持点击和拖动
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        preventStealing: true

        property bool isDragging: false

        onPressed: (mouse) => {
            isDragging = true
            updateValue(mouse.x)
        }

        onPositionChanged: (mouse) => {
            if (isDragging) {
                updateValue(mouse.x)
            }
        }

        onReleased: {
            isDragging = false
        }

        function updateValue(x) {
            var ratio = Math.max(0, Math.min(1, x / parent.width))
            slider.valueEdited(slider.minimumValue + ratio * (slider.maximumValue - slider.minimumValue))
        }
    }
}
