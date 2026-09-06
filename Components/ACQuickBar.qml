import QtQuick

// 底部空调快捷条（设计稿 1:1，容器 1305×123 r=16）
// 元素: 车控 | 导航 | 风量 | 左温度± | 吹风(进空调页) | 右温度± | 除霜 | 音乐 | 应用
Rectangle {
    id: root

    width: 1305
    height: 123
    color: "#222A3B"
    radius: 16

    Image {
        anchors.fill: parent
        source: "qrc:/Images/Home/ac_background.png"
        fillMode: Image.Stretch
    }

    function formatTemp(t) {
        return t % 1 === 0 ? t : t.toFixed(1)
    }

    // 风量图标点击（空调页据此弹出风量滑条）
    signal fanClicked()

    // 车控
    Image {
        x: 70; y: 37; width: 48; height: 48
        source: "qrc:/Images/ACBar/model.png"
        fillMode: Image.PreserveAspectFit
    }

    // 导航
    Image {
        x: 214; y: 45; width: 29; height: 32
        source: "qrc:/Images/ACBar/navigation.png"
        fillMode: Image.PreserveAspectFit
    }

    // 风量
    Image {
        x: 388; y: 44; width: 34; height: 34
        source: "qrc:/Images/ACBar/fan.png"
        fillMode: Image.PreserveAspectFit
        opacity: fanMouse.pressed ? 0.6 : 1.0

        MouseArea {
            id: fanMouse
            anchors.fill: parent
            onClicked: root.fanClicked()
        }
    }

    // 左温度（上下箭头右侧垂直堆叠，对称）
    Item {
        x: 445; y: 3
        width: 150; height: 116

        Text {
            anchors.centerIn: parent
            text: root.formatTemp(ui.acLeftTemp)
            color: "white"
            font.family: "Montserrat"
            font.weight: Font.Light
            font.pixelSize: 46
        }

        Image {
            x: 102; y: 20; width: 46; height: 28
            source: "qrc:/Images/ACBar/arrow_up.png"
            fillMode: Image.PreserveAspectFit
            opacity: leftUp.pressed ? 0.6 : 1.0

            MouseArea {
                id: leftUp
                anchors.fill: parent
                onClicked: ui.acLeftTemp += 0.5
            }
        }

        Image {
            x: 102; y: 68; width: 46; height: 28
            source: "qrc:/Images/ACBar/arrow_down.png"
            fillMode: Image.PreserveAspectFit
            opacity: leftDown.pressed ? 0.6 : 1.0

            MouseArea {
                id: leftDown
                anchors.fill: parent
                onClicked: ui.acLeftTemp -= 0.5
            }
        }
    }

    // 吹风（进入空调页）
    Item {
        x: 617; y: 21
        width: 71; height: 81

        Image {
            anchors.centerIn: parent
            source: "qrc:/Images/ACBar/blow.png"
            width: 71; height: 81
            fillMode: Image.PreserveAspectFit
            opacity: blowMouse.pressed ? 0.6 : 1.0
        }

        MouseArea {
            id: blowMouse
            anchors.fill: parent
            onClicked: ui.pageIndex = ui.PAGE_AC
        }
    }

    // 右温度
    Item {
        x: 706; y: 4
        width: 150; height: 116

        Text {
            anchors.centerIn: parent
            text: root.formatTemp(ui.acRightTemp)
            color: "white"
            font.family: "Montserrat"
            font.weight: Font.Light
            font.pixelSize: 46
        }

        Image {
            x: 102; y: 20; width: 46; height: 28
            source: "qrc:/Images/ACBar/arrow_up.png"
            fillMode: Image.PreserveAspectFit
            opacity: rightUp.pressed ? 0.6 : 1.0

            MouseArea {
                id: rightUp
                anchors.fill: parent
                onClicked: ui.acRightTemp += 0.5
            }
        }

        Image {
            x: 102; y: 68; width: 46; height: 28
            source: "qrc:/Images/ACBar/arrow_down.png"
            fillMode: Image.PreserveAspectFit
            opacity: rightDown.pressed ? 0.6 : 1.0

            MouseArea {
                id: rightDown
                anchors.fill: parent
                onClicked: ui.acRightTemp -= 0.5
            }
        }
    }

    // 除霜
    Image {
        x: 859; y: 37; width: 48; height: 48
        source: "qrc:/Images/ACBar/defrost.png"
        fillMode: Image.PreserveAspectFit
    }

    // 音乐
    Image {
        x: 1010; y: 41; width: 41; height: 41
        source: "qrc:/Images/ACBar/music.png"
        fillMode: Image.PreserveAspectFit
    }

    // 应用
    Image {
        x: 1152; y: 44; width: 27; height: 35
        source: "qrc:/Images/Home/menu.png"
        fillMode: Image.PreserveAspectFit
    }
}
