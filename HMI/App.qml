import QtQuick
import "../Components"

Item {
    id: appPage
    width: parent ? parent.width : 1424
    height: parent ? parent.height : 808

    // 背景
    Rectangle {
        anchors.fill: parent
        color: "#0E141D"
    }

    // 淡入动画
    PropertyAnimation {
        id: fadeIn
        target: appPage
        property: "opacity"
        duration: 500
        from: 0
        to: 1
        easing.type: Easing.OutQuad
    }
    Component.onCompleted: fadeIn.start()

    // ==================== 应用网格 ====================
    // Figma 1:1: Frame 151 [166,128]/[166,311] → 页面 [70,80]/[70,263]，7 列 pitch 197.8
    Item {
        x: 70; y: 80
        width: 1281
        height: 324

        // 应用数据
        ListModel {
            id: appModel
            // 第一行
            ListElement { name: "Mimo";         icon: "qrc:/Images/App/Mimo.png" }
            ListElement { name: "Messenger";    icon: "qrc:/Images/App/Messenger.png" }
            ListElement { name: "Duolingo";     icon: "qrc:/Images/App/Duolinguo.png" }
            ListElement { name: "Calculator";   icon: "qrc:/Images/App/Caltulator.png" }
            ListElement { name: "Spotify";      icon: "qrc:/Images/App/Spotify.png" }
            ListElement { name: "Swift";        icon: "qrc:/Images/App/Swift.png" }
            ListElement { name: "Notability";   icon: "qrc:/Images/App/Notability.png" }
            // 第二行
            ListElement { name: "Maps";         icon: "qrc:/Images/App/Maps.png" }
            ListElement { name: "Picstart";     icon: "qrc:/Images/App/Picstart.png" }
            ListElement { name: "DayOne";       icon: "qrc:/Images/App/DayOne.png" }
            ListElement { name: "Podcast";      icon: "qrc:/Images/App/Podcast.png" }
            ListElement { name: "Vectornator";  icon: "qrc:/Images/App/Vectornator.png" }
            ListElement { name: "Music";        icon: "qrc:/Images/App/Music.png" }
            ListElement { name: "Spark";        icon: "qrc:/Images/App/Spark.png" }
        }

        // 网格布局
        Grid {
            anchors.fill: parent
            columns: 7
            rowSpacing: 42
            columnSpacing: 104

            Repeater {
                model: appModel

                Item {
                    width: 94
                    height: 141

                    Column {
                        anchors.fill: parent
                        spacing: 12

                        // App 图标
                        Rectangle {
                            width: 94; height: 94
                            radius: 22
                            color: "#1A1E2E"
                            anchors.horizontalCenter: parent.horizontalCenter

                            Image {
                                anchors.centerIn: parent
                                source: model.icon
                                width: 64; height: 64
                            }

                            // 按压效果
                            MouseArea {
                                anchors.fill: parent
                                onPressed: parent.scale = 0.9
                                onReleased: parent.scale = 1.0
                                onClicked: console.log("打开应用: " + model.name)
                            }

                            Behavior on scale { NumberAnimation { duration: 100 } }
                        }

                        // App 名称
                        Text {
                            text: model.name
                            color: "white"
                            font.family: "PingFang SC"
                            font.pixelSize: 22
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideRight
                        }
                    }
                }
            }
        }
    }

    // ==================== 底部 AC 控制栏 ====================
    ACQuickBar {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 26
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
