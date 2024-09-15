import QtQuick
import Qt5Compat.GraphicalEffects
import Booker

Item {
    id: root

    property color imageColorIdle: styles.white
    property color imageColorHovered: styles.white
    property color imageColorPressed: styles.white
    property color buttonColorIdle: styles.blueMedium
    property color buttonColorHovered: styles.blueDefault2
    property color buttonColorPressed: styles.blueDefault
    property int imgWidth: 50
    property int buttonCooldown: 1
    required property url imageSource

    signal clicked()

    implicitWidth: 100
    implicitHeight: 100

    Rectangle {
        id: background
        anchors.fill: parent
        color: mouseArea.containsPress ? root.buttonColorPressed :
                   (mouseArea.containsMouse ? root.buttonColorHovered : root.buttonColorIdle)
        radius: styles.squareButtonRoundness
        Image {
            id: img
            width: root.imgWidth
            source: root.imageSource

            fillMode: Image.PreserveAspectFit
            anchors {
                centerIn: background
            }
        }
        ColorOverlay {
            anchors.fill: img
            source: img
            //color: root.imageColor
            color: mouseArea.containsPress ? root.imageColorPressed :
                       (mouseArea.containsMouse ? root.imageColorHovered : root.imageColorIdle)
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: background
        hoverEnabled: true
        onClicked: {
            root.clicked()
            mouseArea.enabled = false
            cooldownTimer.start()
        }
    }

    Timer {
        id: cooldownTimer
        interval: root.buttonCooldown
        running: false
        repeat: false
        onTriggered: {
            mouseArea.enabled = true
        }
    }

    AppStyle { id: styles }
}
