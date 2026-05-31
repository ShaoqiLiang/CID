import QtQuick
import "../Components"

Item {
    id: acPage
    width: parent ? parent.width : 1424
    height: parent ? parent.height : 808

    // 背景
    Image {
        anchors.fill: parent
        source: "qrc:/Images/Home/background.png"
        fillMode: Image.PreserveAspectFit

        // 车内饰图
        Image {
            width: parent.width
            height: parent.height - 170
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
    ACFunctionTab {
        id: functionTab
        width: 600
        height: 56
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        tabs: ["空调", "通风加热", "滤净", "空调设置"]
    }

    // ==================== 左区温度背景 ====================
    Image {
        id: leftTempBg
        width: 200
        height: 420
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 100
        source: "qrc:/Images/AC/left_temperatur_background.png"
        fillMode: Image.PreserveAspectFit
    }

    // ==================== 左区温度滚轮 ====================
    ACTemperatureWheel {
        id: leftTempWheel
        width: 120
        height: 420
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 100
        temperature: ui.acLeftTemp
        direction: 0
        currentTextColor: "#04FAFB"

        onTemperatureChanged: {
            ui.acLeftTemp = temperature
        }
    }

    // ==================== 右区温度背景 ====================
    Image {
        id: rightTempBg
        width: 200
        height: 420
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 100
        source: "qrc:/Images/AC/right_temperatur_background.png"
        fillMode: Image.PreserveAspectFit
    }

    // ==================== 右区温度滚轮 ====================
    ACTemperatureWheel {
        id: rightTempWheel
        width: 120
        height: 420
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 100
        temperature: ui.acRightTemp
        direction: 1
        currentTextColor: "#04FAFB"

        onTemperatureChanged: {
            ui.acRightTemp = temperature
        }
    }

    // ==================== 负离子按钮 ====================
    Item {
        id: anionBtn
        width: 97; height: 97
        anchors.left: parent.left
        anchors.leftMargin: 200
        anchors.top: parent.top
        anchors.topMargin: 300

        property bool active: true

        Image {
            anchors.fill: parent
            source: parent.parent.active ? "qrc:/Images/AC/function_on.png" : "qrc:/Images/AC/function_off.png"
            fillMode: Image.PreserveAspectFit
            opacity: anionMouse.pressed ? 0.6 : 1.0
        }

        Text {
            anchors.centerIn: parent
            text: "负离子"
            color: "white"
            font.pixelSize: 18
        }

        MouseArea {
            id: anionMouse
            anchors.fill: parent
            onClicked: anionBtn.active = !anionBtn.active
        }
    }

    // ==================== 香薰按钮 ====================
    Item {
        id: fragranceBtn
        width: 97; height: 97
        anchors.right: parent.right
        anchors.rightMargin: 200
        anchors.top: parent.top
        anchors.topMargin: 300

        property bool active: true

        Image {
            anchors.fill: parent
            source: parent.parent.active ? "qrc:/Images/AC/function_on.png" : "qrc:/Images/AC/function_off.png"
            fillMode: Image.PreserveAspectFit
            opacity: fragranceMouse.pressed ? 0.6 : 1.0
        }

        Text {
            anchors.centerIn: parent
            text: "香薰"
            color: "white"
            font.pixelSize: 18
        }

        MouseArea {
            id: fragranceMouse
            anchors.fill: parent
            onClicked: fragranceBtn.active = !fragranceBtn.active
        }
    }

    // ==================== 中间风向可视化区域 ====================
    Item {
        id: windArea
        anchors.left: parent.left
        anchors.leftMargin: 250
        anchors.right: parent.right
        anchors.rightMargin: 250
        anchors.top: parent.top
        anchors.topMargin: 120
        height: 350

        // 风向指示 - 吹面
        Image {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
            source: "qrc:/Images/AC/arrow_up.png"
            width: 60; height: 60
            opacity: ui.acMode === 0 || ui.acMode === 2 ? 0.8 : 0.2

            Behavior on opacity { NumberAnimation { duration: 200 } }
        }

        // 风向指示 - 吹脚
        Image {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 40
            source: "qrc:/Images/AC/arrow_down.png"
            width: 60; height: 60
            opacity: ui.acMode === 1 || ui.acMode === 2 ? 0.8 : 0.2

            Behavior on opacity { NumberAnimation { duration: 200 } }
        }

        // 风速指示
        Text {
            anchors.centerIn: parent
            text: "风速: " + ui.acFanSpeed + "/7"
            color: "#80FFFFFF"
            font.pixelSize: 16
        }
    }

    // ==================== 风量滑块弹窗 ====================
    Item {
        id: fanPopup
        anchors.centerIn: parent
        width: 500
        height: 80
        visible: false
        z: 10

        Rectangle {
            anchors.fill: parent
            color: "#CC222A3B"
            radius: height / 2
        }

        // 减按钮
        Item {
            width: 50; height: 50
            anchors.left: parent.left
            anchors.leftMargin: 15
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
            anchors.leftMargin: 70
            anchors.right: parent.right
            anchors.rightMargin: 70
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
            anchors.rightMargin: 15
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
    ACControlBar {
        id: controlBar
        width: parent.width - 80
        height: 120
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter

        onFanClicked: {
            fanPopup.visible = !fanPopup.visible
            if (fanPopup.visible) fanTimer.restart()
        }

        onModeClicked: {
            // 循环切换吹风模式: 0-吹面 1-吹脚 2-吹面+脚
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
