import QtQuick
import "../Components"

// 便捷中心（设计稿 1:1，坐标 = 设计稿整屏坐标 − (96, 48)）
Item {
    id: controlCenterPage
    width: parent ? parent.width : 1424
    height: parent ? parent.height : 808

    // 本页未接后端的开关/数值状态（页面常驻，状态可保留）
    property bool remotePositionOn: false
    property bool clairvoyanceOn: false
    property bool windowOn: false
    property int navVolume: 59
    property int meterBrightness: 78

    // 深色面板 + 预模糊车机截图（上滑回到主页，模拟下拉面板收起）
    Rectangle {
        x: 11; y: 0
        width: 1414; height: 808
        radius: 30
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#171E29" }
            GradientStop { position: 1.0; color: "#424D5C" }
        }
    }

    Image {
        x: 44; y: 10
        width: 1347; height: 740
        source: "qrc:/Images/ControlCenter/background.png"
        fillMode: Image.PreserveAspectCrop

        SwipeArea {
            anchors.fill: parent
            onSwipeUp: ui.controlCenterVisible = false
        }
    }

    // ==================== 列标题 ====================
    Text {
        x: 293; y: 58
        text: "Dlink快捷"
        color: "#FFFFFF"
        font.pixelSize: 24
    }

    Text {
        x: 744; y: 58
        text: "整车控制"
        color: "#FFFFFF"
        font.pixelSize: 24
    }

    // ==================== 第一行开关 (y=107) ====================
    IconSwitch {
        x: 288; y: 107
        checked: ui.wlanOn
        iconLight: "qrc:/Images/ControlCenter/wlan_on.png"
        iconDark: "qrc:/Images/ControlCenter/wlan_off.png"
        text: "无线网络"
        onToggled: (checked) => ui.wlanOn = checked
    }

    IconSwitch {
        x: 436; y: 107
        checked: ui.bluetoothOn
        iconLight: "qrc:/Images/ControlCenter/bluetooth_on.png"
        iconDark: "qrc:/Images/ControlCenter/bluetooth_off.png"
        text: "蓝牙"
        onToggled: (checked) => ui.bluetoothOn = checked
    }

    IconSwitch {
        id: themeModeSwitch
        x: 584; y: 107
        checked: ui.themeDark
        iconLight: "qrc:/Images/ControlCenter/theme_mode_on.png"
        iconDark: "qrc:/Images/ControlCenter/theme_mode_off.png"
        text: checked ? "深色模式" : "浅色模式"
        onToggled: (checked) => ui.themeDark = checked
    }

    IconSwitch {
        x: 732; y: 107
        checked: ui.hudOn
        iconText: "HUD"
        text: "抬头显示"
        onToggled: (checked) => ui.hudOn = checked
    }

    IconSwitch {
        x: 880; y: 107
        checked: ui.dynamicSuspension
        iconLight: "qrc:/Images/ControlCenter/dynamic_suspension_on.png"
        iconDark: "qrc:/Images/ControlCenter/dynamic_suspension_off.png"
        text: "动态悬架"
        onToggled: (checked) => ui.dynamicSuspension = checked
    }

    IconSwitch {
        x: 1028; y: 107
        checked: ui.ventilation
        iconLight: "qrc:/Images/ControlCenter/ventilation_on.png"
        iconDark: "qrc:/Images/ControlCenter/ventilation_off.png"
        text: "通风加热"
        onToggled: (checked) => ui.ventilation = checked
    }

    // ==================== 第二行开关 (y=254) ====================
    IconSwitch {
        x: 288; y: 254
        checked: controlCenterPage.remotePositionOn
        iconLight: "qrc:/Images/ControlCenter/romote_postion_on.png"
        iconDark: "qrc:/Images/ControlCenter/romote_postion_off.png"
        text: "远程位置"
        onToggled: (checked) => controlCenterPage.remotePositionOn = checked
    }

    IconSwitch {
        x: 436; y: 254
        checked: controlCenterPage.clairvoyanceOn
        iconLight: "qrc:/Images/ControlCenter/clairvoyance_on.png"
        iconDark: "qrc:/Images/ControlCenter/clairvoyance_off.png"
        text: "千里眼"
        onToggled: (checked) => controlCenterPage.clairvoyanceOn = checked
    }

    IconSwitch {
        x: 584; y: 254
        checked: ui.autoRotation
        iconLight: "qrc:/Images/ControlCenter/auto_rotation_on.png"
        iconDark: "qrc:/Images/ControlCenter/auto_rotation_off.png"
        text: "自动旋转"
        onToggled: (checked) => ui.autoRotation = checked
    }

    // 电除霜（与空调页共用 acDefrost）
    IconSwitch {
        x: 732; y: 254
        checked: ui.acDefrost
        iconLight: "qrc:/Images/ControlCenter/defrost_on.png"
        iconDark: "qrc:/Images/ControlCenter/defrost_off.png"
        text: "电除霜"
        onToggled: (checked) => ui.acDefrost = checked
    }

    IconSwitch {
        x: 880; y: 254
        checked: controlCenterPage.windowOn
        iconLight: "qrc:/Images/ControlCenter/window_on.png"
        iconDark: "qrc:/Images/ControlCenter/window_off.png"
        text: "天窗"
        onToggled: (checked) => controlCenterPage.windowOn = checked
    }

    IconSwitch {
        x: 1028; y: 254
        checked: ui.espOn
        iconText: "ESP"
        text: "ESP"
        onToggled: (checked) => ui.espOn = checked
    }

    // ==================== 音量 ====================
    Text {
        x: 290; y: 401
        text: "音量"
        color: "#FFFFFF"
        font.pixelSize: 24
    }

    // 媒体音量（点击图标静音）
    QuickSlider {
        x: 290; y: 448
        width: 405; height: 95
        text: "媒体音量"
        value: ui.volume
        minValue: 0
        maxValue: 100
        fillColor: "#0BC3C4"
        iconActive: ui.mute ? "qrc:/Images/ControlCenter/mute.png"
                            : "qrc:/Images/ControlCenter/volume.png"
        iconInactive: "qrc:/Images/ControlCenter/mute.png"

        onValueEdited: (newValue) => ui.volume = newValue
        onIconClicked: ui.mute = !ui.mute
    }

    // 导航音量
    QuickSlider {
        x: 290; y: 578
        width: 405; height: 95
        text: "导航音量"
        value: controlCenterPage.navVolume
        minValue: 0
        maxValue: 100
        fillColor: "#0BC3C4"
        iconActive: "qrc:/Images/ControlCenter/volume.png"
        iconInactive: "qrc:/Images/ControlCenter/mute.png"

        onValueEdited: (newValue) => controlCenterPage.navVolume = newValue
    }

    // ==================== 亮度 ====================
    Text {
        x: 743; y: 401
        text: "亮度"
        color: "#FFFFFF"
        font.pixelSize: 24
    }

    // 中控亮度
    QuickSlider {
        x: 736; y: 448
        width: 405; height: 95
        text: "中控亮度"
        subText: "自动"
        value: ui.brightness
        minValue: 0
        maxValue: 100
        fillColor: "#3874F2"
        iconActive: "qrc:/Images/ControlCenter/brightness.png"
        iconInactive: "qrc:/Images/ControlCenter/brightness_off.png"

        onValueEdited: (newValue) => ui.brightness = newValue
    }

    // 仪表亮度
    QuickSlider {
        x: 736; y: 578
        width: 405; height: 95
        text: "仪表亮度"
        subText: "手动"
        value: controlCenterPage.meterBrightness
        minValue: 0
        maxValue: 100
        fillColor: "#3874F2"
        iconActive: "qrc:/Images/ControlCenter/brightness.png"
        iconInactive: "qrc:/Images/ControlCenter/brightness_off.png"

        onValueEdited: (newValue) => controlCenterPage.meterBrightness = newValue
    }

    // 底部指示条
    Rectangle {
        x: 654; y: 763
        width: 127; height: 5
        radius: height / 2
        color: "#CDFFFFFF"
    }
}
