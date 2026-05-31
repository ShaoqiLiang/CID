import QtQuick
import QtQuick.Controls
import "../Components"

Item {
    id: settingsPage
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
        target: settingsPage
        property: "opacity"
        duration: 500
        from: 0
        to: 1
        easing.type: Easing.OutQuad
    }
    Component.onCompleted: fadeIn.start()

    // ==================== 左侧分类栏 ====================
    Item {
        id: leftSidebar
        width: 240
        height: parent.height
        anchors.left: parent.left

        property int currentCategory: 0
        property var categories: ["DiLink", "DiPilot", "新能源", "车辆设置", "车辆健康"]
        property int buttonHeight: 70
        property int topMargin: 20

        // 背景
        Rectangle {
            anchors.fill: parent
            color: "#161B22"
        }

        // 选中指示条
        Rectangle {
            id: selectedIndicator
            width: 204
            height: 60
            anchors.left: parent.left
            anchors.leftMargin: 18
            y: leftSidebar.topMargin + leftSidebar.currentCategory * leftSidebar.buttonHeight + (leftSidebar.buttonHeight - height) / 2
            radius: 30

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
            spacing: 0

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

    // ==================== 右侧内容区 ====================
    Item {
        anchors.left: leftSidebar.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        // ==================== 顶部功能栏 ====================
        Item {
            id: functionBar
            width: parent.width
            height: 69
            anchors.top: parent.top
            anchors.topMargin: 12

            Rectangle {
                anchors.fill: parent
                color: "#161B22"
                radius: 8
            }

            property int currentFunction: 0
            property var functions: ["智能底盘", "灯光氛围", "抬头显示", "迎宾", "智能记忆", "空调", "门窗和锁", "智能提醒"]

            // 指示条
            Rectangle {
                id: funcIndicator
                width: 52
                height: 9
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
                radius: 4
                color: "#59EBFD"
                x: funcBarRow.x + funcBarRow.children[functionBar.currentFunction].x + funcBarRow.children[functionBar.currentFunction].width / 2 - width / 2

                Behavior on x {
                    NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
                }
            }

            Row {
                id: funcBarRow
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20

                Repeater {
                    model: functionBar.functions.length

                    Item {
                        width: funcBarRow.width / functionBar.functions.length
                        height: parent.height

                        Text {
                            anchors.centerIn: parent
                            text: functionBar.functions[index]
                            color: "white"
                            font.family: "PingFang SC"
                            font.pixelSize: 20
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: functionBar.currentFunction = index
                        }
                    }
                }
            }
        }

        // ==================== 设置列表 ====================
        Flickable {
            id: flickable
            anchors.left: parent.left
            anchors.right: vehicleInfo.left
            anchors.top: functionBar.bottom
            anchors.topMargin: 12
            anchors.bottom: parent.bottom
            anchors.leftMargin: 30
            clip: true
            contentWidth: width
            contentHeight: settingsColumn.height + 40
            maximumFlickVelocity: 5000
            boundsBehavior: Flickable.StopAtBounds

            Column {
                id: settingsColumn
                width: parent.width
                spacing: 40

                // 智能底盘
                Column {
                    id: chassisSettings
                    width: parent.width
                    spacing: 20
                    property int steeringMode: 0   // 0-舒适 1-运动
                    property int trafficMode: 0     // 0-城市 1-越野

                    Text { text: "智能底盘"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }

                    // 转向助力模式
                    Column {
                        width: parent.width; spacing: 8
                        Text { text: "转向助力模式"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18 }
                        Row {
                            spacing: 12
                            Repeater {
                                model: ["舒适", "运动"]
                                delegate: Rectangle {
                                    width: 120; height: 42
                                    radius: 8
                                    color: chassisSettings.steeringMode === index ? "#3D5AFE" : "#21262D"

                                    Behavior on color { ColorAnimation { duration: 150 } }

                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData; color: "white"; font.pixelSize: 18
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        preventStealing: true
                                        onClicked: {
                                            chassisSettings.steeringMode = index
                                            console.log("转向: " + modelData)
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // 交通环境
                    Column {
                        width: parent.width; spacing: 8
                        Text { text: "交通环境"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18 }
                        Row {
                            spacing: 12
                            Repeater {
                                model: ["城市", "越野"]
                                delegate: Rectangle {
                                    width: 120; height: 42
                                    radius: 8
                                    color: chassisSettings.trafficMode === index ? "#3D5AFE" : "#21262D"

                                    Behavior on color { ColorAnimation { duration: 150 } }

                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData; color: "white"; font.pixelSize: 18
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        preventStealing: true
                                        onClicked: {
                                            chassisSettings.trafficMode = index
                                            console.log("环境: " + modelData)
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // 舒适停车
                    Row {
                        width: parent.width
                        spacing: 16
                        Text { text: "舒适停车"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter }
                        Item { width: parent.width - 250; height: 1 }
                        // 开关按钮
                        Rectangle {
                            id: parkingSwitch
                            width: 70; height: 36
                            radius: 18
                            color: parkingSwitch.checked ? "#3D5AFE" : "#21262D"
                            anchors.verticalCenter: parent.verticalCenter
                            property bool checked: false

                            Rectangle {
                                width: 28; height: 28
                                radius: 14
                                color: "white"
                                anchors.verticalCenter: parent.verticalCenter
                                x: parent.checked ? parent.width - width - 4 : 4

                                Behavior on x {
                                    NumberAnimation { duration: 200 }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                preventStealing: true
                                onClicked: parkingSwitch.checked = !parkingSwitch.checked
                            }
                        }
                    }
                }

                // 灯光氛围
                Column {
                    width: parent.width
                    spacing: 20

                    Text { text: "灯光氛围"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }

                    // 大灯高度调节
                    Column {
                        width: parent.width; spacing: 8
                        Text { text: "大灯高度调节"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18 }
                        Rectangle {
                            width: parent.width; height: 19; radius: 10; color: "#21262D"
                            MouseArea {
                                anchors.fill: parent
                                preventStealing: true
                                onClicked: (mouse) => {
                                    var ratio = mouse.x / parent.width
                                    lampProgress.width = Math.max(10, Math.min(parent.width, ratio * parent.width))
                                }
                            }
                            Rectangle {
                                id: lampProgress
                                width: parent.width * 0.5; height: parent.height; radius: 10
                                gradient: Gradient {
                                    orientation: Gradient.Horizontal
                                    GradientStop { position: 0.0; color: "#0532FB" }
                                    GradientStop { position: 1.0; color: "#52E6FB" }
                                }
                            }
                        }
                    }

                    // 氛围灯
                    Row {
                        width: parent.width; spacing: 16
                        Text { text: "氛围灯"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter }
                        Item { width: parent.width - 250; height: 1 }
                        Rectangle {
                            id: ambientSwitch
                            width: 70; height: 36; radius: 18
                            color: ambientSwitch.checked ? "#3D5AFE" : "#21262D"
                            anchors.verticalCenter: parent.verticalCenter
                            property bool checked: false
                            Rectangle {
                                width: 28; height: 28; radius: 14; color: "white"
                                anchors.verticalCenter: parent.verticalCenter
                                x: parent.checked ? parent.width - width - 4 : 4
                                Behavior on x { NumberAnimation { duration: 200 } }
                            }
                            MouseArea { anchors.fill: parent; preventStealing: true; onClicked: ambientSwitch.checked = !ambientSwitch.checked }
                        }
                    }

                    // 氛围灯动态色彩
                    Row {
                        width: parent.width; spacing: 16
                        Text { text: "氛围灯动态色彩"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter }
                        Item { width: parent.width - 300; height: 1 }
                        Rectangle {
                            id: dynamicColorSwitch
                            width: 70; height: 36; radius: 18
                            color: dynamicColorSwitch.checked ? "#3D5AFE" : "#21262D"
                            anchors.verticalCenter: parent.verticalCenter
                            property bool checked: false
                            Rectangle {
                                width: 28; height: 28; radius: 14; color: "white"
                                anchors.verticalCenter: parent.verticalCenter
                                x: parent.checked ? parent.width - width - 4 : 4
                                Behavior on x { NumberAnimation { duration: 200 } }
                            }
                            MouseArea { anchors.fill: parent; preventStealing: true; onClicked: dynamicColorSwitch.checked = !dynamicColorSwitch.checked }
                        }
                    }
                }

                // 抬头显示
                Column {
                    width: parent.width
                    spacing: 20

                    Text { text: "抬头显示"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }

                    // 高度调节
                    Column {
                        width: parent.width; spacing: 8
                        Text { text: "高度调节"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18 }
                        Rectangle {
                            width: parent.width; height: 19; radius: 10; color: "#21262D"
                            MouseArea {
                                anchors.fill: parent
                                preventStealing: true
                                onClicked: (mouse) => {
                                    var ratio = mouse.x / parent.width
                                    heightProgress.width = Math.max(10, Math.min(parent.width, ratio * parent.width))
                                }
                            }
                            Rectangle {
                                id: heightProgress
                                width: parent.width * 0.5; height: parent.height; radius: 10
                                gradient: Gradient {
                                    orientation: Gradient.Horizontal
                                    GradientStop { position: 0.0; color: "#0532FB" }
                                    GradientStop { position: 1.0; color: "#52E6FB" }
                                }
                            }
                        }
                    }

                    // 亮度调节
                    Column {
                        width: parent.width; spacing: 8
                        Text { text: "亮度调节"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18 }
                        Rectangle {
                            width: parent.width; height: 19; radius: 10; color: "#21262D"
                            MouseArea {
                                anchors.fill: parent
                                preventStealing: true
                                onClicked: (mouse) => {
                                    var ratio = mouse.x / parent.width
                                    brightnessProgress.width = Math.max(10, Math.min(parent.width, ratio * parent.width))
                                }
                            }
                            Rectangle {
                                id: brightnessProgress
                                width: parent.width * 0.5; height: parent.height; radius: 10
                                gradient: Gradient {
                                    orientation: Gradient.Horizontal
                                    GradientStop { position: 0.0; color: "#0532FB" }
                                    GradientStop { position: 1.0; color: "#52E6FB" }
                                }
                            }
                        }
                    }

                    // 旋转调节
                    Column {
                        width: parent.width; spacing: 8
                        Text { text: "旋转调节"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 18 }
                        Rectangle {
                            width: parent.width; height: 19; radius: 10; color: "#21262D"
                            MouseArea {
                                anchors.fill: parent
                                preventStealing: true
                                onClicked: (mouse) => {
                                    var ratio = mouse.x / parent.width
                                    rotationProgress.width = Math.max(10, Math.min(parent.width, ratio * parent.width))
                                }
                            }
                            Rectangle {
                                id: rotationProgress
                                width: parent.width * 0.5; height: parent.height; radius: 10
                                gradient: Gradient {
                                    orientation: Gradient.Horizontal
                                    GradientStop { position: 0.0; color: "#0532FB" }
                                    GradientStop { position: 1.0; color: "#52E6FB" }
                                }
                            }
                        }
                    }
                }

                // 迎宾
                Column {
                    width: parent.width; spacing: 20
                    Text { text: "迎宾"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }
                    Rectangle { width: parent.width; height: 60; radius: 12; color: "#161B22"
                        Text { anchors.centerIn: parent; text: "迎宾设置"; color: "#8B949E"; font.pixelSize: 16 }
                        MouseArea { anchors.fill: parent; onClicked: console.log("迎宾设置") }
                    }
                }

                // 智能记忆
                Column {
                    width: parent.width; spacing: 20
                    Text { text: "智能记忆"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }
                    Rectangle { width: parent.width; height: 60; radius: 12; color: "#161B22"
                        Text { anchors.centerIn: parent; text: "智能记忆设置"; color: "#8B949E"; font.pixelSize: 16 }
                        MouseArea { anchors.fill: parent; onClicked: console.log("智能记忆设置") }
                    }
                }

                // 空调
                Column {
                    width: parent.width; spacing: 20
                    Text { text: "空调"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }
                    Rectangle { width: parent.width; height: 60; radius: 12; color: "#161B22"
                        Text { anchors.centerIn: parent; text: "空调设置"; color: "#8B949E"; font.pixelSize: 16 }
                        MouseArea { anchors.fill: parent; onClicked: console.log("空调设置") }
                    }
                }

                // 门窗和锁
                Column {
                    width: parent.width; spacing: 20
                    Text { text: "门窗和锁"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }
                    Rectangle { width: parent.width; height: 60; radius: 12; color: "#161B22"
                        Text { anchors.centerIn: parent; text: "门窗和锁设置"; color: "#8B949E"; font.pixelSize: 16 }
                        MouseArea { anchors.fill: parent; onClicked: console.log("门窗和锁设置") }
                    }
                }

                // 智能提醒
                Column {
                    width: parent.width; spacing: 20
                    Text { text: "智能提醒"; color: "white"; font.family: "PingFang SC"; font.pixelSize: 28 }
                    Rectangle { width: parent.width; height: 60; radius: 12; color: "#161B22"
                        Text { anchors.centerIn: parent; text: "智能提醒设置"; color: "#8B949E"; font.pixelSize: 16 }
                        MouseArea { anchors.fill: parent; onClicked: console.log("智能提醒设置") }
                    }
                }
            }

            // 滚动条
            Rectangle {
                id: scrollBar
                anchors.right: parent.right
                width: 12
                height: 130
                radius: 6
                color: "#364A5E"
                y: flickable.visibleArea.yPosition * flickable.height
                visible: flickable.contentHeight > flickable.height
            }
        }

        // ==================== 右侧车辆信息 ====================
        Item {
            id: vehicleInfo
            width: 280
            height: parent.height
            anchors.right: parent.right

            // 已安全陪伴您 X 天
            Column {
                anchors.top: parent.top
                anchors.topMargin: 60
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8

                Text {
                    text: "已安全陪伴您"
                    color: "#9AFFFFFF"
                    font.family: "PingFang SC"
                    font.pixelSize: 16
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 4

                    Text {
                        text: "267"
                        color: "white"
                        font.family: "PingFang SC"
                        font.pixelSize: 28
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        text: "天"
                        color: "#9AFFFFFF"
                        font.family: "PingFang SC"
                        font.pixelSize: 16
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            // 里程
            Column {
                anchors.top: parent.top
                anchors.topMargin: 160
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8

                Text {
                    text: ui.vehicleMileage.toFixed(0) + " km"
                    color: "white"
                    font.family: "PingFang SC"
                    font.pixelSize: 22
                    font.weight: Font.DemiBold
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "总里程"
                    color: "#9AFFFFFF"
                    font.family: "PingFang SC"
                    font.pixelSize: 14
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: ui.vehicleRange + " km"
                    color: "white"
                    font.family: "PingFang SC"
                    font.pixelSize: 22
                    font.weight: Font.DemiBold
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "剩余续航"
                    color: "#9AFFFFFF"
                    font.family: "PingFang SC"
                    font.pixelSize: 14
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            // 车辆图片
            Image {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 80
                source: "qrc:/Images/Settings/vehicle.png"
                width: 300; height: 120
                fillMode: Image.PreserveAspectFit
            }

            // 车况
            Column {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 160
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8

                Image {
                    source: "qrc:/Images/Settings/vehicle_condition_good.png"
                    width: 120; height: 24
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "车辆状况良好"
                    color: "white"
                    font.family: "PingFang SC"
                    font.pixelSize: 14
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}
