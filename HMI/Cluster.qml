import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Shapes
import "../Components"

// 液晶仪表（设计稿 1:1，1520×648；ECO 青蓝 / SPORT 粉红双主题；速度/功率模拟行车动画）
Item {
    id: root
    width: 1520
    height: 648

    property string theme: "ECO"          // "ECO" | "SPORT"
    property real speed: 35               // km/h（模拟行车动画）
    property real power: speed / 25       // kW

    // 主题色（ECO: Intersect #50EDF2→#056698→#0B2347；SPORT: 粉红系 #FFABBA 家族）
    readonly property color arcTop: theme === "ECO" ? "#50EDF2" : "#FFC9D4"
    readonly property color arcMid: theme === "ECO" ? "#056698" : "#E08798"
    readonly property color arcDeep: theme === "ECO" ? "#0B2347" : "#5A2733"
    readonly property color accent: theme === "ECO" ? "#42D2DB" : "#FFABBA"

    // 模拟行车动画（GIF 演示的速度变化）
    Timer {
        interval: 120
        running: true
        repeat: true
        onTriggered: {
            var target = 35 + 70 * Math.abs(Math.sin(root.speedPhase += 0.05))
            root.speed += (target - root.speed) * 0.15
            root.power = root.speed / 25
        }
    }
    property real speedPhase: 0

    // 底部渐变（Rectangle 2048 [3,314] 1517×334）
    Rectangle {
        x: 3; y: 314
        width: 1517; height: 334
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0B0C11" }
            GradientStop { position: 0.4; color: "#192028" }
            GradientStop { position: 1.0; color: "#192028" }
        }
    }

    // 背景光晕（Ellipse 426/427）
    GlowEllipse { x: 370; y: 300; width: 224; height: 78; rotation: -33; glowColor: "#29A7C4"; blurRadius: 24 }
    GlowEllipse { x: 918; y: 310; width: 224; height: 78; rotation: 33; glowColor: "#29A7C4"; blurRadius: 24 }

    // ==================== 左仪表盘（Group 82 [93,65] 414×441） ====================
    Item {
        x: 93; y: 65
        width: 414; height: 441

        // 表盘底盘（Vector 445/446 #1A222F 描边 #314362）
        Shape {
            anchors.fill: parent
            ShapePath {
                strokeWidth: 2
                strokeColor: "#314362"
                fillColor: "#1A222F"
                startX: 0; startY: 220
                PathArc { x: 414; y: 220; radiusX: 207; radiusY: 220; useLargeArc: true }
                PathArc { x: 0; y: 220; radiusX: 207; radiusY: 220; useLargeArc: true }
            }
        }

        // 渐变填充弧（Intersect：#50EDF2→#056698→#0B2347→#0B0C12）
        Shape {
            anchors.fill: parent
            ShapePath {
                strokeWidth: -1
                fillGradient: LinearGradient {
                    x1: 0; y1: 0; x2: 0; y2: 441
                    GradientStop { position: 0.0; color: root.arcTop }
                    GradientStop { position: 0.54; color: root.arcMid }
                    GradientStop { position: 0.83; color: root.arcDeep }
                    GradientStop { position: 1.0; color: "#0B0C12" }
                }
                startX: 207; startY: 441
                PathArc { x: 20; y: 320; radiusX: 187; radiusY: 187; useLargeArc: true; direction: PathArc.Counterclockwise }
                PathArc { x: 394; y: 320; radiusX: 187; radiusY: 187; useLargeArc: true; direction: PathArc.Counterclockwise }
                PathLine { x: 207; y: 441 }
            }
        }

        // 刻度（外圈短线）
        Repeater {
            model: 21

            Rectangle {
                x: 197 + Math.sin(index / 20 * Math.PI) * 175 - 1.5
                y: 400 - Math.cos(index / 20 * Math.PI) * 175
                width: 3; height: index % 5 === 0 ? 16 : 9
                rotation: index / 20 * 180 - 90
                color: index % 5 === 0 ? "#C2F5F6" : "#445461"
                antialiasing: true
            }
        }

        // 高亮弧（Vector 449/450 #10DCE3→#3185C9）
        Shape {
            anchors.fill: parent
            ShapePath {
                strokeWidth: 6
                strokeColor: root.accent
                startX: 30; startY: 330
                PathArc { x: 384; y: 330; radiusX: 177; radiusY: 177; useLargeArc: root.speed > 60; direction: PathArc.Counterclockwise }
            }
        }

        // 速度数字
        Text {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 20
            text: Math.round(root.speed)
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.DemiBold
            font.pixelSize: 64
        }
        Text {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 80
            text: "km/h"
            color: "#8A9BB0"
            font.pixelSize: 16
        }
    }

    // ==================== 中央路面 + 车道线 ====================
    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 300
        width: 340; height: 348

        Rectangle { anchors.fill: parent; color: "#0B0C11" }

        // 车道线（透视）
        Rectangle { x: 168; y: 0; width: 4; height: 348; color: "#314362"; opacity: 0.6 }
        Rectangle { x: 60; y: 40; width: 3; height: 308; color: "#314362"; opacity: 0.4 }
        Rectangle { x: 277; y: 40; width: 3; height: 308; color: "#314362"; opacity: 0.4 }

        // 车道虚线（行车动画：向后移动）
        Repeater {
            model: 5

            Rectangle {
                x: 167
                y: (index * 80 + (root.speedPhase * 60) % 80)
                width: 6; height: 36
                color: "#8A9BB0"
                opacity: 0.7
            }
        }

        // 车辆剪影（Rectangle 2027 车形近似）
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 210
            width: 130; height: 54
            radius: 18
            color: "#1E2836"
            border.color: "#314362"
            border.width: 2
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 190
            width: 90; height: 34
            radius: 12
            color: "#232E3E"
        }
    }

    // ==================== 右仪表盘（动力 kW） ====================
    Item {
        x: 1013; y: 65
        width: 414; height: 441

        Shape {
            anchors.fill: parent
            ShapePath {
                strokeWidth: 2
                strokeColor: "#314362"
                fillColor: "#1A222F"
                startX: 0; startY: 220
                PathArc { x: 414; y: 220; radiusX: 207; radiusY: 220; useLargeArc: true }
                PathArc { x: 0; y: 220; radiusX: 207; radiusY: 220; useLargeArc: true }
            }
        }
        Shape {
            anchors.fill: parent
            ShapePath {
                strokeWidth: -1
                fillGradient: LinearGradient {
                    x1: 0; y1: 0; x2: 0; y2: 441
                    GradientStop { position: 0.0; color: root.arcTop }
                    GradientStop { position: 0.54; color: root.arcMid }
                    GradientStop { position: 0.83; color: root.arcDeep }
                    GradientStop { position: 1.0; color: "#0B0C12" }
                }
                startX: 207; startY: 441
                PathArc { x: 20; y: 320; radiusX: 187; radiusY: 187; useLargeArc: true; direction: PathArc.Counterclockwise }
                PathArc { x: 394; y: 320; radiusX: 187; radiusY: 187; useLargeArc: true; direction: PathArc.Counterclockwise }
                PathLine { x: 207; y: 441 }
            }
        }
        Repeater {
            model: 21

            Rectangle {
                x: 197 + Math.sin(index / 20 * Math.PI) * 175 - 1.5
                y: 400 - Math.cos(index / 20 * Math.PI) * 175
                width: 3; height: index % 5 === 0 ? 16 : 9
                rotation: index / 20 * 180 - 90
                color: index % 5 === 0 ? "#C2F5F6" : "#445461"
                antialiasing: true
            }
        }
        Shape {
            anchors.fill: parent
            ShapePath {
                strokeWidth: 6
                strokeColor: root.accent
                startX: 30; startY: 330
                PathArc { x: 384; y: 330; radiusX: 177; radiusY: 177; useLargeArc: root.power > 2.4; direction: PathArc.Counterclockwise }
            }
        }
        Text {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 20
            text: root.power.toFixed(1)
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.DemiBold
            font.pixelSize: 64
        }
        Text {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 80
            text: "kW"
            color: "#8A9BB0"
            font.pixelSize: 16
        }
    }

    // ==================== 顶部状态行（Frame 78） ====================
    property date now: new Date()

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.now = new Date()
    }

    Text { x: 517; y: 14; text: Qt.formatDateTime(root.now, "hh:mm"); color: "white"; font.family: "PingFang SC"; font.pixelSize: 24 }

    Text {
        x: 633; y: 14
        text: "HEV"
        color: "white"
        font.family: "PingFang SC"
        font.weight: Font.Medium
        font.pixelSize: 24
    }
    Text {
        x: 834; y: 14
        text: root.theme
        color: "white"
        font.family: "PingFang SC"
        font.weight: Font.Medium
        font.pixelSize: 24
    }
    Text {
        x: 947; y: 14
        text: "28°C"
        color: "white"
        font.family: "PingFang SC"
        font.pixelSize: 24
    }

    // ==================== 底部信息 ====================
    Text { x: 130; y: 600; text: "Trip 89 km"; color: "#8A9BB0"; font.pixelSize: 16 }
    Text { x: 1330; y: 600; text: "ODO 2440 km"; color: "#8A9BB0"; font.pixelSize: 16 }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 590
        spacing: 30
        Text { text: "P"; color: "#4A5B79"; font.pixelSize: 24 }
        Text { text: "R"; color: "#4A5B79"; font.pixelSize: 24 }
        Text { text: "N"; color: "#4A5B79"; font.pixelSize: 24 }
        Text { text: "D"; color: root.accent; font.weight: Font.Bold; font.pixelSize: 24 }
    }

    // 主题切换（演示用：点击顶部 ECO/SPORT 文字切换）
    MouseArea {
        x: 820; y: 8
        width: 110; height: 44
        onClicked: root.theme = root.theme === "ECO" ? "SPORT" : "ECO"
    }
}
