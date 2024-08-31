import QtQuick
import Qt5Compat.GraphicalEffects
import Booker

Item {
    id: root

    required property color imageColor
    required property url imageSource

    implicitWidth: 50
    implicitHeight: 50

    Image {
        id: img

        source: root.imageSource

        fillMode: Image.PreserveAspectFit
        anchors {
            fill: parent
        }
    }

    ColorOverlay {
        anchors.fill: img
        source: img
        color: root.imageColor
    }
}


