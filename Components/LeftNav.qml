import QtQuick

// 左侧导航（设计稿图标条 + 新页面入口：地图/音乐）
Item {
    id: leftNav
    width: 96
    height: parent ? parent.height : 808

    // 背景
    Rectangle {
        anchors.fill: parent
        color: "#10141B"
    }

    // 头像（Frame 38，跨越状态栏区，负 y 绘制）
    Rectangle {
        x: 24; y: -24
        width: 68; height: 68
        radius: 34
        color: "#D9D9D9"
        border.color: "#5A6470"
        border.width: 1.5
        clip: true

        Image {
            anchors.fill: parent
            source: "qrc:/Images/Exported/Document_01_Ellipse_2.jpg"
            fillMode: Image.PreserveAspectCrop
        }
    }

    // 导航图标（设计稿 6 项：返回键(历史栈) + 主页/空调/应用/设置 + 关机；地图/音乐从主页卡片进入）
    Repeater {
        model: [
            { icon: "qrc:/Images/Home/back.png",      back: true },                // 返回键：历史栈回退
            { icon: "qrc:/Images/Home/home.png",      page: ui.PAGE_HOME },
            { icon: "qrc:/Images/ACBar/fan.png",      page: ui.PAGE_AC },
            { icon: "qrc:/Images/Home/menu.png",      page: ui.PAGE_APP },
            { icon: "qrc:/Images/Home/rotation.png",  page: ui.PAGE_SETTINGS },
            { icon: "qrc:/Images/Home/shutdown.png",  page: -1 }                   // 关机
        ]

        Item {
            x: 37
            y: [108, 226, 344, 461, 585, 702][index]
            width: 32; height: 32

            Image {
                anchors.fill: parent
                source: modelData.icon
                fillMode: Image.PreserveAspectFit
                opacity: modelData.page === -1 ? 0.6 : (modelData.back ? 1.0 : (ui.pageIndex === modelData.page ? 1.0 : (iconMouse.containsMouse ? 0.9 : 0.65)))
            }

            MouseArea {
                id: iconMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    if (modelData.page === -1) Qt.quit()
                    else if (modelData.back) ui.back()
                    else ui.pageIndex = modelData.page
                }
            }
        }
    }
}
