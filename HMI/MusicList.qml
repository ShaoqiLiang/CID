import QtQuick
import "../Components"

// 音乐列表（设计稿 1:1：左侧模糊车图 + 右侧 #18181C 面板，内容可滚动）
Item {
    width: parent ? parent.width : 1424
    height: parent ? parent.height : 808

    // 内容面板
    Rectangle {
        anchors.fill: parent
        radius: 30
        color: "#171E29"
    }

    // 左侧模糊车辆区（Group 101 [108,0] 474×854）
    Item {
        x: 12; y: 0
        width: 474; height: 854
        clip: true

        Image {
            x: -129; y: -123
            width: 642; height: 1102
            source: "qrc:/Images/Exported/Document_24_image_8.png"
            fillMode: Image.PreserveAspectCrop
        }
        Rectangle {
            anchors.fill: parent
            color: "#66000000"
        }
    }

    // 右侧面板（Rectangle 2064 [582,0] 939×856）
    Rectangle {
        x: 486; y: 0
        width: 939; height: 856
        color: "#18181C"

        // Tab（发现音乐/我的收藏/我的下载 + 指示条）
        Text {
            x: 128; y: 17
            text: "发现音乐"
            color: "white"
            font.family: "PingFang SC"
            font.pixelSize: 20
        }
        Text {
            x: 267; y: 17
            text: "我的收藏"
            color: "white"
            opacity: 0.5
            font.family: "PingFang SC"
            font.pixelSize: 20
        }
        Text {
            x: 403; y: 17
            text: "我的下载"
            color: "white"
            opacity: 0.5
            font.family: "PingFang SC"
            font.pixelSize: 20
        }
        Rectangle {
            x: 144; y: 61
            width: 52; height: 5
            radius: 2.5
            color: "#59EBFD"
        }

        // 封面轮播（Group 102）
        Rectangle {
            x: 42; y: 96
            width: 216; height: 216
            radius: 24
            clip: true
            Image { anchors.fill: parent; source: "qrc:/Images/Exported/Document_09_Rectangle_2067.jpg"; fillMode: Image.PreserveAspectCrop }
        }
        Rectangle {
            x: 240; y: 96
            width: 216; height: 216
            radius: 24
            clip: true
            Image { anchors.fill: parent; source: "qrc:/Images/Exported/Document_10_Rectangle_2068.jpg"; fillMode: Image.PreserveAspectCrop }
        }
        Rectangle {
            x: 121; y: 75
            width: 260; height: 260
            radius: 24
            clip: true
            z: 2
            Image { anchors.fill: parent; source: "qrc:/Images/Exported/Document_11_Rectangle_2066.jpg"; fillMode: Image.PreserveAspectCrop }
        }

        // 播放信息（Group 106）
        Text {
            x: 12; y: 343
            text: "Love The Way You Lie"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Semibold
            font.pixelSize: 28
        }
        Text {
            x: 129; y: 392
            text: "Eminem"
            color: "white"
            font.family: "PingFang SC"
            font.pixelSize: 18
        }

        // 进度（2:20 / 260×2 槽 / 207×2 填充 / 3:20）
        Text {
            x: -17; y: 464
            text: "2:20"
            color: "white"
            font.family: "PingFang SC"
            font.pixelSize: 18
        }
        Rectangle {
            x: 32; y: 476
            width: 260; height: 2
            color: "#40FFFFFF"
        }
        Rectangle {
            x: 32; y: 476
            width: 207; height: 2
            color: "white"
        }
        Text {
            x: 311; y: 464
            text: "3:20"
            color: "white"
            font.family: "PingFang SC"
            font.pixelSize: 18
        }

        // 播放控制（Frame 100：上一曲 / 暂停白圆 / 下一曲 / 随机）
        Image {
            x: 4; y: 618
            width: 18; height: 20
            source: "qrc:/Images/Home/music_previous.png"
            fillMode: Image.PreserveAspectFit
        }
        Rectangle {
            x: 81; y: 600
            width: 55; height: 55
            radius: 27.5
            color: "white"

            Rectangle { x: 20; y: 19; width: 4; height: 18; color: "#18181C" }
            Rectangle { x: 30; y: 19; width: 4; height: 18; color: "#18181C" }
        }
        Image {
            x: 202; y: 618
            width: 18; height: 20
            source: "qrc:/Images/Home/music_next.png"
            fillMode: Image.PreserveAspectFit
        }
        Rectangle {
            x: 272; y: 615
            width: 25; height: 25
            rotation: 45
            color: "transparent"
            border.color: "white"
            border.width: 2
        }

        // 推荐卡（Frame 101 [630,175] 1102×177，三张 346×177）
        Row {
            x: 48; y: 127
            spacing: 32

            Rectangle {
                width: 346; height: 177
                radius: 14
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#4D90F7" }
                    GradientStop { position: 1.0; color: "#BC1FAB" }
                }

                Column {
                    x: 20; y: 20
                    Text { text: "酷狗音乐"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18 }
                    Text { text: "热门榜单"; color: "white"; font.family: "PingFang SC"; font.weight: Font.Semibold; font.pixelSize: 32; y: 7 }
                }
                Row {
                    x: 22; y: 130
                    spacing: 3
                    Rectangle { width: 8; height: 8; radius: 4; color: "white" }
                    Rectangle { width: 18; height: 8; radius: 4; color: "white" }
                }
            }
            Rectangle {
                width: 346; height: 177
                radius: 14
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#4D90F7" }
                    GradientStop { position: 1.0; color: "#78D8E1" }
                }

                Column {
                    x: 20; y: 20
                    Text { text: "专属推荐"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18 }
                    Text { text: "推荐歌曲"; color: "white"; font.family: "PingFang SC"; font.weight: Font.Semibold; font.pixelSize: 32; y: 7 }
                }
                Row {
                    x: 22; y: 130
                    spacing: 3
                    Rectangle { width: 8; height: 8; radius: 4; color: "white" }
                    Rectangle { width: 18; height: 8; radius: 4; color: "white" }
                }
            }
            Rectangle {
                width: 346; height: 177
                radius: 14
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#48B8D8" }
                    GradientStop { position: 0.42; color: "#56C2AC" }
                    GradientStop { position: 0.76; color: "#3EA16A" }
                    GradientStop { position: 1.0; color: "#5968F8" }
                }

                Column {
                    x: 20; y: 20
                    Text { text: "专属推荐"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18 }
                    Text { text: "摇滚的夏天"; color: "white"; font.family: "PingFang SC"; font.weight: Font.Semibold; font.pixelSize: 32; y: 7 }
                }
                Row {
                    x: 22; y: 130
                    spacing: 3
                    Rectangle { width: 8; height: 8; radius: 4; color: "white" }
                    Rectangle { width: 18; height: 8; radius: 4; color: "white" }
                }
            }
        }

        // 能量充电（Frame 110 [630,392]）
        Text {
            x: 48; y: 344
            text: "能量充电"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Semibold
            font.pixelSize: 28
        }

        Row {
            x: 48; y: 408
            spacing: 40

            Repeater {
                model: [
                    { cover: "qrc:/Images/Exported/Document_12_Rectangle_2077.jpg", song: "我的新衣", artist: "VAVA" },
                    { cover: "qrc:/Images/Exported/Document_13_Rectangle_2077.jpg", song: "Shape Of You", artist: "Ed Sheeran" },
                    { cover: "qrc:/Images/Exported/Document_14_Rectangle_2077.jpg", song: "Havanan", artist: "Camila Cabello" },
                    { cover: "qrc:/Images/Exported/Document_15_Rectangle_2077.jpg", song: "NOJITO", artist: "周杰伦" }
                ]

                Column {
                    spacing: 15

                    Rectangle {
                        width: 184; height: 195
                        radius: 16
                        clip: true
                        Image { anchors.fill: parent; source: modelData.cover; fillMode: Image.PreserveAspectCrop }
                    }
                    Text { text: modelData.song; color: "white"; font.family: "PingFang SC"; font.pixelSize: 22 }
                    Text { text: modelData.artist; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18 }
                }
            }
        }

        // 专属电台（[630,755]）
        Text {
            x: 48; y: 707
            text: "专属电台"
            color: "white"
            font.family: "PingFang SC"
            font.weight: Font.Semibold
            font.pixelSize: 28
        }

        Row {
            x: 48; y: 771
            spacing: 40

            Repeater {
                model: [
                    { cover: "qrc:/Images/Exported/Document_16_Rectangle_2077.jpg" },
                    { cover: "qrc:/Images/Exported/Document_17_Rectangle_2077.jpg" },
                    { cover: "qrc:/Images/Exported/Document_18_Rectangle_2077.jpg" }
                ]

                Column {
                    spacing: 15

                    Rectangle {
                        width: 184; height: 195
                        radius: 16
                        clip: true
                        Image { anchors.fill: parent; source: modelData.cover; fillMode: Image.PreserveAspectCrop }
                    }
                    Text { text: "能量充电"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 22 }
                    Text { text: "VAVA"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18 }
                }
            }
        }
    }
}
