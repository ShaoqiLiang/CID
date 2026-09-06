import QtQuick

// 滑动手势区域：按下后按位移主方向，在抬手时发出一次方向信号
MouseArea {
    id: root

    property int threshold: 30
    property point origin

    signal swipeUp()
    signal swipeDown()
    signal swipeLeft()
    signal swipeRight()

    acceptedButtons: Qt.LeftButton

    onPressed: (mouse) => origin = Qt.point(mouse.x, mouse.y)

    onReleased: (mouse) => {
        var dx = mouse.x - origin.x
        var dy = mouse.y - origin.y
        if (Math.abs(dx) < root.threshold && Math.abs(dy) < root.threshold) return
        if (Math.abs(dx) > Math.abs(dy)) {
            if (dx > 0) root.swipeRight()
            else root.swipeLeft()
        } else {
            if (dy > 0) root.swipeDown()
            else root.swipeUp()
        }
    }
}
