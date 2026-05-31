import QtQuick

Item {
    id: statusBar
    width: parent ? parent.width : 1520
    height: 48

    // 背景
    Image {
        anchors.fill: parent
        source: "qrc:/Images/StatusBar/status_bar_background.png"
        fillMode: Image.Stretch
    }

    // 左侧图标区
    Row {
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        spacing: 16

        // 蓝牙
        Image {
            id: btIcon
            width: 24; height: 24
            source: "qrc:/Images/StatusBar/bluetooth.png"
            opacity: ui.btConnected ? 1.0 : 0.3
            anchors.verticalCenter: parent.verticalCenter
        }

        // 信号强度
        Image {
            id: signalIcon
            width: 24; height: 24
            source: "qrc:/Images/StatusBar/signal.png"
            opacity: ui.signalStrength > 0 ? 1.0 : 0.3
            anchors.verticalCenter: parent.verticalCenter
        }

        // GPS 定位
        Image {
            id: gpsIcon
            width: 24; height: 24
            source: "qrc:/Images/StatusBar/position.png"
            opacity: ui.gpsOn ? 1.0 : 0.3
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // 中间时间
    Text {
        id: timeText
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: 20
        font.bold: true

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: timeText.text = Qt.formatDateTime(new Date(), "HH:mm")
        }

        Component.onCompleted: {
            text = Qt.formatDateTime(new Date(), "HH:mm")
        }
    }

    // 右侧区域：消息通知 + 天气
    Row {
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        spacing: 16

        // 消息通知图标
        Item {
            width: 32; height: 32
            anchors.verticalCenter: parent.verticalCenter

            Image {
                anchors.centerIn: parent
                source: "qrc:/Images/Home/message.png"
                width: 24; height: 24
                opacity: messageMouse.containsMouse ? 1.0 : 0.8
            }

            // 未读消息红点
            Rectangle {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: 2
                anchors.rightMargin: 2
                width: 8; height: 8
                radius: 4
                color: "#F85149"
                visible: true // 后续绑定消息状态
            }

            MouseArea {
                id: messageMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    // TODO: 打开消息列表
                    console.log("消息通知点击")
                }
            }
        }

        // 天气图标
        Image {
            id: weatherIcon
            width: 28; height: 28
            source: ui.weatherIcon !== "" ? ui.weatherIcon : "qrc:/Images/Home/Weather/sun_clouds.png"
            anchors.verticalCenter: parent.verticalCenter
        }

        // 温度
        Text {
            id: tempText
            text: ui.weatherTemp + "°C"
            color: "white"
            font.pixelSize: 18
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
