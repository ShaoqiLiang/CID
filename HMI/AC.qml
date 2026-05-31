import QtQuick
import "../Components"

Item {
    id: acPage
    width: parent ? parent.width : 1424
    height: parent ? parent.height : 808

    // 背景
    Rectangle {
        anchors.fill: parent
        color: "#0E141D"
    }

    // 车内饰图
    Image {
        width: parent.width
        height: parent.height - 130
        anchors.top: parent.top
        source: "qrc:/Images/AC/inner.png"
        fillMode: Image.PreserveAspectFit

        // 垂直遮罩
        Image {
            anchors.fill: parent
            source: "qrc:/Images/AC/mask_v.png"
            fillMode: Image.PreserveAspectFit
        }

        // 水平遮罩
        Image {
            anchors.fill: parent
            source: "qrc:/Images/AC/mask_h.png"
            fillMode: Image.PreserveAspectFit
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

    // ==================== 顶部功能 Tab ====================
    // Figma: 882×70, 居中, 顶部偏移约 57px
    ACFunctionTab {
        id: functionTab
        width: 882
        height: 70
        anchors.top: parent.top
        anchors.topMargin: 57
        anchors.horizontalCenter: parent.horizontalCenter
        tabs: ["空调", "通风加热", "滤净", "空调设置"]
    }

    // ==================== 左区温度背景 ====================
    // Figma: 272×511, x=46, y=158
    Image {
        id: leftTempBg
        width: 272
        height: 511
        anchors.left: parent.left
        anchors.leftMargin: 46
        anchors.top: parent.top
        anchors.topMargin: 158
        source: "qrc:/Images/AC/left_temperatur_background.png"
        fillMode: Image.PreserveAspectFit
    }

    // ==================== 左区温度滚轮 ====================
    ACTemperatureWheel {
        id: leftTempWheel
        width: 160
        height: 511
        anchors.left: parent.left
        anchors.leftMargin: 46
        anchors.top: parent.top
        anchors.topMargin: 158
        temperature: ui.acLeftTemp
        direction: 0
        currentTextColor: "#04FAFB"

        onTemperatureChanged: {
            ui.acLeftTemp = temperature
        }
    }

    // ==================== 右区温度背景 ====================
    // Figma: 272×511, x=1047, y=158
    Image {
        id: rightTempBg
        width: 272
        height: 511
        anchors.right: parent.right
        anchors.rightMargin: 46
        anchors.top: parent.top
        anchors.topMargin: 158
        source: "qrc:/Images/AC/right_temperatur_background.png"
        fillMode: Image.PreserveAspectFit
    }

    // ==================== 右区温度滚轮 ====================
    ACTemperatureWheel {
        id: rightTempWheel
        width: 160
        height: 511
        anchors.right: parent.right
        anchors.rightMargin: 46
        anchors.top: parent.top
        anchors.topMargin: 158
        temperature: ui.acRightTemp
        direction: 1
        currentTextColor: "#04FAFB"

        onTemperatureChanged: {
            ui.acRightTemp = temperature
        }
    }

    // ==================== 负离子按钮 ====================
    // Figma: 97×97, #3D4D64, PingFang SC 18px
    Item {
        id: anionBtn
        width: 97; height: 97
        anchors.left: parent.left
        anchors.leftMargin: 250
        anchors.top: parent.top
        anchors.topMargin: 368

        property bool active: true

        Rectangle {
            anchors.fill: parent
            radius: width / 2
            color: anionBtn.active ? "#3D4D64" : "#2A2A3A"
            opacity: anionMouse.pressed ? 0.6 : 1.0

            Behavior on color { ColorAnimation { duration: 200 } }
        }

        Text {
            anchors.centerIn: parent
            text: "负离子"
            color: "white"
            font.family: "PingFang SC"
            font.pixelSize: 18
        }

        MouseArea {
            id: anionMouse
            anchors.fill: parent
            onClicked: anionBtn.active = !anionBtn.active
        }
    }

    // ==================== 香薰按钮 ====================
    // Figma: 97×97, #3D4D64, PingFang SC 18px
    Item {
        id: fragranceBtn
        width: 97; height: 97
        anchors.right: parent.right
        anchors.rightMargin: 250
        anchors.top: parent.top
        anchors.topMargin: 368

        property bool active: true

        Rectangle {
            anchors.fill: parent
            radius: width / 2
            color: fragranceBtn.active ? "#3D4D64" : "#2A2A3A"
            opacity: fragranceMouse.pressed ? 0.6 : 1.0

            Behavior on color { ColorAnimation { duration: 200 } }
        }

        Text {
            anchors.centerIn: parent
            text: "香薰"
            color: "white"
            font.family: "PingFang SC"
            font.pixelSize: 18
        }

        MouseArea {
            id: fragranceMouse
            anchors.fill: parent
            onClicked: fragranceBtn.active = !fragranceBtn.active
        }
    }

    // ==================== 风量滑块弹窗 ====================
    // Figma: 723×71, 圆角 36, #222A3B
    Item {
        id: fanPopup
        anchors.centerIn: parent
        width: 723
        height: 71
        visible: false
        z: 10

        Rectangle {
            anchors.fill: parent
            color: "#CC222A3B"
            radius: 36
        }

        // 减按钮
        Item {
            width: 50; height: 50
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter

            Image {
                anchors.centerIn: parent
                source: "qrc:/Images/ACFan/fan_sub.png"
                width: 21; height: 21
                opacity: fanSubMouse.pressed ? 0.6 : 1.0
            }

            MouseArea {
                id: fanSubMouse
                anchors.fill: parent
                onClicked: {
                    if (ui.acFanSpeed > 0) ui.acFanSpeed--
                    fanTimer.restart()
                }
            }
        }

        // 滑块
        ACFanSlider {
            anchors.left: parent.left
            anchors.leftMargin: 75
            anchors.right: parent.right
            anchors.rightMargin: 75
            anchors.verticalCenter: parent.verticalCenter
            height: 19
            value: ui.acFanSpeed
            maxValue: 7

            onValueChanged: {
                ui.acFanSpeed = value
                fanTimer.restart()
            }
        }

        // 加按钮
        Item {
            width: 50; height: 50
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter

            Image {
                anchors.centerIn: parent
                source: "qrc:/Images/ACFan/fan_add.png"
                width: 33; height: 33
                opacity: fanAddMouse.pressed ? 0.6 : 1.0
            }

            MouseArea {
                id: fanAddMouse
                anchors.fill: parent
                onClicked: {
                    if (ui.acFanSpeed < 7) ui.acFanSpeed++
                    fanTimer.restart()
                }
            }
        }

        // 自动关闭定时器
        Timer {
            id: fanTimer
            interval: 3000
            onTriggered: fanPopup.visible = false
        }
    }

    // ==================== 底部控制栏 ====================
    // Figma: 1305×123, #222A3B
    ACControlBar {
        id: controlBar
        width: 1305
        height: 123
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter

        onFanClicked: {
            fanPopup.visible = !fanPopup.visible
            if (fanPopup.visible) fanTimer.restart()
        }

        onModeClicked: {
            ui.acMode = (ui.acMode + 1) % 3
        }

        onDefrostClicked: {
            ui.acDefrost = !ui.acDefrost
        }

        onContactClicked: {
            ui.acRightTemp = ui.acLeftTemp
        }
    }
}
