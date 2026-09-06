import QtQuick
import "../Components"

// 地图页（设计稿 1:1，坐标 = 设计稿整屏坐标 − (96, 48)；状态栏设计隐藏）
Item {
    width: parent ? parent.width : 1424
    height: parent ? parent.height : 808

    // 内容面板
    Rectangle {
        x: 11; y: 0
        width: 1414; height: 856
        radius: 30
        color: "#171E29"
    }

    // 3D 城市位图（截屏2022-06-01-15.12 [−131,−217] 2495×1331，Mask group [11,0] 裁切）
    Item {
        x: 11; y: 0
        width: 1414; height: 856
        clip: true

        Image {
            x: -238; y: -265
            width: 2495; height: 1331
            source: "qrc:/Images/Exported/Document_22_截屏2022-06-01-15.12_1.png"
            fillMode: Image.Stretch
        }

        // 暗角（Rectangle 17：#090C11/48% → 透明 → #000000）
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#7A090C11" }
                GradientStop { position: 0.31; color: "#00090C11" }
                GradientStop { position: 0.73; color: "#00090C11" }
                GradientStop { position: 1.0; color: "#FF000000" }
            }
        }
    }

    // 路线光斑（Ellipse 418/419）
    Rectangle {
        x: 875; y: 384
        width: 102; height: 75
        radius: 30
        color: "#2454FF"
    }
    Rectangle {
        x: 889; y: 393
        width: 72; height: 55
        radius: 24
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#45CBEA" }
            GradientStop { position: 1.0; color: "#1676EE" }
        }
    }

    // ==================== 搜索面板（Group 70 [162,56] 407×265） ====================
    Rectangle {
        x: 66; y: 8
        width: 407; height: 265
        radius: 10
        color: "#4E548D"
        opacity: 0.92

        // 搜索行
        Item {
            x: 35; y: 30
            width: 28; height: 33

            Rectangle {
                x: 0; y: 0
                width: 28; height: 28
                radius: 14
                color: "transparent"
                border.color: "white"
                border.width: 2
            }
            Rectangle {
                x: 22; y: 25
                width: 2; height: 7
                radius: 1
                rotation: -45
                color: "white"
            }
        }
        Text {
            x: 88; y: 30
            text: "搜索目的地"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Semibold
            font.pixelSize: 22
        }

        Rectangle {
            x: 0; y: 91
            width: 407; height: 2
            color: "white"
        }

        // 回家行
        Image {
            x: 35; y: 123
            width: 24; height: 26
            source: "qrc:/Images/Home/map_home.png"
            fillMode: Image.PreserveAspectFit
        }
        Text {
            x: 75; y: 121
            text: "回家"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Semibold
            font.pixelSize: 22
        }
        Text {
            x: 288; y: 122
            text: "点击设置"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Medium
            font.pixelSize: 20
        }

        Rectangle {
            x: 28; y: 177
            width: 351; height: 1
            color: "white"
        }

        // 去公司行
        Image {
            x: 35; y: 209
            width: 21; height: 25
            source: "qrc:/Images/Home/map_company.png"
            fillMode: Image.PreserveAspectFit
        }
        Text {
            x: 80; y: 213
            text: "去公司"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Semibold
            font.pixelSize: 22
        }
        Text {
            x: 289; y: 214
            text: "点击设置"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Medium
            font.pixelSize: 20
        }
    }

    // ==================== 右侧控制柱 ====================
    // 缩放（Group 67 [162,500] 70×157）
    Rectangle {
        x: 66; y: 452
        width: 70; height: 157
        radius: 35
        color: "#4E548D"
        opacity: 0.92

        // +
        Rectangle { x: 22; y: 60; width: 25; height: 5; radius: 2.5; color: "white" }
        Rectangle { x: 32; y: 50; width: 5; height: 25; radius: 2.5; color: "white" }
        // −
        Rectangle { x: 22; y: 112; width: 25; height: 5; radius: 2.5; color: "white" }
    }

    // 指北针（Group 72 [1420,73]）
    Rectangle {
        x: 1324; y: 25
        width: 70; height: 70
        radius: 10
        color: "#4E548D"
        opacity: 0.92

        Rectangle {
            anchors.centerIn: parent
            width: 12; height: 12
            rotation: 45
            color: "white"
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            text: "N"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Semibold
            font.pixelSize: 22
        }
    }

    // 定位（Group 73 [1420,496]）
    Rectangle {
        x: 1324; y: 448
        width: 70; height: 70
        radius: 10
        color: "#4E548D"
        opacity: 0.92

        Image {
            anchors.centerIn: parent
            width: 21; height: 29
            source: "qrc:/Images/Home/map_home.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    // 图层（Group 74 [1420,592]）
    Rectangle {
        x: 1324; y: 544
        width: 70; height: 70
        radius: 10
        color: "#4E548D"
        opacity: 0.92

        Rectangle {
            anchors.centerIn: parent
            width: 27; height: 27
            rotation: 45
            color: "white"
            border.color: "#D9D9D9"
            border.width: 2
        }
    }

    // ==================== 底部快捷条（Rectangle 18 [162,707] 1305×123） ====================
    ACQuickBar {
        x: 66; y: 659
    }
}
