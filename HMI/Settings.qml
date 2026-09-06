import QtQuick
import QtQuick.Controls
import "../Components"

// 应用设置（设计稿 1:1，坐标 = 设计稿整屏坐标 − (96, 48)）
Item {
    id: settingsPage
    width: parent ? parent.width : 1424
    height: parent ? parent.height : 808

    // 背景
    Rectangle {
        anchors.fill: parent
        color: "#0E141D"
    }

    // 胶囊开关（70×36，选中态 #0978E9→#0873C9 渐变，取自设计稿）
    component SettingsSwitch: Rectangle {
        id: settingsSwitch
        property bool checked: false
        signal toggled(bool checked)
        width: 70; height: 36; radius: 18

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: settingsSwitch.checked ? "#0978E9" : "#21262D" }
            GradientStop { position: 1.0; color: settingsSwitch.checked ? "#0873C9" : "#21262D" }
        }

        Rectangle {
            width: 28; height: 28; radius: 14
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            x: settingsSwitch.checked ? parent.width - width - 4 : 4

            Behavior on x { NumberAnimation { duration: 200 } }
        }

        MouseArea {
            anchors.fill: parent
            preventStealing: true
            onClicked: settingsSwitch.toggled(!settingsSwitch.checked)
        }
    }

    // 整条式分段选择器（405×42 轨道 + 半宽渐变滑块，取自设计稿）
    component SettingsSegmented: Item {
        id: segmented
        property var options: []
        property int currentIndex: 0

        signal activated(int index)

        width: 405
        height: 42

        Rectangle {
            anchors.fill: parent
            radius: height / 2
            color: "#364A5E"
        }

        Rectangle {
            width: parent.width / segmented.options.length
            height: parent.height
            radius: height / 2
            x: segmented.currentIndex * width

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "#43FFFF" }
                GradientStop { position: 1.0; color: "#0978E9" }
            }

            Behavior on x { NumberAnimation { duration: 200 } }
        }

        Row {
            anchors.fill: parent

            Repeater {
                model: segmented.options.length

                Item {
                    width: segmented.width / segmented.options.length
                    height: segmented.height

                    Text {
                        anchors.centerIn: parent
                        text: segmented.options[index]
                        color: "white"
                        font.family: "PingFang SC"
                        font.pixelSize: 16
                    }

                    MouseArea {
                        anchors.fill: parent
                        preventStealing: true
                        onClicked: segmented.activated(index)
                    }
                }
            }
        }
    }

    // 档位滑条行：标签 + 实时"N档"值 + 可拖动滑条
    component SettingsSliderRow: Column {
        id: sliderRow
        property string label: ""
        property int value: 5
        property int maxValue: 15

        signal valueEdited(int value)

        width: parent ? parent.width : 405
        spacing: 8

        Item {
            width: parent.width
            height: 26

            Text {
                text: sliderRow.label
                color: "white"
                font.family: "PingFang SC"
                font.pixelSize: 18
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: sliderRow.value + "档"
                color: "#FFFFFF"
                font.family: "PingFang SC"
                font.pixelSize: 18
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Slider {
            width: parent.width
            value: sliderRow.value / sliderRow.maxValue
            onValueEdited: (v) => sliderRow.valueEdited(Math.round(v * sliderRow.maxValue))
        }
    }

    // ==================== 左侧分类栏（240 宽，节距 122） ====================
    Item {
        id: leftSidebar
        x: 13; y: 0
        width: 240; height: parent.height

        property int currentCategory: 3   // 设计稿默认选中"车辆设置"
        property var categories: ["DiLink", "DiPilot", "新能源", "车辆设置", "车辆健康"]
        property int buttonHeight: 70
        property int pitch: 122
        property int topMargin: 34

        Rectangle {
            anchors.fill: parent
            color: "#10141B"
        }

        // 选中指示条
        Rectangle {
            id: selectedIndicator
            width: 204
            height: 70
            anchors.left: parent.left
            anchors.leftMargin: 18
            y: leftSidebar.topMargin + leftSidebar.currentCategory * leftSidebar.pitch
            radius: 35

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "#43FFFF" }
                GradientStop { position: 1.0; color: "#0978E9" }
            }

            Behavior on y {
                NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
            }
        }

        // 按钮列
        Column {
            anchors.fill: parent
            anchors.topMargin: leftSidebar.topMargin
            spacing: leftSidebar.pitch - leftSidebar.buttonHeight

            Repeater {
                model: leftSidebar.categories.length

                Item {
                    width: 240
                    height: leftSidebar.buttonHeight

                    Text {
                        anchors.centerIn: parent
                        text: leftSidebar.categories[index]
                        color: "white"
                        font.family: "PingFang SC"
                        font.pixelSize: 24
                        font.bold: leftSidebar.currentCategory === index
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: leftSidebar.currentCategory = index
                    }
                }
            }
        }
    }

    // ==================== 顶部功能栏（1099×69 @ [287,34]） ====================
    Item {
        id: functionBar
        x: 287; y: 34
        width: 1099; height: 69

        property int currentFunction: 0
        property var functions: ["智能底盘", "灯光氛围", "抬头显示", "迎宾", "智能记忆", "空调", "门窗和锁", "智能提醒"]
        property var tabX: [70, 207, 344, 481, 577, 714, 810, 947]
        property var tabW: [82, 82, 82, 41, 82, 41, 82, 82]

        Rectangle {
            anchors.fill: parent
            color: "#364A5E"
            radius: 8
        }

        // 指示条（居中于当前 tab 文字）
        Rectangle {
            id: funcIndicator
            width: 52
            height: 9
            radius: 4
            color: "#59EBFD"
            y: 60
            x: functionBar.tabX[functionBar.currentFunction]
               + functionBar.tabW[functionBar.currentFunction] / 2 - width / 2

            Behavior on x {
                NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
            }
        }

        Repeater {
            model: functionBar.functions.length

            Text {
                x: functionBar.tabX[index]
                y: 20
                width: functionBar.tabW[index]
                height: 29
                text: functionBar.functions[index]
                color: "white"
                font.family: "PingFang SC"
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: functionBar.currentFunction = index
                }
            }
        }
    }

    // ==================== 设置列表（按选中 Tab 过滤显示，列宽 405） ====================
    Flickable {
        id: flickable
        anchors.left: leftSidebar.right
        anchors.leftMargin: 72
        anchors.top: functionBar.bottom
        anchors.topMargin: 26
        anchors.right: parent.right
        anchors.rightMargin: 600
        anchors.bottom: parent.bottom
        clip: true
        contentWidth: width
        contentHeight: settingsColumn.height + 40
        maximumFlickVelocity: 5000
        boundsBehavior: Flickable.StopAtBounds

        Column {
            id: settingsColumn
            width: 405
            spacing: 45

            // 0 智能底盘
            Column {
                id: chassisSettings
                visible: functionBar.currentFunction === 0
                width: parent.width
                spacing: 28
                property int steeringMode: 1   // 设计稿默认选中"运动"
                property int trafficMode: 0    // 0-城市 1-越野
                property bool comfortParking: false

                Text { text: "智能底盘"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }

                // 转向助力模式
                Column {
                    width: parent.width; spacing: 18
                    Text { text: "转向助力模式"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18 }
                    SettingsSegmented {
                        options: ["舒适", "运动"]
                        currentIndex: chassisSettings.steeringMode
                        onActivated: (index) => chassisSettings.steeringMode = index
                    }
                }

                // 交通环境
                Column {
                    width: parent.width; spacing: 18
                    Text { text: "交通环境"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18 }
                    SettingsSegmented {
                        options: ["城市", "越野"]
                        currentIndex: chassisSettings.trafficMode
                        onActivated: (index) => chassisSettings.trafficMode = index
                    }
                }

                // 舒适停车
                Row {
                    width: parent.width
                    Text { text: "舒适停车"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter }
                    Item { width: parent.width - 70 - 130; height: 1; anchors.verticalCenter: parent.verticalCenter }
                    SettingsSwitch {
                        checked: chassisSettings.comfortParking
                        anchors.verticalCenter: parent.verticalCenter
                        onToggled: (checked) => chassisSettings.comfortParking = checked
                    }
                }
            }

            // 1 灯光氛围
            Column {
                id: lightSettings
                visible: functionBar.currentFunction === 1
                width: parent.width
                spacing: 28
                property int headlampHeight: 5   // 0-15 档
                property bool ambientLight: false
                property bool dynamicColor: false

                Text { text: "灯光氛围"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }

                SettingsSliderRow {
                    label: "大灯高度调节"
                    value: lightSettings.headlampHeight
                    maxValue: 15
                    onValueEdited: (value) => lightSettings.headlampHeight = value
                }

                Row {
                    width: parent.width
                    Text { text: "氛围灯"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter }
                    Item { width: parent.width - 70 - 130; height: 1; anchors.verticalCenter: parent.verticalCenter }
                    SettingsSwitch {
                        checked: lightSettings.ambientLight
                        anchors.verticalCenter: parent.verticalCenter
                        onToggled: (checked) => lightSettings.ambientLight = checked
                    }
                }

                Row {
                    width: parent.width
                    Text { text: "氛围灯动态色彩"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter }
                    Item { width: parent.width - 70 - 158; height: 1; anchors.verticalCenter: parent.verticalCenter }
                    SettingsSwitch {
                        checked: lightSettings.dynamicColor
                        anchors.verticalCenter: parent.verticalCenter
                        onToggled: (checked) => lightSettings.dynamicColor = checked
                    }
                }
            }

            // 2 抬头显示
            Column {
                id: hudSettings
                visible: functionBar.currentFunction === 2
                width: parent.width
                spacing: 28
                property int hudHeight: 5        // 0-10 档
                property int hudBrightness: 5
                property int hudRotation: 5

                Text { text: "抬头显示"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }

                SettingsSliderRow {
                    label: "高度调节"
                    value: hudSettings.hudHeight
                    maxValue: 10
                    onValueEdited: (value) => hudSettings.hudHeight = value
                }

                SettingsSliderRow {
                    label: "亮度调节"
                    value: hudSettings.hudBrightness
                    maxValue: 10
                    onValueEdited: (value) => hudSettings.hudBrightness = value
                }

                SettingsSliderRow {
                    label: "旋转调节"
                    value: hudSettings.hudRotation
                    maxValue: 10
                    onValueEdited: (value) => hudSettings.hudRotation = value
                }
            }

            // 3 迎宾
            Column {
                visible: functionBar.currentFunction === 3
                width: parent.width; spacing: 28
                Text { text: "迎宾"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }
                Rectangle {
                    width: parent.width; height: 60; radius: 12; color: "#161B22"
                    Text { anchors.centerIn: parent; text: "迎宾设置"; color: "#8B949E"; font.pixelSize: 16 }
                }
            }

            // 4 智能记忆
            Column {
                visible: functionBar.currentFunction === 4
                width: parent.width; spacing: 28
                Text { text: "智能记忆"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }
                Rectangle {
                    width: parent.width; height: 60; radius: 12; color: "#161B22"
                    Text { anchors.centerIn: parent; text: "智能记忆设置"; color: "#8B949E"; font.pixelSize: 16 }
                }
            }

            // 5 空调
            Column {
                visible: functionBar.currentFunction === 5
                width: parent.width; spacing: 28
                Text { text: "空调"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }
                Rectangle {
                    width: parent.width; height: 60; radius: 12; color: "#161B22"
                    Text { anchors.centerIn: parent; text: "空调设置"; color: "#8B949E"; font.pixelSize: 16 }
                }
            }

            // 6 门窗和锁
            Column {
                visible: functionBar.currentFunction === 6
                width: parent.width; spacing: 28
                Text { text: "门窗和锁"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }
                Rectangle {
                    width: parent.width; height: 60; radius: 12; color: "#161B22"
                    Text { anchors.centerIn: parent; text: "门窗和锁设置"; color: "#8B949E"; font.pixelSize: 16 }
                }
            }

            // 7 智能提醒
            Column {
                visible: functionBar.currentFunction === 7
                width: parent.width; spacing: 28
                Text { text: "智能提醒"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }
                Rectangle {
                    width: parent.width; height: 60; radius: 12; color: "#161B22"
                    Text { anchors.centerIn: parent; text: "智能提醒设置"; color: "#8B949E"; font.pixelSize: 16 }
                }
            }
        }

        // 滚动条（12×260 #364A5E，取自设计稿）
        Rectangle {
            id: scrollBar
            anchors.right: parent.right
            width: 12
            height: 260
            radius: 6
            color: "#364A5E"
            y: flickable.visibleArea.yPosition * flickable.height
            visible: flickable.contentHeight > flickable.height
        }
    }

    // ==================== 右侧车辆信息（472×430 @ [881,187]） ====================
    Item {
        x: 881; y: 187
        width: 472; height: 430

        // 已安全陪伴
        Text {
            x: 298; y: 0
            text: "已安全陪伴您  " + ui.safeDays + " 天"
            color: "#FFFFFF"
            font.family: "PingFang SC"
            font.pixelSize: 14
        }

        // 总里程
        Row {
            x: 308; y: 59
            spacing: 10

            Image {
                source: "qrc:/Images/Settings/miles.png"
                width: 21; height: 19
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: ui.vehicleMileage.toFixed(0) + " km"
                color: "white"
                font.family: "PingFang SC"
                font.weight: Font.DemiBold
                font.pixelSize: 22
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // 剩余续航（电池 + 5 格信号点）
        Row {
            x: 308; y: 101
            spacing: 10

            Rectangle {
                width: 14; height: 20
                color: "transparent"
                border.color: "#8B949E"
                border.width: 1
                radius: 2
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    x: 2; y: 4
                    width: 10; height: 12
                    color: "#4A88FB"
                    radius: 1
                }
            }

            Text {
                text: ui.vehicleRange + " km"
                color: "white"
                font.family: "PingFang SC"
                font.weight: Font.DemiBold
                font.pixelSize: 22
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row {
            x: 333; y: 129
            spacing: 0

            Repeater {
                model: 5

                Rectangle {
                    width: 9; height: 9
                    radius: 4.5
                    color: index < 4 ? "#4A88FB" : "#404A88FB"
                }
            }
        }

        // 车辆图片（含底部投影）
        Rectangle {
            x: 0; y: 297
            width: 430; height: 66
            color: "#0F1218"
        }

        Image {
            x: 5; y: 182
            width: 466; height: 181
            source: "qrc:/Images/Settings/vehicle.png"
            fillMode: Image.PreserveAspectFit
        }

        // 车辆状况良好
        Rectangle {
            x: 290; y: 402
            width: 166; height: 28
            radius: 14

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "#0978E9" }
                GradientStop { position: 1.0; color: "#0873C9" }
            }

            Row {
                anchors.fill: parent
                anchors.leftMargin: 0
                spacing: 9

                Rectangle {
                    x: 0; y: 0
                    width: 28; height: 28
                    radius: 14
                    color: "#386F78"

                    Text {
                        anchors.centerIn: parent
                        text: "✓"
                        color: "white"
                        font.pixelSize: 14
                    }
                }

                Text {
                    text: "车辆状况良好"
                    color: "white"
                    font.family: "PingFang SC"
                    font.pixelSize: 14
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    // 底部空调快捷条
    ACQuickBar {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 26
        anchors.horizontalCenter: parent.horizontalCenter
        z: 10
    }
}
