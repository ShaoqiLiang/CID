import QtQuick

// 图标开关（控制中心，设计稿 113×113 r=14）
// 未选中: 黑底 + 亮色图标 + 白色文字
// 选中:   白底 + 暗色图标 + 深色文字
// 素材对应: iconLight 为亮色版图标(暗底显示), iconDark 为暗色版图标(白底显示)
// iconText 非空时显示文字图标（如 HUD/ESP），优先于图片
Item {
    id: root

    property bool checked: false
    property string iconLight: ""
    property string iconDark: ""
    property string iconText: ""
    property int iconWidth: 40
    property int iconHeight: 40
    property string text: ""
    property int fontPixelSize: 16

    // 组件不自行改状态，由外部写回（保持 checked 可声明式绑定）
    signal toggled(bool checked)

    Rectangle {
        anchors.fill: parent
        radius: 14
        color: root.checked ? "#FFFFFF" : "#000000"

        Behavior on color { ColorAnimation { duration: 150 } }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 25
            visible: root.iconText !== ""
            text: root.iconText
            color: root.checked ? "#282848" : "#FFFFFF"
            font.family: "PingFang SC"
            font.weight: Font.Semibold
            font.pixelSize: 24
        }

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 25
            width: root.iconWidth
            height: root.iconHeight
            visible: root.iconText === ""
            source: root.checked ? root.iconDark : root.iconLight
            fillMode: Image.PreserveAspectFit
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 75
            text: root.text
            color: root.checked ? "#000000" : "#FFFFFF"
            font.family: "PingFang SC"
            font.weight: Font.Medium
            font.pixelSize: root.fontPixelSize
        }

        MouseArea {
            anchors.fill: parent
            onClicked: root.toggled(!root.checked)
        }
    }
}
