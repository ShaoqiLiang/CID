import QtQuick

import "./HMI"
import "./Components"

Window {
    id: window
    width: 1520
    height: 856
    visible: true
    color: "#0B0C11"
    title: qsTr("CID -By: ShaoqiLiang")

    // 设计画布：固定 1520×856，等比缩放居中适配窗口（任何窗口尺寸/DPI 下与 Figma 比例一致）
    Item {
        id: surface
        width: 1520; height: 856
        scale: Math.min(window.width / 1520, window.height / 856)
        transformOrigin: Item.TopLeft
        x: (window.width - width * scale) / 2
        y: (window.height - height * scale) / 2

    // 界面索引
    property int pageIndex: ui.pageIndex

    // 背景
    Image {
        anchors.fill: parent
        source: "qrc:/Images/Home/base.png"
    }

    // 预定义页面组件
    Component {
        id: homePage
        Home {}
    }
    Component {
        id: acPage
        AC {}
    }
    Component {
        id: appPage
        App {}
    }
    Component {
        id: settingsPage
        Settings {}
    }
    Component {
        id: controlPage
        ControlCenter {}
    }
    Component {
        id: mapPage
        Map {}
    }
    Component {
        id: musicPage
        MusicList {}
    }
    Component {
        id: naviPage
        MapNavi {}
    }
    Component {
        id: clusterPage
        Cluster {}
    }
    Component {
        id: secondaryPage
        Secondary {}
    }
    Component {
        id: secondaryAppsPage
        SecondaryApps {}
    }

    // 主布局
    Column {
        anchors.fill: parent

        // 顶部状态栏（设计稿：地图/导航页状态栏隐藏，沉浸式）
        StatusBar {
            id: statusBar
            width: parent.width
            height: 48
            visible: ui.pageIndex !== ui.PAGE_MAP && ui.pageIndex !== ui.PAGE_NAVI
        }

        // 下方区域
        Row {
            width: parent.width
            height: parent.height - statusBar.height

            // 左侧导航栏
            LeftNav {
                id: leftNav
                width: 96
                height: parent.height
            }

            // 右侧内容区
            Item {
                width: parent.width - leftNav.width
                height: parent.height

                // 五个页面常驻，切换仅改可见性，页面状态得以保留
                Loader {
                    anchors.fill: parent
                    sourceComponent: homePage
                    visible: ui.pageIndex === ui.PAGE_HOME
                    opacity: visible ? 1.0 : 0.0
                    Behavior on opacity { NumberAnimation { duration: 200 } }
                }
                Loader {
                    anchors.fill: parent
                    sourceComponent: acPage
                    visible: ui.pageIndex === ui.PAGE_AC
                    opacity: visible ? 1.0 : 0.0
                    Behavior on opacity { NumberAnimation { duration: 200 } }
                }
                Loader {
                    anchors.fill: parent
                    sourceComponent: appPage
                    visible: ui.pageIndex === ui.PAGE_APP
                    opacity: visible ? 1.0 : 0.0
                    Behavior on opacity { NumberAnimation { duration: 200 } }
                }
                Loader {
                    anchors.fill: parent
                    sourceComponent: settingsPage
                    visible: ui.pageIndex === ui.PAGE_SETTINGS
                    opacity: visible ? 1.0 : 0.0
                    Behavior on opacity { NumberAnimation { duration: 200 } }
                }
                // 地图 / 音乐 / 导航（1424×808 内 1:1）
                Loader {
                    anchors.fill: parent
                    sourceComponent: mapPage
                    visible: ui.pageIndex === ui.PAGE_MAP
                    opacity: visible ? 1.0 : 0.0
                    Behavior on opacity { NumberAnimation { duration: 200 } }
                }
                Loader {
                    anchors.fill: parent
                    sourceComponent: musicPage
                    visible: ui.pageIndex === ui.PAGE_MUSIC
                    opacity: visible ? 1.0 : 0.0
                    Behavior on opacity { NumberAnimation { duration: 200 } }
                }
                Loader {
                    anchors.fill: parent
                    sourceComponent: naviPage
                    visible: ui.pageIndex === ui.PAGE_NAVI
                    opacity: visible ? 1.0 : 0.0
                    Behavior on opacity { NumberAnimation { duration: 200 } }
                }
                // 仪表 1520×648 / 副屏 1521×570：等比缩放适配内容区
                Loader {
                    anchors.centerIn: parent
                    width: 1520; height: 648
                    scale: Math.min(parent.width / 1520, parent.height / 648)
                    visible: ui.pageIndex === ui.PAGE_CLUSTER
                    opacity: visible ? 1.0 : 0.0
                    Behavior on opacity { NumberAnimation { duration: 200 } }
                    sourceComponent: clusterPage
                }
                Loader {
                    anchors.centerIn: parent
                    width: 1521; height: 570
                    scale: Math.min(parent.width / 1521, parent.height / 570)
                    visible: ui.pageIndex === ui.PAGE_SECONDARY
                    opacity: visible ? 1.0 : 0.0
                    Behavior on opacity { NumberAnimation { duration: 200 } }
                    sourceComponent: secondaryPage
                }
                Loader {
                    anchors.centerIn: parent
                    width: 1521; height: 570
                    scale: Math.min(parent.width / 1521, parent.height / 570)
                    visible: ui.pageIndex === ui.PAGE_SECONDARY_APPS
                    opacity: visible ? 1.0 : 0.0
                    Behavior on opacity { NumberAnimation { duration: 200 } }
                    sourceComponent: secondaryAppsPage
                }

                // 便捷中心：下拉遮罩层（不属于页面栈；状态栏下拉打开，上滑关闭）
                ControlCenter {
                    anchors.fill: parent
                    z: 50
                    visible: opacity > 0
                    opacity: ui.controlCenterVisible ? 1.0 : 0.0
                    y: ui.controlCenterVisible ? 0 : -height
                    Behavior on y { NumberAnimation { duration: 250; easing.type: Easing.OutQuad } }
                    Behavior on opacity { NumberAnimation { duration: 200 } }
                }
            }
        }
    }
}
}
