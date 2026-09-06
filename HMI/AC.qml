import QtQuick
import "../Components"

// 空调页（设计稿 1:1，坐标 = 设计稿整屏坐标 − (96, 48)）
Item {
    id: acPage
    width: parent ? parent.width : 1424
    height: parent ? parent.height : 808

    // 页面底色（设计稿 #151C26→#0D1015）
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#151C26" }
            GradientStop { position: 1.0; color: "#0D1015" }
        }
    }

    // 内容面板（Rectangle 3464239）
    Rectangle {
        x: 11; y: 0
        width: 1414; height: 707
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#FF1B222E" }
            GradientStop { position: 0.52; color: "#00131921" }
            GradientStop { position: 1.0; color: "#FF394351" }
        }
    }

    // 车内饰（Mask group [13,0] 1412×707，原图 -186,-247 1738×1159 裁切 + 渐变遮罩 Rectangle 3464238）
    Item {
        x: 13; y: 0
        width: 1412; height: 707
        clip: true

        Image {
            x: -186; y: -247
            width: 1738; height: 1159
            source: "qrc:/Images/AC/inner.png"
            fillMode: Image.PreserveAspectCrop
        }

        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.05; color: "#FF28303D" }
                GradientStop { position: 0.52; color: "#00131921" }
                GradientStop { position: 0.98; color: "#FF171A2A" }
            }
        }
    }

    // 淡入动画
    PropertyAnimation {
        id: fadeIn
        target: acPage
        property: "opacity"
        duration: 500
        from: 0
        to: 1
        easing.type: Easing.OutQuad
    }
    Component.onCompleted: fadeIn.start()

    // ==================== 顶部功能 Tab（Frame 175 [320,57] 882×70） ====================
    ACFunctionTab {
        x: 224; y: 9
        width: 882; height: 70
        tabs: ["空调", "通风加热", "滤净", "空调设置"]
        tabX: [80, 336, 560, 736]
        tabW: [48, 96, 48, 96]
    }

    // ==================== 左区温度滚轮（Group 1739331928 [155,158]，镜像弧） ====================
    ACTemperatureWheel {
        x: 57; y: 110
        temperature: ui.acLeftTemp
        direction: 1
        currentTextColor: "#04FAFB"

        onTemperatureEdited: (temp) => ui.acLeftTemp = temp
    }

    // ==================== 右区温度滚轮（Group 1739331924 [1154,158]） ====================
    ACTemperatureWheel {
        x: 1057; y: 110
        temperature: ui.acRightTemp
        direction: 0
        currentTextColor: "#04FAFB"

        onTemperatureEdited: (temp) => ui.acRightTemp = temp
    }

    // ==================== 滚轮边缘发光条（Vector 504/505） ====================
    Rectangle {
        x: 63; y: 303
        width: 4; height: 147
        radius: 2
        color: "#06F6F8"
        opacity: 0.6
    }
    Rectangle {
        x: 1323; y: 304
        width: 4; height: 147
        radius: 2
        color: "#06F6F8"
        opacity: 0.6
    }

    // ==================== 负离子（Ellipse 463 [373,368]，径向渐变） ====================
    Item {
        id: anionBtn
        x: 277; y: 320
        width: 97; height: 97

        property bool active: true

        Rectangle {
            anchors.fill: parent
            radius: width / 2
            color: "#3E4D65"
            visible: !anionBtn.active
        }
        Rectangle {
            anchors.fill: parent
            radius: width / 2
            color: "#1845D0"
            visible: anionBtn.active
        }
        Rectangle {
            anchors.centerIn: parent
            width: 70; height: 70
            radius: 35
            color: "#4A83E0"
            visible: anionBtn.active
        }
        Rectangle {
            anchors.centerIn: parent
            width: 45; height: 45
            radius: 22.5
            color: "#7CC1E9"
            visible: anionBtn.active
        }

        Text {
            anchors.centerIn: parent
            text: "负离子"
            color: "white"
            font.family: "PingFang SC"
            font.pixelSize: 18
        }

        MouseArea {
            anchors.fill: parent
            onClicked: anionBtn.active = !anionBtn.active
        }
    }

    // ==================== 香薰（[1116,369]） ====================
    Item {
        id: fragranceBtn
        x: 1020; y: 321
        width: 97; height: 97

        property bool active: false

        Rectangle {
            anchors.fill: parent
            radius: width / 2
            color: "#3E4D65"
            visible: !fragranceBtn.active
        }
        Rectangle {
            anchors.fill: parent
            radius: width / 2
            color: "#1845D0"
            visible: fragranceBtn.active
        }
        Rectangle {
            anchors.centerIn: parent
            width: 70; height: 70
            radius: 35
            color: "#4A83E0"
            visible: fragranceBtn.active
        }
        Rectangle {
            anchors.centerIn: parent
            width: 45; height: 45
            radius: 22.5
            color: "#7CC1E9"
            visible: fragranceBtn.active
        }

        Text {
            anchors.centerIn: parent
            text: "香薰"
            color: "white"
            font.family: "PingFang SC"
            font.pixelSize: 18
        }

        MouseArea {
            anchors.fill: parent
            onClicked: fragranceBtn.active = !fragranceBtn.active
        }
    }

    // ==================== 风量滑条弹窗（Rectangle 3464241 [430,617] 723×71） ====================
    Item {
        id: fanPopup
        x: 334; y: 569
        width: 723; height: 71
        visible: false
        z: 10

        Rectangle {
            anchors.fill: parent
            radius: height / 2
            color: "#222A3B"
            opacity: 0.7
        }

        // 减按钮（INSTANCE fan 21×21 @[39,25]）
        Image {
            x: 39; y: 25
            width: 21; height: 21
            source: "qrc:/Images/ACFan/fan_sub.png"
            fillMode: Image.PreserveAspectFit
            opacity: fanSubMouse.pressed ? 0.6 : 1.0

            MouseArea {
                id: fanSubMouse
                anchors.fill: parent
                onClicked: {
                    ui.acFanSpeed--
                    fanTimer.restart()
                }
            }
        }

        // 滑条（Rectangle 3464242/3464243 [88,26] 535×19）
        ACFanSlider {
            x: 88; y: 26
            value: ui.acFanSpeed

            onValueEdited: (newValue) => {
                ui.acFanSpeed = newValue
                fanTimer.restart()
            }
        }

        // 加按钮（INSTANCE fan 33×33 @[651,19]）
        Image {
            x: 651; y: 19
            width: 33; height: 33
            source: "qrc:/Images/ACFan/fan_add.png"
            fillMode: Image.PreserveAspectFit
            opacity: fanAddMouse.pressed ? 0.6 : 1.0

            MouseArea {
                id: fanAddMouse
                anchors.fill: parent
                onClicked: {
                    ui.acFanSpeed++
                    fanTimer.restart()
                }
            }
        }

        Timer {
            id: fanTimer
            interval: 3000
            onTriggered: fanPopup.visible = false
        }
    }

    // ==================== 底部快捷条（Rectangle 18 [162,707] 1305×123） ====================
    ACQuickBar {
        x: 66; y: 659

        onFanClicked: {
            fanPopup.visible = !fanPopup.visible
            if (fanPopup.visible) fanTimer.restart()
        }
    }
}
