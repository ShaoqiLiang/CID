import QtQuick

// 温度滚轮选择器
// Figma: 272×511, 字体 PingFang SC 500
// 选中 38px #04FAFB, 偏移1: 36px #DFDFDF 0.6, 偏移2: 28px 0.5, 偏移3+: 22px 0.3
Item {
    id: root

    property real temperature: 24
    property int minTemp: 16
    property int maxTemp: 32
    property string currentTextColor: "#04FAFB"
    property string otherTextColor: "#DFDFDF"
    property int direction: 0   // 0-左对齐  1-右对齐

    readonly property var temperatureText: ["32°", "31°", "30°", "29°", "28°", "27°", "26°", "25°", "24°",
                                            "23°", "22°", "21°", "20°", "19°", "18°", "17°", "16°"]

    ListView {
        id: listView
        anchors.fill: parent
        clip: true
        spacing: 10
        model: 17

        preferredHighlightBegin: height / 2 - 32
        preferredHighlightEnd: height / 2 + 32
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration: 0
        flickDeceleration: 5000
        maximumFlickVelocity: 2500

        Component.onCompleted: {
            var idx = getIndex(root.temperature)
            positionViewAtIndex(idx < 0 ? 0 : idx, ListView.Center)
        }

        delegate: Item {
            width: listView.width
            height: 59

            Text {
                id: tempLabel
                text: getTemperature()
                color: getColor()
                font.family: "PingFang SC"
                font.weight: Font.Medium
                font.pixelSize: getFontSize()
                width: parent.width
                height: parent.height
                topPadding: 5
                leftPadding: (root.direction === 1) ? getPadding() : leftPadding
                rightPadding: (root.direction === 0) ? getPadding() : rightPadding
                horizontalAlignment: (root.direction === 0) ? Text.AlignRight : Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                opacity: getOpacity()

                function getOpacity() {
                    if (ListView.isCurrentItem) return 1.0
                    var offset = Math.abs(listView.currentIndex - index)
                    switch(offset) {
                        case 1: return 0.6
                        case 2: return 0.5
                        default: return 0.3
                    }
                }

                function getPadding() {
                    if (ListView.isCurrentItem) return 50
                    var offset = Math.abs(listView.currentIndex - index)
                    switch(offset) {
                        case 1: return 35
                        case 2: return 25
                        default: return 5
                    }
                }

                function getFontSize() {
                    if (ListView.isCurrentItem) return 38
                    var offset = Math.abs(listView.currentIndex - index)
                    switch(offset) {
                        case 1: return 36
                        case 2: return 28
                        default: return 22
                    }
                }

                function getTemperature() {
                    return root.temperatureText[index]
                }

                function getColor() {
                    return ListView.isCurrentItem ? root.currentTextColor :
                           (listView.moving ? Qt.rgba(0.87, 0.87, 0.87, 0.5) : root.otherTextColor)
                }
            }
        }

        onMovementEnded: {
            var temp = getTempFromIndex(currentIndex)
            root.temperature = temp
        }
    }

    function getTempFromIndex(index) {
        if (index <= 0) return maxTemp
        if (index >= 16) return minTemp
        return maxTemp - index
    }

    function getIndex(temp) {
        if (temp >= maxTemp) return 0
        if (temp <= minTemp) return 16
        return maxTemp - temp
    }

    onTemperatureChanged: {
        listView.currentIndex = getIndex(temperature)
    }
}
