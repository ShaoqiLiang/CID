import QtQuick
import QtQuick.Shapes
import Qt5Compat.GraphicalEffects

// 模糊光晕椭圆（对应设计稿带 Layer blur 的 Ellipse 节点：真椭圆 + 填充透明度 + 高斯模糊）
Item {
    id: root

    property color glowColor: "#48909E"
    property int blurRadius: 28
    property real fillOpacity: 1.0   // 填充不透明度（设计稿 Fill 面板的 %）

    Shape {
        id: sourceEll
        anchors.fill: parent
        opacity: root.fillOpacity

        ShapePath {
            strokeWidth: -1
            fillColor: root.glowColor
            startX: root.width / 2; startY: 0
            PathArc { x: root.width / 2; y: root.height; radiusX: root.width / 2; radiusY: root.height / 2 }
            PathArc { x: root.width / 2; y: 0; radiusX: root.width / 2; radiusY: root.height / 2 }
        }
    }

    GaussianBlur {
        anchors.fill: sourceEll
        source: sourceEll
        radius: root.blurRadius
        samples: 49
    }
}
