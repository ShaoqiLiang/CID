import QtQuick
import QtQuick.Controls

import "./HMI"
import "./Components"

Window {
    width: 1520
    height: 856
    visible: true
    title: qsTr("CID -By: ShaoqiLiang")

    // 界面索引
    property int pageIndex: ui.pageIndex
    property int previousPageIndex: 0

    // 背景
    Image {
        anchors.fill: parent
        source: "qrc:/Images/Home/base.png"
    }

    // 主布局
    Column {
        anchors.fill: parent

        // 顶部状态栏
        StatusBar {
            id: statusBar
            width: parent.width
            height: 48
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

                Loader {
                    id: pageLoader
                    anchors.fill: parent
                }
            }
        }
    }

    // 页面切换
    onPageIndexChanged: {
        switch(pageIndex) {
        case ui.PAGE_HOME:
            pageLoader.source = "HMI/Home.qml"
            break;
        case ui.PAGE_AC:
            pageLoader.source = "HMI/AC.qml"
            break;
        case ui.PAGE_APP:
            pageLoader.source = "HMI/App.qml"
            break;
        case ui.PAGE_SETTINGS:
            pageLoader.source = "HMI/Settings.qml"
            break;
        case ui.PAGE_CONTROL:
            pageLoader.source = "HMI/ControlCenter.qml"
            break;
        default:
            pageLoader.source = "HMI/Home.qml"
            break;
        }
    }

    Component.onCompleted: {
        pageLoader.source = "HMI/Home.qml"
    }
}
