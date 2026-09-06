import QtQuick
import QtQuick.Controls

// 快捷滑条（控制中心）：图标 + 标题(可带副标) + 渐变填充进度
Item {
    id: root

    property string backgroundColor: "#80000000"
    property string fillColor: "#FFFFFF"

    property string iconActive: ""    // value > 0 且未被 iconMuted 覆盖时显示
    property string iconInactive: ""  // value == 0 时显示
    property int iconWidth: 36
    property int iconHeight: 31

    property string text: ""
    property int fontPixelSize: 20
    property string subText: ""       // 副标题(自动/手动)，空则不显示
    property color textColor: "#FFFFFF"
    property color subTextColor: "#FFFFFF"

    property int minValue: 0
    property int maxValue: 100
    property int value: 50

    // 组件不自行改状态，由外部写回（保持 value 可声明式绑定）
    signal valueEdited(int newValue)
    signal iconClicked()

    Rectangle {
        anchors.fill: parent
        color: root.backgroundColor
        radius: 14

        Rectangle {
            width: root.maxValue > 0
                   ? Math.min(parent.width, slider.value * parent.width / root.maxValue)
                   : 0
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            color: root.fillColor
            radius: 14
        }

        Image {
            id: icon
            width: root.iconWidth
            height: root.iconHeight
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.verticalCenter: parent.verticalCenter
            source: slider.value > 0 ? root.iconActive : root.iconInactive
            fillMode: Image.PreserveAspectFit
        }

        Column {
            anchors.left: icon.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 0

            Text {
                text: root.text
                color: root.textColor
                font.pixelSize: root.fontPixelSize
            }

            Text {
                text: root.subText
                color: root.subTextColor
                font.pixelSize: 14
                visible: root.subText !== ""
            }
        }

        // 点击图标区域触发（如静音切换）
        MouseArea {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 80
            onClicked: root.iconClicked()
        }

        Slider {
            id: slider
            anchors.fill: parent
            value: root.value
            from: root.minValue
            to: root.maxValue
            stepSize: 1
            focusPolicy: Qt.NoFocus

            background: Rectangle { implicitWidth: 0; implicitHeight: 0; color: "transparent" }
            handle: Rectangle { implicitWidth: 0; implicitHeight: 0; color: "transparent" }

            onMoved: root.valueEdited(value)
        }
    }
}
