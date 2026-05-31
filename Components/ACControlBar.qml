import QtQuick
import QtQuick.Controls

// 空调底部控制栏
Item {
    id: root

    // 按钮定义
    property var buttons: [
        { icon: "qrc:/Images/ACBar/model.png",     label: "模式",     width: 72 },
        { icon: "qrc:/Images/ACBar/fan.png",        label: "风量",     width: 72 },
        { icon: "qrc:/Images/ACBar/arrow_up.png",   label: "左温+",    width: 50, type: "leftUp" },
        { icon: "",                                  label: "左温",     width: 80, type: "leftTemp" },
        { icon: "qrc:/Images/ACBar/arrow_down.png", label: "左温-",    width: 50, type: "leftDown" },
        { icon: "qrc:/Images/ACBar/blow.png",       label: "吹风",     width: 82, type: "blow" },
        { icon: "qrc:/Images/ACBar/arrow_up.png",   label: "右温+",    width: 50, type: "rightUp" },
        { icon: "",                                  label: "右温",     width: 80, type: "rightTemp" },
        { icon: "qrc:/Images/ACBar/arrow_down.png", label: "右温-",    width: 50, type: "rightDown" },
        { icon: "qrc:/Images/ACBar/defrost.png",    label: "除霜",     width: 72 },
        { icon: "qrc:/Images/ACBar/contact.png",    label: "同步",     width: 72 }
    ]

    signal modeClicked()
    signal fanClicked()
    signal blowClicked()
    signal defrostClicked()
    signal contactClicked()

    // 背景
    Image {
        anchors.fill: parent
        source: "qrc:/Images/Home/ac_background.png"
        fillMode: Image.PreserveAspectFit
    }

    Row {
        anchors.fill: parent
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        spacing: 0

        // 模式
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/model.png"
            label: "模式"
            buttonSize: 72
            iconSize: 48
            height: parent.height
            onClicked: root.modeClicked()
        }

        // 风量
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/fan.png"
            label: "风量"
            buttonSize: 72
            iconSize: 35
            height: parent.height
            onClicked: root.fanClicked()
        }

        // 左温度加
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/arrow_up.png"
            buttonSize: 50
            iconSize: 30
            height: parent.height
            enabled: ui.acLeftTemp < 32
            onClicked: {
                if (ui.acLeftTemp < 32) ui.acLeftTemp++
            }
        }

        // 左温度显示
        Item {
            width: 80
            height: parent.height

            Row {
                anchors.centerIn: parent

                Text {
                    text: Math.round(ui.acLeftTemp)
                    color: "white"
                    font.pixelSize: 46
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    text: "°"
                    color: "#9AFFFFFF"
                    font.pixelSize: 46
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // 左温度减
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/arrow_down.png"
            buttonSize: 50
            iconSize: 30
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

            Rectangle {
                width: 82; height: 82
                anchors.centerIn: parent
                radius: 41
                color: blowMouse.pressed ? "#40FFFFFF" : "transparent"

                Image {
                    anchors.centerIn: parent
                    source: "qrc:/Images/ACBar/blow.png"
                    width: 60; height: 60
                    opacity: blowMouse.pressed ? 0.6 : 1.0
                }

                MouseArea {
                    id: blowMouse
                    anchors.fill: parent
                    onClicked: root.blowClicked()
                }
            }
        }

        // 右温度加
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/arrow_up.png"
            buttonSize: 50
            iconSize: 30
            height: parent.height
            enabled: ui.acRightTemp < 32
            onClicked: {
                if (ui.acRightTemp < 32) ui.acRightTemp++
            }
        }

        // 右温度显示
        Item {
            width: 80
            height: parent.height

            Row {
                anchors.centerIn: parent

                Text {
                    text: Math.round(ui.acRightTemp)
                    color: "white"
                    font.pixelSize: 46
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    text: "°"
                    color: "#9AFFFFFF"
                    font.pixelSize: 46
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // 右温度减
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/arrow_down.png"
            buttonSize: 50
            iconSize: 30
            height: parent.height
            enabled: ui.acRightTemp > 16
            onClicked: {
                if (ui.acRightTemp > 16) ui.acRightTemp--
            }
        }

        // 除霜
        ACBarButton {
            iconSource: "qrc:/Images/ACBar/defrost.png"
            label: "除霜"
            buttonSize: 72
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
            label: "同步"
            buttonSize: 72
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
        property string label: ""
        property int buttonSize: 72
        property int iconSize: 48
        property bool enabled: true

        signal clicked()

        width: buttonSize

        Button {
            width: parent.buttonSize
            height: parent.buttonSize
            anchors.centerIn: parent
            hoverEnabled: false
            enabled: parent.enabled

            background: Image {
                width: parent.parent.iconSize
                height: parent.parent.iconSize
                anchors.centerIn: parent
                source: parent.parent.parent.iconSource
                fillMode: Image.PreserveAspectFit
                opacity: parent.enabled ? (parent.down ? 0.6 : 1.0) : 0.3
            }

            onClicked: parent.clicked()
        }

        Text {
            visible: parent.label !== ""
            text: parent.label
            color: "white"
            font.pixelSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
        }
    }
}
