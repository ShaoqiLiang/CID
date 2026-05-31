import QtQuick

Item {
    id: homePage
    width: parent ? parent.width : 1424
    height: parent ? parent.height : 808

    // 背景
    Rectangle {
        anchors.fill: parent
        color: "#0E141D"
    }

    // ==================== ⑥ 语音助手（顶部居中） ====================
    // Figma: 444×120, 圆角, #1A1E2E
    Item {
        id: voiceAssistant
        anchors.top: parent.top
        anchors.topMargin: 12
        anchors.horizontalCenter: parent.horizontalCenter
        width: 444
        height: 120

        Rectangle {
            anchors.fill: parent
            radius: 16
            color: "#1A1E2E"
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            Text {
                text: "你可以这样说："
                color: "white"
                font.family: "PingFang SC"
                font.pixelSize: 16
                font.weight: Font.Medium
            }

            Text {
                text: "小迪去公司迪路况怎么样？"
                color: "white"
                font.family: "PingFang SC"
                font.pixelSize: 18
            }
        }

        // 麦克风按钮
        Rectangle {
            width: 86; height: 86
            radius: 43
            anchors.right: parent.right
            anchors.rightMargin: 24
            anchors.verticalCenter: parent.verticalCenter
            color: "#1A1E2E"
            border.color: "#2A2E3E"
            border.width: 2

            // 彩色圆点装饰
            Repeater {
                model: ListModel {
                    ListElement { cx: 0; cy: -22; dotColor: "#F7AB52" }
                    ListElement { cx: 22; cy: 0; dotColor: "#52F763" }
                    ListElement { cx: 0; cy: 22; dotColor: "#6BB8FF" }
                    ListElement { cx: -22; cy: 0; dotColor: "#FF6B6B" }
                }

                Rectangle {
                    width: 12; height: 12
                    radius: 6
                    x: parent.width / 2 + cx - 6
                    y: parent.height / 2 + cy - 6
                    color: dotColor
                }
            }

            // 麦克风图标
            Image {
                anchors.centerIn: parent
                source: "qrc:/Images/Home/voice_assistant.png"
                width: 36; height: 36
            }

            MouseArea {
                anchors.fill: parent
                onPressed: parent.scale = 0.9
                onReleased: parent.scale = 1.0
                onClicked: console.log("语音助手启动")
            }

            Behavior on scale { NumberAnimation { duration: 100 } }
        }
    }

    // ==================== 主内容区域 ====================
    Row {
        anchors.top: voiceAssistant.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16
        anchors.topMargin: 16
        spacing: 16

        // ==================== 左侧区域 ====================
        Column {
            width: (parent.width - 16) * 0.55
            height: parent.height
            spacing: 16

            // ==================== ⑤ 地图导航 ====================
            // Figma: 309×386, 蓝色渐变背景 #3360B0
            Item {
                id: mapArea
                width: parent.width
                height: parent.height - weatherRow.height - 16

                Rectangle {
                    anchors.fill: parent
                    radius: 16
                    color: "#3360B0"
                }

                // 地图装饰圆形
                Rectangle {
                    anchors.centerIn: parent
                    width: 150; height: 150
                    radius: 75
                    color: "#48B7E3"
                    opacity: 0.4
                }

                Rectangle {
                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: -40
                    width: 100; height: 100
                    radius: 50
                    color: "#2881D6"
                    opacity: 0.5
                }

                // 地图图标和名称
                Column {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: 16
                    spacing: 8

                    Row {
                        spacing: 8
                        Image {
                            width: 28; height: 28
                            source: "qrc:/Images/Home/map.png"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: "高德地图"
                            color: "white"
                            font.family: "PingFang SC"
                            font.pixelSize: 14
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                // 导航快捷入口
                Row {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.margins: 16
                    spacing: 12

                    Repeater {
                        model: ["回家", "去公司", "充电站"]

                        Rectangle {
                            width: 80; height: 32
                            radius: 16
                            color: "#40FFFFFF"

                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                color: "white"
                                font.family: "PingFang SC"
                                font.pixelSize: 14
                            }

                            MouseArea {
                                anchors.fill: parent
                                z: 10
                                onClicked: console.log("导航: " + modelData)
                            }
                        }
                    }
                }

                // 导航信息卡片（左上角）
                Rectangle {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.margins: 16
                    width: 240
                    height: 100
                    radius: 12
                    color: "#CC1A1E2E"

                    Column {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 8

                        Row {
                            spacing: 8
                            Image {
                                width: 20; height: 20
                                source: "qrc:/Images/Home/map_home.png"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: ui.navDestination !== "" ? ui.navDestination : "未设置导航"
                                color: "white"
                                font.family: "PingFang SC"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        Rectangle { width: parent.width; height: 1; color: "#30363D" }

                        Row {
                            spacing: 24

                            Column {
                                Text { text: "距离"; color: "#8B949E"; font.pixelSize: 11 }
                                Text {
                                    text: ui.navActive ? ui.navDistance.toFixed(1) + " km" : "--"
                                    color: "white"; font.pixelSize: 14; font.bold: true
                                }
                            }

                            Column {
                                Text { text: "预计到达"; color: "#8B949E"; font.pixelSize: 11 }
                                Text {
                                    text: ui.navActive ? ui.navEta : "--:--"
                                    color: "white"; font.pixelSize: 14; font.bold: true
                                }
                            }
                        }
                    }
                }
            }

            // ==================== ③ 天气 + ④ AC快捷 ====================
            // Figma: 天气 627×120
            Row {
                id: weatherRow
                width: parent.width
                height: 120
                spacing: 16

                // 天气卡片
                Rectangle {
                    width: (parent.width - 16) * 0.6
                    height: parent.height
                    radius: 16
                    color: "#161B22"

                    Row {
                        anchors.fill: parent
                        anchors.margins: 16
                        spacing: 16

                        // 天气图标
                        Image {
                            source: "qrc:/Images/Home/Weather/sun_clouds.png"
                            width: 64; height: 64
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        // 天气信息
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 4

                            Text {
                                text: "南京市 雨花台区"
                                color: "white"
                                font.family: "PingFang SC"
                                font.pixelSize: 18
                                font.weight: Font.Medium
                            }

                            Text {
                                text: "晴转多云"
                                color: "white"
                                font.family: "PingFang SC"
                                font.pixelSize: 18
                            }

                            Row {
                                spacing: 16
                                Text {
                                    text: "车内 " + ui.weatherTemp + "°"
                                    color: "white"
                                    font.family: "PingFang SC"
                                    font.pixelSize: 18
                                }
                                Text {
                                    text: "车外 12°"
                                    color: "white"
                                    font.family: "PingFang SC"
                                    font.pixelSize: 18
                                }
                            }

                            Row {
                                spacing: 8
                                Text {
                                    text: "空气质量"
                                    color: "white"
                                    font.family: "PingFang SC"
                                    font.pixelSize: 18
                                    font.weight: Font.Medium
                                }
                                Text {
                                    text: "优"
                                    color: "#2D7B87"
                                    font.family: "PingFang SC"
                                    font.pixelSize: 18
                                    font.weight: Font.Medium
                                }
                            }
                        }
                    }
                }

                // AC 快捷控制
                Rectangle {
                    width: (parent.width - 16) * 0.4
                    height: parent.height
                    radius: 16
                    color: "#161B22"

                    Column {
                        anchors.centerIn: parent
                        spacing: 12

                        Text {
                            text: "空调"
                            color: "#8B949E"
                            font.family: "PingFang SC"
                            font.pixelSize: 13
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: ui.acLeftTemp.toFixed(1) + "°C"
                            color: "white"
                            font.family: "Montserrat"
                            font.pixelSize: 28
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Row {
                            spacing: 24
                            anchors.horizontalCenter: parent.horizontalCenter

                            // 减
                            Rectangle {
                                width: 36; height: 36; radius: 18
                                color: subMouse.pressed ? "#3D5AFE" : (subMouse.containsMouse ? "#2A2A4A" : "#21262D")
                                scale: subMouse.pressed ? 0.85 : 1.0
                                Behavior on color { ColorAnimation { duration: 120 } }
                                Behavior on scale { NumberAnimation { duration: 100 } }

                                Text { anchors.centerIn: parent; text: "−"; color: "white"; font.pixelSize: 20 }

                                MouseArea {
                                    id: subMouse; anchors.fill: parent; hoverEnabled: true
                                    onClicked: { if (ui.acLeftTemp > 16.0) ui.acLeftTemp = ui.acLeftTemp - 0.5 }
                                }
                            }

                            // 加
                            Rectangle {
                                width: 36; height: 36; radius: 18
                                color: addMouse.pressed ? "#3D5AFE" : (addMouse.containsMouse ? "#2A2A4A" : "#21262D")
                                scale: addMouse.pressed ? 0.85 : 1.0
                                Behavior on color { ColorAnimation { duration: 120 } }
                                Behavior on scale { NumberAnimation { duration: 100 } }

                                Text { anchors.centerIn: parent; text: "+"; color: "white"; font.pixelSize: 20 }

                                MouseArea {
                                    id: addMouse; anchors.fill: parent; hoverEnabled: true
                                    onClicked: { if (ui.acLeftTemp < 32.0) ui.acLeftTemp = ui.acLeftTemp + 0.5 }
                                }
                            }
                        }

                        Text {
                            text: ui.acOn ? "运行中" : "已关闭"
                            color: ui.acOn ? "#3FB950" : "#8B949E"
                            font.pixelSize: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }

        // ==================== 右侧区域 ====================
        Column {
            width: (parent.width - 16) * 0.45
            height: parent.height
            spacing: 16

            // ==================== ② 车辆状态 ====================
            // Figma: 642×176, "8500 km", "245 km", "已安全陪伴您 267 天", "车辆状况良好"
            Rectangle {
                id: vehicleStatus
                width: parent.width
                height: 176
                radius: 16
                color: "#161B22"

                Row {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 16

                    // 车辆图标
                    Rectangle {
                        width: 120; height: 120
                        radius: 12
                        color: "#1E2430"
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            anchors.centerIn: parent
                            source: ui.vehicleCondition === 1 ? "qrc:/Images/Home/vehicle_condition_good.png" : "qrc:/Images/Home/vehicle_condition.png"
                            width: 80; height: 80
                        }
                    }

                    // 车辆数据
                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 10

                        // 里程
                        Row {
                            spacing: 8
                            Text {
                                text: "总里程"
                                color: "#8B949E"
                                font.family: "PingFang SC"
                                font.pixelSize: 14
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: ui.vehicleMileage.toFixed(0) + " km"
                                color: "white"
                                font.family: "PingFang SC"
                                font.pixelSize: 22
                                font.weight: Font.DemiBold
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        // 续航
                        Row {
                            spacing: 8
                            Text {
                                text: "续航"
                                color: "#8B949E"
                                font.family: "PingFang SC"
                                font.pixelSize: 14
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: ui.vehicleRange + " km"
                                color: ui.vehicleRange < 50 ? "#F85149" : "white"
                                font.family: "PingFang SC"
                                font.pixelSize: 22
                                font.weight: Font.DemiBold
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        // 安全天数
                        Text {
                            text: "已安全陪伴您  267 天"
                            color: "white"
                            font.family: "PingFang SC"
                            font.pixelSize: 14
                        }

                        // 车况
                        Row {
                            spacing: 8
                            Rectangle {
                                width: 8; height: 8; radius: 4
                                color: ui.vehicleCondition === 1 ? "#3FB950" : "#F85149"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: "车辆状况良好"
                                color: "white"
                                font.family: "PingFang SC"
                                font.pixelSize: 14
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
            }

            // ==================== ① 音乐/媒体播放器 ====================
            // Figma: 309×386, "Something Just Like This", "The Chainsmokers", "酷我音乐"
            Rectangle {
                id: musicPlayer
                width: parent.width
                height: parent.height - vehicleStatus.height - 16
                radius: 16
                color: "#161B22"

                Column {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 12

                    // 音源
                    Row {
                        spacing: 8
                        Image {
                            width: 28; height: 28
                            source: "qrc:/Images/Home/music.png"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: "酷我音乐"
                            color: "white"
                            font.family: "PingFang SC"
                            font.pixelSize: 14
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    // 专辑封面和信息
                    Row {
                        width: parent.width
                        spacing: 16

                        // 专辑封面
                        Rectangle {
                            width: 104; height: 104
                            radius: 12
                            color: "#1E2430"
                            anchors.verticalCenter: parent.verticalCenter

                            Image {
                                anchors.fill: parent
                                anchors.margins: 4
                                source: ui.mediaAlbumArt !== "" ? ui.mediaAlbumArt : "qrc:/Images/Home/music_album.png"
                                fillMode: Image.PreserveAspectCrop
                            }
                        }

                        // 歌曲信息
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 8
                            width: parent.width - 104 - 16

                            Text {
                                text: ui.mediaTitle !== "" ? ui.mediaTitle : "未播放"
                                color: "white"
                                font.family: "PingFang SC"
                                font.pixelSize: 18
                                font.weight: Font.DemiBold
                                width: parent.width
                                elide: Text.ElideRight
                            }

                            Text {
                                text: ui.mediaArtist !== "" ? ui.mediaArtist : "未知歌手"
                                color: "#8B949E"
                                font.family: "PingFang SC"
                                font.pixelSize: 16
                            }

                            // 音源标签
                            Rectangle {
                                width: sourceLabel.width + 16; height: 24
                                radius: 12
                                color: "#21262D"

                                Text {
                                    id: sourceLabel
                                    anchors.centerIn: parent
                                    text: {
                                        switch(ui.mediaSource) {
                                        case 0: return "🔵 蓝牙"
                                        case 1: return "📻 电台"
                                        case 2: return "☁️ 在线"
                                        default: return "🔵 蓝牙"
                                        }
                                    }
                                    color: "#8B949E"
                                    font.pixelSize: 12
                                }
                            }
                        }
                    }

                    // 播放控制
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 24

                        // 上一曲
                        Image {
                            width: 28; height: 28
                            source: "qrc:/Images/Home/music_previous.png"
                            opacity: prevMouse.containsMouse ? 1.0 : 0.7
                            anchors.verticalCenter: parent.verticalCenter

                            MouseArea { id: prevMouse; anchors.fill: parent; hoverEnabled: true }
                        }

                        // 播放/暂停
                        Rectangle {
                            width: 48; height: 48; radius: 24
                            color: "#3D5AFE"
                            anchors.verticalCenter: parent.verticalCenter

                            Image {
                                anchors.centerIn: parent
                                source: "qrc:/Images/Home/music_play.png"
                                width: 24; height: 24
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: ui.mediaPlaying = !ui.mediaPlaying
                            }
                        }

                        // 下一曲
                        Image {
                            width: 28; height: 28
                            source: "qrc:/Images/Home/music_next.png"
                            opacity: nextMouse.containsMouse ? 1.0 : 0.7
                            anchors.verticalCenter: parent.verticalCenter

                            MouseArea { id: nextMouse; anchors.fill: parent; hoverEnabled: true }
                        }
                    }

                    // 进度条
                    Rectangle {
                        width: parent.width; height: 4; radius: 2
                        color: "#30363D"

                        Rectangle {
                            width: parent.width * 0.35; height: parent.height; radius: 2
                            color: "#3D5AFE"
                        }
                    }
                }
            }
        }
    }
}
