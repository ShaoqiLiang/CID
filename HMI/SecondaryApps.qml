import QtQuick
import "../Components"

// 副屏-应用列表（设计稿 1:1，1521×570：与副屏同底，中央为应用列表；细节待补）
Item {
    width: 1521
    height: 570

    // 底色
    Rectangle {
        anchors.fill: parent
        color: "#0B0C11"
    }

    // 装饰光晕（Ellipse 431-434）
    GlowEllipse { x: 35; y: 434; width: 496; height: 137; glowColor: "#3898D8"; blurRadius: 28 }
    GlowEllipse { x: 334; y: 443; width: 471; height: 131; glowColor: "#4D9BA9"; blurRadius: 28 }
    GlowEllipse { x: 652; y: 434; width: 592; height: 140; glowColor: "#333C4D"; blurRadius: 28 }
    GlowEllipse { x: 1209; y: 443; width: 376; height: 131; glowColor: "#333C4D"; blurRadius: 28 }

    // 底部 Dock（Rectangle 2051 [0,478] 1521×92）
    Rectangle {
        x: 0; y: 478
        width: 1521; height: 92
        color: "#222A3B"
    }

    // 左侧图标
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

    // 应用列表区（设计稿：7 列 × 2 行，tile 94×94 @ x139 起 pitch 197，行 y 99/282，标签 22px）
    Grid {
        x: 139; y: 99
        columns: 7
        columnSpacing: 103
        rowSpacing: 42

        Repeater {
            model: [
                { icon: "qrc:/Images/App/Mimo.png", name: "Mimo" },
                { icon: "qrc:/Images/App/Messenger.png", name: "Messen.." },
                { icon: "qrc:/Images/App/Duolinguo.png", name: "Duolingo" },
                { icon: "qrc:/Images/App/Caltulator.png", name: "Calculat.." },
                { icon: "qrc:/Images/App/Spotify.png", name: "Spotify" },
                { icon: "qrc:/Images/App/Swift.png", name: "Swift" },
                { icon: "qrc:/Images/App/Notability.png", name: "Notabili.." },
                { icon: "qrc:/Images/App/Maps.png", name: "Maps" },
                { icon: "qrc:/Images/App/Picstart.png", name: "Picstart" },
                { icon: "qrc:/Images/App/DayOne.png", name: "DayOne" },
                { icon: "qrc:/Images/App/Podcast.png", name: "Podcas.." },
                { icon: "qrc:/Images/App/Vectornator.png", name: "Vectorn.." },
                { icon: "qrc:/Images/App/Music.png", name: "Music" },
                { icon: "qrc:/Images/App/Spark.png", name: "Spark" }
            ]

            Column {
                spacing: 12

                Rectangle {
                    width: 94; height: 94
                    radius: 20.4
                    color: "#1A1E2E"

                    Image {
                        anchors.centerIn: parent
                        width: 64; height: 64
                        source: modelData.icon
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Text {
                    text: modelData.name
                    color: "white"
                    font.family: "PingFang SC"
                    font.pixelSize: 22
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}
