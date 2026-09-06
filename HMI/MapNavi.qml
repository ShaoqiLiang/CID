import QtQuick
import QtQuick.Shapes
import "../Components"

// 地图导航页（设计稿 1:1，与地图页同底：城市位图 + 暗角 + 底部条；导航细节待补）
Item {
    width: parent ? parent.width : 1424
    height: parent ? parent.height : 808

    Rectangle {
        x: 11; y: 0
        width: 1414; height: 856
        radius: 30
        color: "#171E29"
    }

    // 3D 城市位图 + 暗角（与地图页一致）
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

    // 路线光斑
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

    // ==================== 导航卡（Group 165 [162,56] 284×166） ====================
    Rectangle {
        x: 66; y: 8
        width: 284; height: 122
        radius: 10
        color: "#4E548D"
        opacity: 0.92

        // 大转向箭头（Group 85 [208,84]：白色粗箭头）
        Rectangle {
            x: 30; y: 12
            width: 12; height: 44
            rotation: -46
            color: "white"
        }
        Shape {
            x: 22; y: 6
            width: 42; height: 30
            ShapePath {
                strokeWidth: -1
                fillColor: "#FFFFFF"
                startX: 0; startY: 30
                PathLine { x: 21; y: 0 }
                PathLine { x: 42; y: 30 }
                PathLine { x: 28; y: 30 }
                PathLine { x: 21; y: 14 }
                PathLine { x: 14; y: 30 }
                PathLine { x: 0; y: 30 }
            }
        }

        // 剩余距离 302 M（48px Semibold 渐变白，Text 以纯白近似渐变）
        Text {
            x: 122; y: 27
            text: "302"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Semibold
            font.pixelSize: 48
        }
        Text {
            x: 185; y: 50
            text: "M"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Semibold
            font.pixelSize: 24
        }

        // 路名
        Text {
            x: 95; y: 82
            text: "南京东路口"
            color: "white"
            font.family: "PingFang SC"
            font.pixelSize: 20
        }
    }

    // 提示条（Group 163 [162,177] 284×45：随后直行50m）
    Rectangle {
        x: 66; y: 129
        width: 284; height: 45
        color: "#0C0C14"

        Text {
            x: 41; y: 11
            text: "↑"
            color: "white"
            font.pixelSize: 24
        }
        Text {
            x: 101; y: 10
            text: "随后直行50m"
            color: "white"
            font.family: "PingFang SC"
            font.pixelSize: 18
        }
    }

    // ==================== 右侧控制柱（与地图页一致） ====================
    Rectangle {
        x: 66; y: 452
        width: 70; height: 157
        radius: 35
        color: "#4E548D"
        opacity: 0.92

        Rectangle { x: 22; y: 60; width: 25; height: 5; radius: 2.5; color: "white" }
        Rectangle { x: 32; y: 50; width: 5; height: 25; radius: 2.5; color: "white" }
        Rectangle { x: 22; y: 112; width: 25; height: 5; radius: 2.5; color: "white" }
    }

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

    // ==================== 底部快捷条 ====================
    ACQuickBar {
        x: 66; y: 659
    }
}
