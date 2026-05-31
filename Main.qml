import QtQuick
import QtQuick.Controls

import "./HMI"

Window {
    width: 1520
    height: 856
    visible: true
    title: qsTr("CID -By: ShaoqiLiang")

    //界面索引
    property int pageIndex: ui.pageIndex
    property int previousPageIndex: 0

    Component.onCompleted: {
        pageLoader.source = ui.PAGE_HOME
    }
    Loader {
        id:pageLoader
        anchors.fill: parent
    }

    //切换界面
    onPageIndexChanged: {
        switch(pageIndex){
        case ui.PAGE_HOME:pageLoader.source = "HMI/Home.qml"
            break;
        case ui.PAGE_AC:pageLoader.source = "HMI/AC.qml"
            break;
        case ui.PAGE_APP:pageLoader.source = "HMI/App.qml"
            break;
        case ui.PAGE_SETTINGS:pageLoader.source = "HMI/Settings.qml"
            break;
        case ui.PAGE_CONTROL:pageLoader.source = "HMI/ControlCenter.qml"
            break;
        default:
            pageLoader.source = "HMI/Home.qml"
            break;
        }
    }

    //背景
    Image {
        id: backgroungImage
        anchors.fill: parent
        source: "qrc:/Images/Home/base.png"
        // fillMode: Image.PreserveAspectCrop

    }

}
