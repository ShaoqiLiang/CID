import QtQuick
import "../Components"

// 主页 · 无界·无谓（设计稿 1:1，坐标 = 设计稿整屏坐标 − (96, 48)）
Item {
    id: homePage
    width: parent ? parent.width : 1424
    height: parent ? parent.height : 808

    // 内容面板（Rectangle 17 [107,0] 1414×856 r=30）
    Rectangle {
        x: 11; y: 0
        width: 1414; height: 856
        radius: 30
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#171E29" }
            GradientStop { position: 1.0; color: "#424D5C" }
        }
        border.color: "#3A4450"
        border.width: 1
    }

    // 背景光晕：直接用设计稿导出图 map_ellipse.png，亮度用内置 opacity（0~1）调
    // 光晕 Ellipse 56 [162.61,534.82] 352.69×235.4 #2AA7D8 @19%
    Image {
        x: 67; y: 487; width: 353; height: 235
        source: "qrc:/Images/Home/map_ellipse.png"
        fillMode: Image.Stretch
        opacity: 0.19
    }
    // 光晕 Ellipse 55 [511,549] 322×222 #48909E
    Image {
        x: 415; y: 501; width: 322; height: 222
        source: "qrc:/Images/Home/map_ellipse.png"
        fillMode: Image.Stretch
        opacity: 0.19
    }

    // ==================== 语音助手（Group 57 [186,67] 444×120，整卡背景 + 机器人） ====================
    Image {
        x: 90; y: 19
        width: 444; height: 120
        source: "qrc:/Images/Home/voice_assistant_background.png"
        fillMode: Image.Stretch
    }
    Image {
        x: 107; y: 40
        width: 91; height: 88
        source: "qrc:/Images/Home/voice_assistant.png"
        fillMode: Image.PreserveAspectFit
    }
    Text {
        x: 208; y: 50
        text: "你可以这样说："
        color: "white"
        font.family: "PingFang SC"
        font.weight: Font.Medium
        font.pixelSize: 16
    }
    Text {
        x: 208; y: 83
        text: "小迪去公司迪路况怎么样？"
        color: "white"
        font.family: "PingFang SC"
        font.pixelSize: 18
    }

    // ==================== 天气（Group 56 [658,67] 627×120，整卡背景 + 数据） ====================
    Image {
        x: 562; y: 19
        width: 627; height: 120
        source: "qrc:/Images/Home/weather_background.png"
        fillMode: Image.Stretch
    }
    Image {
        x: 606; y: 47
        width: 75; height: 65
        source: "qrc:/Images/Home/Weather/sun_clouds.png"
        fillMode: Image.PreserveAspectFit
    }
    Text {
        x: 733; y: 49
        text: ui.city
        color: "white"
        font.family: "PingFang SC"
        font.weight: Font.Medium
        font.pixelSize: 18
    }
    Text {
        x: 745; y: 82
        text: ui.weatherDesc + " " + ui.weatherTemp + "°"
        color: "white"
        font.family: "PingFang SC"
        font.pixelSize: 18
    }
    Rectangle {
        x: 919; y: 49
        width: 3; height: 54
        radius: 1.5
        color: "#2C333E"
    }
    Text {
        x: 973; y: 49
        text: "空气质量"
        color: "white"
        font.family: "PingFang SC"
        font.weight: Font.Medium
        font.pixelSize: 18
    }
    Text {
        x: 1055; y: 49
        text: ui.airQuality
        color: "#2D7B87"
        font.family: "PingFang SC"
        font.weight: Font.Medium
        font.pixelSize: 18
    }
    Text {
        x: 973; y: 83
        text: "车内 " + ui.carTemp + "°"
        color: "white"
        font.family: "PingFang SC"
        font.pixelSize: 18
    }
    Text {
        x: 1053; y: 83
        text: "车外 " + ui.outsideTemp + "°"
        color: "white"
        font.family: "PingFang SC"
        font.pixelSize: 18
    }

    // ==================== 时钟（Group 47 [1324,61] 162×111，实时时间 + 日期 + 星期） ====================
    property date now: new Date()

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: homePage.now = new Date()
    }

    Text {
        x: 1228; y: 13
        text: Qt.formatDateTime(homePage.now, "hh:mm")
        color: "white"
        font.family: "PingFang SC"
        font.weight: Font.Semibold
        font.pixelSize: 64
    }

    Text {
        x: 1246; y: 98
        text: Qt.formatDateTime(homePage.now, "M月d号")
        color: "white"
        font.family: "PingFang SC"
        font.pixelSize: 18
    }

    Text {
        x: 1318; y: 98
        text: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"][homePage.now.getDay()]
        color: "white"
        font.family: "PingFang SC"
        font.pixelSize: 18
    }

    // ==================== 高德地图卡（Group 58 [186,235] 309×386，整卡图 + map_inner + 图标） ====================
    Item {
        x: 90; y: 187
        width: 309; height: 386
        clip: true

        MouseArea {
            anchors.fill: parent
            onClicked: ui.pageIndex = ui.PAGE_MAP
        }

        Image {
            anchors.fill: parent
            source: "qrc:/Images/Home/map.png"
            fillMode: Image.Stretch
        }

        // 底部快捷（map_inner.png 靠底，图标自带文字置于其上）
        Image {
            x: 16; y: 275
            width: 275; height: 97
            source: "qrc:/Images/Home/map_inner.png"
            fillMode: Image.Stretch
        }
        Image { x: 33; y: 291; width: 36; height: 70; source: "qrc:/Images/Home/map_home.png"; fillMode: Image.PreserveAspectFit }
        Image { x: 115; y: 291; width: 54; height: 70; source: "qrc:/Images/Home/map_company.png"; fillMode: Image.PreserveAspectFit }
        Image { x: 212; y: 291; width: 54; height: 70; source: "qrc:/Images/Home/map_charging_station.png"; fillMode: Image.PreserveAspectFit }
    }

    // ==================== 音乐播放器（原图 music.png + music_inner.png + 控制钮） ====================
    Item {
        x: 428; y: 187
        width: 309; height: 386

        Image {
            anchors.fill: parent
            source: "qrc:/Images/Home/music.png"
            fillMode: Image.Stretch
        }

        // 专辑封面
        Rectangle {
            x: 103; y: 74
            width: 104; height: 104
            radius: 20
            clip: true

            Image {
                anchors.fill: parent
                source: ui.mediaAlbumArt !== "" ? ui.mediaAlbumArt : "qrc:/Images/Home/music_album.png"
                fillMode: Image.PreserveAspectCrop
            }
        }

        // 歌曲信息（动态）
        Text {
            x: 0; y: 198
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: ui.mediaTitle !== "" ? ui.mediaTitle : "未播放"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Semibold
            font.pixelSize: 18
        }

        Text {
            x: 0; y: 228
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: ui.mediaArtist !== "" ? ui.mediaArtist : "未知歌手"
            color: "white"
            font.family: "PingFang SC"
            font.pixelSize: 16
        }

        // 进度+控制底板（music_inner.png [16,264] 276×112）
        Image {
            x: 16; y: 264
            width: 276; height: 112
            source: "qrc:/Images/Home/music_inner.png"
            fillMode: Image.Stretch
        }

        // 上一曲 [79,307]
        Image {
            x: 59; y: 317
            width: 18; height: 20
            source: "qrc:/Images/Home/music_previous.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            x: 141; y: 317
            width: 24; height: 24
            source: "qrc:/Images/Home/music_play.png"
            fillMode: Image.PreserveAspectFit
        }

        // 暂停/播放圆钮（白圆 54×54 [127,290]，随 mediaPlaying 切换后续实现）
        // Rectangle {
        //     // x: 127; y: 290
        //     // width: 54; height: 54
        //     // radius: 27
        //     // color: "white"

        //     Rectangle {
        //         visible: ui.mediaPlaying
        //         anchors.centerIn: parent
        //         anchors.horizontalCenterOffset: 9
        //         width: 5; height: 18
        //         color: "#18181C"
        //     }
        //     Image {
        //         visible: !ui.mediaPlaying
        //         anchors.centerIn: parent
        //         width: 24; height: 24
        //         source: "qrc:/Images/Home/music_play.png"
        //         fillMode: Image.PreserveAspectFit
        //     }

        //     MouseArea {
        //         anchors.fill: parent
        //         onClicked: ui.mediaPlaying = !ui.mediaPlaying
        //     }
        // }

        // 下一曲 [199,307]
        Image {
            x: 229; y: 317
            width: 18; height: 20
            source: "qrc:/Images/Home/music_next.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    // ==================== 车辆状态（Frame 68 [863,235]，卡 623×176） ====================
    Item {
        x: 767; y: 187
        width: 623; height: 176

        Rectangle {
            anchors.fill: parent
            radius: 10
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: "#2B313B" }
                GradientStop { position: 1.0; color: "#191D25" }
            }
            border.color: "#3A4450"
            border.width: 1
        }

        Text {
            x: 23; y: 18
            text: "已安全陪伴您  " + ui.safeDays + " 天"
            color: "white"
            font.family: "PingFang SC"
            font.pixelSize: 14
        }

        // 车辆状况良好（Group 27 [1119,256] 166×28）
        Rectangle {
            x: 256; y: 21
            width: 166; height: 28
            radius: 4
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "#18484A" }
                GradientStop { position: 0.65; color: "#15378689" }
                GradientStop { position: 1.0; color: "#0020252E" }
            }

            Rectangle {
                width: 28; height: 28
                radius: 4
                color: "#386F78"

                Text {
                    anchors.centerIn: parent
                    text: "✓"
                    color: "white"
                    font.pixelSize: 14
                }
            }

            Text {
                x: 37; y: 4
                text: "车辆状况良好"
                color: "white"
                font.family: "PingFang SC"
                font.pixelSize: 14
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // 里程/续航行（设计稿整行素材 vehicle_mileage.png：车标+8500km+电池+电量点+245km）
        Image {
            x: 23; y: 88
            width: 149; height: 73
            source: "qrc:/Images/Home/vehicle_mileage.png"
            fillMode: Image.PreserveAspectFit
        }

        // 车辆图片（Group 29）
        Rectangle {
            x: 306; y: 122
            width: 306; height: 47
            color: "#0F1218"
        }
        Image {
            x: 310; y: 40
            width: 332; height: 129
            source: "qrc:/Images/Home/vehicle.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    // ==================== 喜马拉雅（Frame 65 [863,446] 413×176） ====================
    // 喜马拉雅（Frame 65 [863,446] 413×176，整卡素材）
    Image {
        x: 767; y: 398
        width: 413; height: 176
        source: "qrc:/Images/Home/radio_background.png"
        fillMode: Image.Stretch
    }
    Image { x: 790; y: 420; width: 93; height: 29; source: "qrc:/Images/Home/radio_logo.png"; fillMode: Image.PreserveAspectFit }
    Image { x: 790; y: 488; width: 131; height: 59; source: "qrc:/Images/Home/radio_slogan.png"; fillMode: Image.PreserveAspectFit }
    Rectangle {
        x: 1038; y: 434
        width: 120; height: 120
        radius: 20
        clip: true

        Image {
            anchors.fill: parent
            source: "qrc:/Images/Home/radio.png"
            fillMode: Image.PreserveAspectCrop
        }
    }

    // 应用图标卡（Frame 64 [1306,446] 180×176，整卡插画 app.png）
    Image {
        x: 1210; y: 398
        width: 180; height: 176
        source: "qrc:/Images/Home/app.png"
        fillMode: Image.Stretch
    }

    // ==================== 底部快捷条（Rectangle 18 [162,707] 1305×123） ====================
    ACQuickBar {
        x: 66; y: 659
    }
}
