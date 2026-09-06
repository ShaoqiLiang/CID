import QtQuick
import "../Components"

// 状态栏（设计稿 1:1：背景胶囊 [135,4] 1386×40，时间居右，消息胶囊居左；下拉打开便捷中心）
Item {
    id: statusBar
    width: parent ? parent.width : 1521
    height: 48

    // 下拉手势：打开便捷中心
    SwipeArea {
        anchors.fill: parent
        onSwipeDown: ui.controlCenterVisible = true
    }

    // 背景胶囊（Rectangle 52）
    Rectangle {
        x: 135; y: 4
        width: 1386; height: 40
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#0D0E12" }
            GradientStop { position: 0.55; color: "#1A212C" }
            GradientStop { position: 1.0; color: "#1A222D" }
        }
    }

    // 消息胶囊（Rectangle 44 [109,1] 120×46，车图标 + 红点）
    Rectangle {
        x: 109; y: 1
        width: 120; height: 46
        radius: 10
        color: "#171E29"

        Image {
            anchors.fill: parent
            source: "qrc:/Images/Home/message_background.png"
            fillMode: Image.Stretch
        }

        Image {
            x: 46; y: 10
            width: 25; height: 23
            source: "qrc:/Images/Home/message.png"
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            anchors.fill: parent
            onClicked: console.log("消息通知点击")
        }
    }

    // 时间（17:58 AM [1280,13] 16px）
    Text {
        id: timeText
        x: 1280; y: 13
        text: Qt.formatDateTime(new Date(), "hh:mm AP")
        color: "white"
        font.family: "PingFang SC"
        font.pixelSize: 16

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: timeText.text = Qt.formatDateTime(new Date(), "hh:mm AP")
        }
    }

    // 蓝牙（[1378,13] 22×21）
    Image {
        x: 1378; y: 13
        width: 22; height: 21
        source: "qrc:/Images/StatusBar/bluetooth.png"
        fillMode: Image.PreserveAspectFit
        opacity: ui.btConnected ? 1.0 : 0.3
    }

    // 信号（signal.png 自带"4G+信号柱"图案，[1422,14] 17×21）
    Image {
        x: 1422; y: 14
        width: 17; height: 21
        source: "qrc:/Images/StatusBar/signal.png"
        fillMode: Image.PreserveAspectFit
        opacity: ui.signalStrength > 0 ? 1.0 : 0.3
    }
}
