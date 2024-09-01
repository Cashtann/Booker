import QtQuick
import Qt5Compat.GraphicalEffects
import Booker

Item {
    id: root

    required property url imageSource
    required property color imageColor
    required property color backgroundColor
    required property int imageWidth
    property color shadowColor: styles.grey
    property int shadowSize: 12

    signal clicked()

    Rectangle {
        id: background

        anchors.fill: parent
        color: backgroundColor
        radius: width / 2

        ColoredIcon {
            width: root.imageWidth
            imageColor: root.imageColor
            imageSource: root.imageSource
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: background
        hoverEnabled: true
        onClicked: {
            root.clicked()
        }
    }

    DropShadow {
        anchors.fill: source
        cached: true
        horizontalOffset: 0
        verticalOffset: 0
        radius: root.shadowSize
        samples: 16
        color: root.shadowColor
        source: background
    }
    AppStyle { id: styles }
}


