import QtQuick

// 空调顶部功能 Tab 栏
Item {
    id: root

    property var tabs: ["空调", "通风加热", "滤净", "空调设置"]
    property int currentIndex: 0
    property string backgroundColor: "#2B364B"
    property string selectedStartColor: "#43FFFF"
    property string selectedEndColor: "#0978E9"

    Rectangle {
        anchors.fill: parent
        color: root.backgroundColor
        radius: height / 2
    }

    // 选中滑块
    Rectangle {
        id: selectedRect
        width: root.width / root.tabs.length
        height: parent.height
        radius: height / 2
        x: currentIndex * width

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: root.selectedStartColor }
            GradientStop { position: 1.0; color: root.selectedEndColor }
        }

        Behavior on x {
            NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
        }
    }

    // Tab 按钮
    Row {
        anchors.fill: parent

        Repeater {
            model: root.tabs.length

            Item {
                width: root.width / root.tabs.length
                height: parent.height

                Text {
                    anchors.centerIn: parent
                    text: root.tabs[index]
                    color: "white"
                    font.pixelSize: 20
                    font.bold: root.currentIndex === index
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        root.currentIndex = index
                    }
                }
            }
        }
    }
}
