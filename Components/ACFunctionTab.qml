import QtQuick

// 空调顶部功能 Tab（设计稿 1:1，882×70 r=35，选中胶囊 208×70，文字按设计坐标摆放）
Item {
    id: root

    property var tabs: []
    property var tabX: []   // 各文字左缘（相对组件，取自设计稿）
    property var tabW: []   // 各文字宽
    property int currentIndex: 0

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: "#2B364B"
    }

    // 选中胶囊（居中于当前文字，208×70 渐变）
    Rectangle {
        width: 208
        height: parent.height
        radius: height / 2
        x: root.tabX[root.currentIndex] + root.tabW[root.currentIndex] / 2 - width / 2

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#43FFFF" }
            GradientStop { position: 1.0; color: "#0978E9" }
        }

        Behavior on x {
            NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
        }
    }

    Repeater {
        model: root.tabs.length

        Item {
            x: root.tabX[index] - 20
            width: root.tabW[index] + 40
            height: parent.height

            Text {
                x: 20
                y: 18
                text: root.tabs[index]
                color: "white"
                font.family: "PingFang SC"
                font.weight: Font.Medium
                font.pixelSize: 24
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.currentIndex = index
            }
        }
    }
}
