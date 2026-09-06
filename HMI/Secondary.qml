import QtQuick
import "../Components"

// 副屏（设计稿 1:1，1521×570：底部 Dock + 空调快捷 + 天气；中央媒体区细节待补）
Item {
    width: 1521
    height: 570

    // 底色
    Rectangle {
        anchors.fill: parent
        color: "#0B0C11"
    }

    // 装饰光晕（Ellipse 431-434）
    GlowEllipse { x: 35; y: 440; width: 300; height: 131; glowColor: "#3898D8"; blurRadius: 28 }
    GlowEllipse { x: 334; y: 443; width: 300; height: 131; glowColor: "#4D9BA9"; blurRadius: 28 }
    GlowEllipse { x: 652; y: 434; width: 592; height: 140; glowColor: "#333C4D"; blurRadius: 28 }
    GlowEllipse { x: 1209; y: 443; width: 376; height: 131; glowColor: "#333C4D"; blurRadius: 28 }

    // 中央媒体区（细节按 spec 补齐）
    // 语音助手行（Frame 86 [88,63] 524×70）
    Item {
        x: 88; y: 63
        width: 70; height: 70

        Image {
            anchors.fill: parent
            source: "qrc:/Images/Home/voice_assistant.png"
            fillMode: Image.PreserveAspectFit
        }
        Rectangle { x: 30; y: 58; width: 21; height: 4; radius: 2; color: "#2D333E" }
    }
    Text {
        x: 172; y: 83
        text: "你可以这样说："
        color: "white"
        font.family: "PingFang SC"
        font.weight: Font.Medium
        font.pixelSize: 22
    }
    Text {
        x: 343; y: 83
        text: "小迪去公司迪路况怎么样？"
        color: "white"
        font.family: "PingFang SC"
        font.pixelSize: 22
    }

    // 爱奇艺视频卡（Frame 88 [650,150] 566×300）
    Rectangle {
        x: 650; y: 150
        width: 566; height: 300
        radius: 10
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop { position: 0.0; color: "#2B313B" }
            GradientStop { position: 1.0; color: "#191D25" }
        }
        border.color: "#4E5866"
        border.width: 1

        Text {
            x: 23; y: 20
            text: "爱奇艺"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Medium
            font.pixelSize: 20
        }
        Text {
            x: 483; y: 20
            text: "换一批"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Medium
            font.pixelSize: 20
        }

        Row {
            x: 25; y: 64
            spacing: 24

            Repeater {
                model: 3

                Rectangle {
                    width: 156; height: 220
                    radius: 8
                    clip: true
                    Image {
                        anchors.fill: parent
                        source: "qrc:/Images/Exported/Document_24_image_8.png"
                        fillMode: Image.PreserveAspectCrop
                    }
                }
            }
        }
    }

    // 游戏中心卡（Frame 91 [1262,150] 208×150）
    Rectangle {
        x: 1262; y: 150
        width: 208; height: 150
        radius: 10
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop { position: 0.0; color: "#2B313B" }
            GradientStop { position: 1.0; color: "#191D25" }
        }
        border.color: "#4E5866"
        border.width: 1

        Rectangle {
            x: 15; y: 19
            width: 16; height: 16
            radius: 8
            rotation: 45
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: "#3DD0FF" }
                GradientStop { position: 1.0; color: "#0FB3E7" }
            }
        }
        Text {
            x: 45; y: 16
            text: "游戏中心"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Medium
            font.pixelSize: 20
        }
        Image {
            x: 8; y: 52
            width: 174; height: 117
            rotation: -3
            source: "qrc:/Images/Exported/Document_27_pngfind_1.png"
            fillMode: Image.PreserveAspectCrop
        }
    }

    // 头像卡（Rectangle 2057 [1262,331] 208×119）
    Rectangle {
        x: 1262; y: 331
        width: 208; height: 119
        radius: 10
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop { position: 0.0; color: "#2B313B" }
            GradientStop { position: 1.0; color: "#191D25" }
        }
        border.color: "#4E5866"
        border.width: 1

        // 机器人（Group 53）
        Rectangle {
            x: 24; y: 25
            width: 70; height: 70
            radius: 15
            color: "#6683E7"

            Rectangle { anchors.centerIn: parent; width: 45; height: 31; radius: 10; color: "#FFFFFF" }
            Rectangle { anchors.centerIn: parent; width: 31; height: 19; radius: 9.5; color: "#181927" }
            Rectangle { anchors.centerIn: parent; anchors.horizontalCenterOffset: -8; width: 6; height: 6; radius: 3; color: "#526EFF" }
            Rectangle { anchors.centerIn: parent; anchors.horizontalCenterOffset: 8; width: 6; height: 6; radius: 3; color: "#526EFF" }
        }

        // 人像（Group 54）
        Rectangle {
            x: 114; y: 25
            width: 70; height: 70
            radius: 15
            color: "#FFE8A5"

            Rectangle { anchors.centerIn: parent; width: 26; height: 32; radius: 13; color: "#FFD6C6" }
            Rectangle { anchors.centerIn: parent; anchors.verticalCenterOffset: -9; width: 28; height: 12; radius: 6; color: "#6D4833" }
        }
    }

    // 天气（Frame 87 [975,80] 481×42）
    Image {
        x: 975; y: 80
        width: 49; height: 42
        source: "qrc:/Images/Home/Weather/sun_clouds.png"
        fillMode: Image.PreserveAspectFit
    }
    Text {
        x: 1044; y: 84
        text: ui.city
        color: "white"
        font.family: "PingFang SC"
        font.weight: Font.Medium
        font.pixelSize: 24
    }
    Rectangle {
        x: 1264; y: 89
        width: 3; height: 24
        radius: 1.5
        color: "#2C333E"
    }
    Text {
        x: 1307; y: 84
        text: ui.weatherDesc + " " + ui.weatherTemp + "°"
        color: "white"
        font.family: "PingFang SC"
        font.pixelSize: 24
    }

    // 底部 Dock（Rectangle 2051 [0,478] 1521×92）
    Rectangle {
        x: 0; y: 478
        width: 1521; height: 92
        color: "#222A3B"
    }

    // 左侧图标（Group 95：返回 / 空调 / ...）
    Image {
        x: 120; y: 505
        width: 38; height: 38
        source: "qrc:/Images/Home/back.png"
        fillMode: Image.PreserveAspectFit
        opacity: 0.8
    }
    Image {
        x: 275; y: 503
        width: 41; height: 41
        source: "qrc:/Images/ACBar/fan.png"
        fillMode: Image.PreserveAspectFit
        opacity: 0.8
    }
    Image {
        x: 1365; y: 503
        width: 32; height: 41
        source: "qrc:/Images/ACBar/music.png"
        fillMode: Image.PreserveAspectFit
        opacity: 0.8
    }

    // 中央空调快捷（Group 99 [447,486] 627×78）
    Item {
        x: 447; y: 486
        width: 627; height: 78

        Image {
            x: 0; y: 17
            width: 42; height: 42
            source: "qrc:/Images/ACBar/fan.png"
            fillMode: Image.PreserveAspectFit
            opacity: 0.9
        }

        // 左温度（Group 97）
        Text {
            x: 84; y: 10
            text: "20º"
            color: "white"
            font.family: "Montserrat"
            font.weight: Font.Light
            font.pixelSize: 46
        }
        Image {
            x: 66; y: 23
            width: 50; height: 30
            source: "qrc:/Images/ACBar/arrow_up.png"
            fillMode: Image.PreserveAspectFit
            opacity: 0.9
        }
        Image {
            x: 201; y: 23
            width: 50; height: 30
            source: "qrc:/Images/ACBar/arrow_down.png"
            fillMode: Image.PreserveAspectFit
            opacity: 0.9
        }

        // 吹风（Group 46 蓝色风扇）
        Rectangle {
            x: 280; y: 42
            width: 68; height: 68
            radius: 34
            color: "#4F78AD"
            opacity: 0.6
        }
        Image {
            x: 287; y: 49
            width: 54; height: 54
            source: "qrc:/Images/ACBar/blow.png"
            fillMode: Image.PreserveAspectFit
        }

        // 右温度（Group 98）
        Text {
            x: 388; y: 10
            text: "20º"
            color: "white"
            font.family: "Montserrat"
            font.weight: Font.Light
            font.pixelSize: 46
        }
        Image {
            x: 370; y: 23
            width: 50; height: 30
            source: "qrc:/Images/ACBar/arrow_up.png"
            fillMode: Image.PreserveAspectFit
            opacity: 0.9
        }
        Image {
            x: 505; y: 23
            width: 50; height: 30
            source: "qrc:/Images/ACBar/arrow_down.png"
            fillMode: Image.PreserveAspectFit
            opacity: 0.9
        }

        // 除霜（defrost 48×48）
        Image {
            x: 579; y: 14
            width: 48; height: 48
            source: "qrc:/Images/ACBar/defrost.png"
            fillMode: Image.PreserveAspectFit
            opacity: 0.9
        }
    }
}
