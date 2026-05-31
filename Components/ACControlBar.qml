import QtQuick
import QtQuick.Controls

// 空调底部控制栏
// Figma: 1305×123, 背景 #222A3B, 温度 Montserrat 46px #FFFFFF
Item {
    id: root

    signal modeClicked()
    signal fanClicked()
    signal blowClicked()
    signal defrostClicked()
    signal contactClicked()

    // 背景 - 纯色替代图片
    Rectangle {
        anchors.fill: parent
        color: "#222A3B"
        radius: 8
    }

    Row {
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 0

        // 模式
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/model.png"
            iconSize: 48
            height: parent.height
            onClicked: root.modeClicked()
        }

        // 风扇
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/fan.png"
            iconSize: 35
            height: parent.height
            onClicked: root.fanClicked()
        }

        // 左温度加
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/arrow_up.png"
            iconSize: 30
            btnWidth: 50
            height: parent.height
            enabled: ui.acLeftTemp < 32
            onClicked: {
                if (ui.acLeftTemp < 32) ui.acLeftTemp++
            }
        }

        // 左温度显示
        Item {
            width: 150
            height: parent.height

            Row {
                anchors.centerIn: parent

                Text {
                    text: Math.round(ui.acLeftTemp)
                    color: "white"
                    font.family: "Montserrat"
                    font.pixelSize: 46
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    text: "º"
                    color: "#9AFFFFFF"
                    font.family: "Montserrat"
                    font.pixelSize: 46
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // 左温度减
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/arrow_down.png"
            iconSize: 30
            btnWidth: 50
            height: parent.height
            enabled: ui.acLeftTemp > 16
            onClicked: {
                if (ui.acLeftTemp > 16) ui.acLeftTemp--
            }
        }

        // 吹风（中间大按钮）
        Item {
            width: 100
            height: parent.height

            Image {
                anchors.centerIn: parent
                source: "qrc:/Images/ACBar/blow.png"
                width: 82; height: 82
                opacity: blowMouse.pressed ? 0.6 : 1.0
            }

            MouseArea {
                id: blowMouse
                anchors.fill: parent
                onClicked: root.blowClicked()
            }
        }

        // 右温度加
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/arrow_up.png"
            iconSize: 30
            btnWidth: 50
            height: parent.height
            enabled: ui.acRightTemp < 32
            onClicked: {
                if (ui.acRightTemp < 32) ui.acRightTemp++
            }
        }

        // 右温度显示
        Item {
            width: 150
            height: parent.height

            Row {
                anchors.centerIn: parent

                Text {
                    text: Math.round(ui.acRightTemp)
                    color: "white"
                    font.family: "Montserrat"
                    font.pixelSize: 46
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    text: "º"
                    color: "#9AFFFFFF"
                    font.family: "Montserrat"
                    font.pixelSize: 46
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // 右温度减
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/arrow_down.png"
            iconSize: 30
            btnWidth: 50
            height: parent.height
            enabled: ui.acRightTemp > 16
            onClicked: {
                if (ui.acRightTemp > 16) ui.acRightTemp--
            }
        }

        // 除霜
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/defrost.png"
            iconSize: 48
            height: parent.height
            onClicked: {
                ui.acDefrost = !ui.acDefrost
                root.defrostClicked()
            }
        }

        // 同步
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/contact.png"
            iconSize: 42
            height: parent.height
            onClicked: {
                ui.acRightTemp = ui.acLeftTemp
                root.contactClicked()
            }
        }
    }

    // 内部按钮组件
    component ACBarButton: Item {
        property string iconSource: ""
        property int iconSize: 48
        property int btnWidth: 72
        property bool enabled: true

        signal clicked()

        width: btnWidth

        Rectangle {
            width: parent.btnWidth
            height: parent.btnWidth
            anchors.centerIn: parent
            radius: width / 2
            color: btnMouse.pressed ? "#40FFFFFF" : "transparent"
            visible: parent.enabled

            Image {
                anchors.centerIn: parent
                source: parent.parent.iconSource
                width: parent.parent.iconSize
                height: parent.parent.iconSize
                opacity: btnMouse.pressed ? 0.6 : 1.0
            }

            MouseArea {
                id: btnMouse
                anchors.fill: parent
                onClicked: parent.parent.clicked()
            }
        }

        // 禁用态
        Image {
            visible: !parent.enabled
            anchors.centerIn: parent
            source: parent.iconSource
            width: parent.iconSize
            height: parent.iconSize
            opacity: 0.3
        }
    }
}
