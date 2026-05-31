import QtQuick

Item {
    id: leftNav
    width: 96
    height: parent ? parent.height : 808

    // 背景
    Rectangle {
        anchors.fill: parent
        color: "#1A1A2E"
    }

    // 导航项列表
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 60
        spacing: 8

        Repeater {
            model: ListModel {
                ListElement { name: "Home"; icon: "qrc:/Images/Home/home.png"; page: 1 }
                ListElement { name: "空调"; icon: "qrc:/Images/ACBar/fan.png"; page: 2 }
                ListElement { name: "应用"; icon: "qrc:/Images/Home/app.png"; page: 3 }
                ListElement { name: "设置"; icon: "qrc:/Images/Home/rotation.png"; page: 4 }
                ListElement { name: "控制"; icon: "qrc:/Images/Home/menu.png"; page: 5 }
            }

            delegate: Item {
                width: 80
                height: 80
                anchors.horizontalCenter: parent.horizontalCenter

                // 选中高亮背景
                Rectangle {
                    anchors.fill: parent
                    radius: 12
                    color: ui.pageIndex === model.page ? "#3D5AFE" : (mouseArea.containsMouse ? "#2A2A4A" : "transparent")
                    opacity: ui.pageIndex === model.page ? 0.8 : 1.0
                }

                Column {
                    anchors.centerIn: parent
                    spacing: 6

                    Image {
                        width: 32; height: 32
                        source: model.icon
                        anchors.horizontalCenter: parent.horizontalCenter
                        // 选中态稍微提亮
                        opacity: ui.pageIndex === model.page ? 1.0 : 0.7
                    }

                    Text {
                        text: model.name
                        color: "white"
                        font.pixelSize: 12
                        anchors.horizontalCenter: parent.horizontalCenter
                        opacity: ui.pageIndex === model.page ? 1.0 : 0.6
                    }
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        ui.pageIndex = model.page
                    }
                }
            }
        }
    }

    // 底部关机按钮
    Item {
        width: 80
        height: 60
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20

        Column {
            anchors.centerIn: parent
            spacing: 4

            Image {
                width: 28; height: 28
                source: "qrc:/Images/Home/shutdown.png"
                anchors.horizontalCenter: parent.horizontalCenter
                opacity: 0.6
            }

            Text {
                text: "关机"
                color: "white"
                font.pixelSize: 11
                anchors.horizontalCenter: parent.horizontalCenter
                opacity: 0.6
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                Qt.quit()
            }
            onEntered: parent.opacity = 1.0
            onExited: parent.opacity = 0.6
        }
    }
}
