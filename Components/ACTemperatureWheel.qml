import QtQuick
import QtQuick.Shapes

// 温度滚轮（设计稿 1:1，272×511：弧形排布 + 暗弧带 + 指示器）
// 弧线偏移表取自 Figma 解码数据（相对选中项 d=-3..+3 的 x中心/y中心/字号/不透明度）
Item {
    id: root

    property real temperature: 24
    property int minTemp: 16
    property int maxTemp: 32
    property real step: 0.5
    property int direction: 0   // 0-右轮(弧向右凸) 1-左轮(镜像)
    property string currentTextColor: "#04FAFB"
    property string otherTextColor: "#DFDFDF"

    readonly property int entryCount: Math.round((maxTemp - minTemp) / step) + 1
    readonly property int currentIndex: Math.max(0, Math.min(entryCount - 1, Math.round((maxTemp - temperature) / step)))

    // 用户拖动结束后发出，外部写回后端；temperature 保持声明式绑定
    signal temperatureEdited(real temp)

    // 弧线偏移表（设计稿右轮：Ellipse 458/459 弧带 + 文字 25°..19° 实测坐标）
    readonly property var arc: [
        { x: 156.5, y: 32.5,  s: 28, o: 0.3 },
        { x: 178.5, y: 102.5, s: 28, o: 0.5 },
        { x: 197,   y: 176,   s: 36, o: 0.6 },
        { x: 201.5, y: 257.5, s: 38, o: 1.0 },
        { x: 197.5, y: 338,   s: 36, o: 0.6 },
        { x: 178.5, y: 412.5, s: 28, o: 0.5 },
        { x: 168.5, y: 477.5, s: 28, o: 0.3 }
    ]

    // 滚轮背景（设计资产 left/right_temperatur_background.png 272×511，含暗弧带与细环结构）
    Image {
        x: 0; y: 0
        width: 272; height: 511
        source: root.direction === 0 ? "qrc:/Images/AC/right_temperatur_background.png"
                                     : "qrc:/Images/AC/left_temperatur_background.png"
        fillMode: Image.Stretch
    }

    // 指示器（箭头 + 渐变线 + 圆点，坐标取自设计稿 Vector 503 / Rectangle 3464240 / Ellipse 461）
    Rectangle {
        x: root.direction === 0 ? 121 : 143
        y: 251
        width: 8; height: 15
        radius: 1
        color: "#04FAFB"
    }
    Rectangle {
        x: root.direction === 0 ? 126 : 3
        y: 258
        width: 143; height: 1
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: root.direction === 0 ? "#04FAFB" : "#1845D0" }
            GradientStop { position: 1.0; color: root.direction === 0 ? "#1845D0" : "#04FAFB" }
        }
    }
    Rectangle {
        x: root.direction === 0 ? 265 : 0
        y: 255
        width: 7; height: 7
        radius: 3.5
        color: "#A3FFFF"
    }

    Repeater {
        model: root.entryCount

        Text {
            id: delegateText
            required property int index
            readonly property int d: Math.max(-3, Math.min(3, index - root.currentIndex))
            readonly property var a: root.arc[d + 3]

            x: (root.direction === 0 ? a.x : 272 - a.x) - width / 2
            y: a.y - height / 2
            opacity: Math.abs(index - root.currentIndex) > 3 ? 0.0 : a.o
            text: {
                var v = root.maxTemp - index * root.step
                return (v % 1 === 0 ? v : v.toFixed(1)) + "°"
            }
            color: index === root.currentIndex ? root.currentTextColor : root.otherTextColor
            font.family: "PingFang SC"
            font.weight: Font.Medium
            font.pixelSize: a.s

            Behavior on x { NumberAnimation { duration: 120 } }
            Behavior on y { NumberAnimation { duration: 120 } }
            Behavior on opacity { NumberAnimation { duration: 120 } }
        }
    }

    // 拖动换值（每 70px 一档，范围由 Interface 钳制）
    MouseArea {
        id: dragArea
        anchors.fill: parent
        property real lastY: 0
        property real acc: 0

        onPressed: (mouse) => lastY = mouse.y
        onPositionChanged: (mouse) => {
            acc += mouse.y - lastY
            lastY = mouse.y
            while (acc <= -70) {
                acc += 70
                root.temperatureEdited(Math.min(root.maxTemp, root.temperature + root.step))
            }
            while (acc >= 70) {
                acc -= 70
                root.temperatureEdited(Math.max(root.minTemp, root.temperature - root.step))
            }
        }
    }
}
