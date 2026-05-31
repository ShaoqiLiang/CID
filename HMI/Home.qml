import QtQuick

Item {
    id: homePage
    width: parent ? parent.width : 1424
    height: parent ? parent.height : 808

    // 背景
    Rectangle {
        anchors.fill: parent
        color: "#0D1117"
    }

    // 内容区域
    Row {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16

        // ==================== 左侧区域：地图导航 ====================
        Item {
            id: mapArea
            width: (parent.width - 16) * 0.55
            height: parent.height

            // 地图背景
            Rectangle {
                anchors.fill: parent
                radius: 16
                color: "#161B22"
            }

            // 地图图片
            Image {
                anchors.fill: parent
                anchors.margins: 8
                source: "qrc:/Images/Home/map.png"
                fillMode: Image.PreserveAspectCrop
                opacity: 0.8
            }

            // 地图内部装饰
            Image {
                anchors.centerIn: parent
                source: "qrc:/Images/Home/map_inner.png"
                opacity: 0.6
            }

            // 导航信息卡片（左上角）
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 16
                width: 260
                height: 140
                radius: 12
                color: "#1E2430"
                opacity: 0.95

                Column {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 12

                    // 目的地
                    Row {
                        spacing: 10
                        Image {
                            width: 24; height: 24
                            source: "qrc:/Images/Home/map_home.png"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Column {
                            Text {
                                text: "目的地"
                                color: "#8B949E"
                                font.pixelSize: 12
                            }
                            Text {
                                text: ui.navDestination !== "" ? ui.navDestination : "未设置导航"
                                color: "white"
                                font.pixelSize: 16
                                font.bold: true
                            }
                        }
                    }

                    // 分隔线
                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "#30363D"
                    }

                    // 距离和时间
                    Row {
                        spacing: 30

                        Column {
                            Text {
                                text: "距离"
                                color: "#8B949E"
                                font.pixelSize: 11
                            }
                            Text {
                                text: ui.navActive ? ui.navDistance.toFixed(1) + " km" : "--"
                                color: "white"
                                font.pixelSize: 16
                                font.bold: true
                            }
                        }

                        Column {
                            Text {
                                text: "预计到达"
                                color: "#8B949E"
                                font.pixelSize: 11
                            }
                            Text {
                                text: ui.navActive ? ui.navEta : "--:--"
                                color: "white"
                                font.pixelSize: 16
                                font.bold: true
                            }
                        }
                    }
                }
            }

            // 地图标记点
            Image {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -20
                source: "qrc:/Images/Home/map_ellipse.png"
                width: 48; height: 48
            }

            // 充电站标记
            Image {
                anchors.centerIn: parent
                anchors.horizontalOffset: 80
                anchors.verticalOffset: 40
                source: "qrc:/Images/Home/map_charging_station.png"
                width: 32; height: 32
            }
        }

        // ==================== 右侧区域 ====================
        Column {
            width: (parent.width - 16) * 0.45
            height: parent.height
            spacing: 16

            // ---- 音乐播放器 ----
            Rectangle {
                id: musicPlayer
                width: parent.width
                height: parent.height * 0.35
                radius: 16
                color: "#161B22"

                Row {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 16

                    // 专辑封面
                    Rectangle {
                        width: 140
                        height: width
                        radius: 12
                        color: "#1E2430"
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            anchors.fill: parent
                            anchors.margins: 4
                            source: ui.mediaAlbumArt !== "" ? ui.mediaAlbumArt : "qrc:/Images/Home/music_album.png"
                            fillMode: Image.PreserveAspectCrop
                        }

                        // 播放状态指示
                        Rectangle {
                            anchors.centerIn: parent
                            width: 40; height: 40
                            radius: 20
                            color: "#3D5AFE"
                            opacity: ui.mediaPlaying ? 0.9 : 0.7

                            Image {
                                anchors.centerIn: parent
                                source: "qrc:/Images/Home/music_play.png"
                                width: 20; height: 20
                            }
                        }
                    }

                    // 歌曲信息和控制
                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width - 140 - 16
                        spacing: 12

                        // 歌曲名
                        Text {
                            text: ui.mediaTitle !== "" ? ui.mediaTitle : "未播放"
                            color: "white"
                            font.pixelSize: 20
                            font.bold: true
                            width: parent.width
                            elide: Text.ElideRight
                        }

                        // 歌手
                        Text {
                            text: ui.mediaArtist !== "" ? ui.mediaArtist : "未知歌手"
                            color: "#8B949E"
                            font.pixelSize: 14
                        }

                        // 音源
                        Rectangle {
                            width: sourceText.width + 16
                            height: 24
                            radius: 12
                            color: "#21262D"

                            Text {
                                id: sourceText
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

                        // 播放控制按钮
                        Row {
                            spacing: 20
                            anchors.horizontalCenter: parent.horizontalCenter

                            // 上一曲
                            Image {
                                width: 32; height: 32
                                source: "qrc:/Images/Home/music_previous.png"
                                opacity: prevMouse.containsMouse ? 1.0 : 0.7
                                anchors.verticalCenter: parent.verticalCenter

                                MouseArea {
                                    id: prevMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        // TODO: 上一曲
                                    }
                                }
                            }

                            // 播放/暂停
                            Rectangle {
                                width: 48; height: 48
                                radius: 24
                                color: "#3D5AFE"
                                anchors.verticalCenter: parent.verticalCenter

                                Image {
                                    anchors.centerIn: parent
                                    source: "qrc:/Images/Home/music_play.png"
                                    width: 24; height: 24
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        ui.mediaPlaying = !ui.mediaPlaying
                                    }
                                }
                            }

                            // 下一曲
                            Image {
                                width: 32; height: 32
                                source: "qrc:/Images/Home/music_next.png"
                                opacity: nextMouse.containsMouse ? 1.0 : 0.7
                                anchors.verticalCenter: parent.verticalCenter

                                MouseArea {
                                    id: nextMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        // TODO: 下一曲
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // ---- 车辆状态 ----
            Rectangle {
                id: vehicleStatus
                width: parent.width
                height: parent.height * 0.25
                radius: 16
                color: "#161B22"

                Row {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 12

                    // 车辆图标
                    Rectangle {
                        width: 100
                        height: width
                        radius: 12
                        color: "#1E2430"
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            anchors.centerIn: parent
                            source: ui.vehicleCondition === 1 ? "qrc:/Images/Home/vehicle_condition_good.png" : "qrc:/Images/Home/vehicle_condition.png"
                            width: 60; height: 60
                        }
                    }

                    // 车辆数据
                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width - 100 - 12
                        spacing: 12

                        // 车况
                        Row {
                            spacing: 8
                            Image {
                                source: "qrc:/Images/Home/vehicle_condition_good.png"
                                width: 20; height: 20
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: "车况: " + (ui.vehicleCondition === 1 ? "良好" : "需检查")
                                color: ui.vehicleCondition === 1 ? "#3FB950" : "#F85149"
                                font.pixelSize: 14
                                font.bold: true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        // 里程
                        Row {
                            spacing: 8
                            Image {
                                source: "qrc:/Images/Home/vehicle_mileage.png"
                                width: 20; height: 20
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: "总里程: " + ui.vehicleMileage.toFixed(0) + " km"
                                color: "white"
                                font.pixelSize: 14
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        // 续航
                        Row {
                            spacing: 8
                            Image {
                                source: "qrc:/Images/Home/miles.png"
                                width: 20; height: 20
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: "续航: " + ui.vehicleRange + " km"
                                color: ui.vehicleRange < 50 ? "#F85149" : "#3FB950"
                                font.pixelSize: 14
                                font.bold: true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        // 档位
                        Row {
                            spacing: 8
                            Text {
                                text: "档位:"
                                color: "#8B949E"
                                font.pixelSize: 14
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: {
                                    switch(ui.vehicleGear) {
                                    case 0: return "P"
                                    case 1: return "R"
                                    case 2: return "N"
                                    case 3: return "D"
                                    default: return "P"
                                    }
                                }
                                color: "white"
                                font.pixelSize: 18
                                font.bold: true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
            }

            // ---- 底部区域：天气 + AC快捷 + 电台 ----
            Row {
                width: parent.width
                height: parent.height * 0.40
                spacing: 16

                // 天气卡片
                Rectangle {
                    width: (parent.width - 32) / 3
                    height: parent.height
                    radius: 16
                    color: "#161B22"

                    Image {
                        anchors.fill: parent
                        source: "qrc:/Images/Home/weather_background.png"
                        fillMode: Image.PreserveAspectCrop
                        opacity: 0.3
                    }

                    Column {
                        anchors.centerIn: parent
                        spacing: 8

                        Image {
                            source: "qrc:/Images/Home/Weather/sun_clouds.png"
                            width: 56; height: 56
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: ui.weatherTemp + "°C"
                            color: "white"
                            font.pixelSize: 28
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: ui.weatherDesc !== "" ? ui.weatherDesc : "晴转多云"
                            color: "#8B949E"
                            font.pixelSize: 13
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }

                // AC 快捷控制
                Rectangle {
                    width: (parent.width - 32) / 3
                    height: parent.height
                    radius: 16
                    color: "#161B22"

                    Image {
                        anchors.fill: parent
                        source: "qrc:/Images/Home/ac_background.png"
                        fillMode: Image.PreserveAspectCrop
                        opacity: 0.3
                    }

                    Column {
                        anchors.centerIn: parent
                        spacing: 12

                        Text {
                            text: "空调"
                            color: "#8B949E"
                            font.pixelSize: 13
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        // 温度显示
                        Text {
                            text: ui.acLeftTemp.toFixed(1) + "°C"
                            color: "white"
                            font.pixelSize: 32
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        // 加减按钮
                        Row {
                            spacing: 24
                            anchors.horizontalCenter: parent.horizontalCenter

                            // 减
                            Rectangle {
                                width: 36; height: 36
                                radius: 18
                                color: "#21262D"

                                Text {
                                    anchors.centerIn: parent
                                    text: "−"
                                    color: "white"
                                    font.pixelSize: 20
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        if (ui.acLeftTemp > 16.0)
                                            ui.acLeftTemp = ui.acLeftTemp - 0.5
                                    }
                                }
                            }

                            // 加
                            Rectangle {
                                width: 36; height: 36
                                radius: 18
                                color: "#3D5AFE"

                                Text {
                                    anchors.centerIn: parent
                                    text: "+"
                                    color: "white"
                                    font.pixelSize: 20
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        if (ui.acLeftTemp < 32.0)
                                            ui.acLeftTemp = ui.acLeftTemp + 0.5
                                    }
                                }
                            }
                        }

                        // 空调状态
                        Text {
                            text: ui.acOn ? "运行中" : "已关闭"
                            color: ui.acOn ? "#3FB950" : "#8B949E"
                            font.pixelSize: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }

                // 电台卡片
                Rectangle {
                    width: (parent.width - 32) / 3
                    height: parent.height
                    radius: 16
                    color: "#161B22"

                    Image {
                        anchors.fill: parent
                        source: "qrc:/Images/Home/radio_background.png"
                        fillMode: Image.PreserveAspectCrop
                        opacity: 0.3
                    }

                    Column {
                        anchors.centerIn: parent
                        spacing: 8

                        Image {
                            source: "qrc:/Images/Home/radio_logo.png"
                            width: 48; height: 48
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: "电台"
                            color: "#8B949E"
                            font.pixelSize: 13
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: "FM 98.7"
                            color: "white"
                            font.pixelSize: 20
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: "交通广播"
                            color: "#8B949E"
                            font.pixelSize: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }
    }
}
