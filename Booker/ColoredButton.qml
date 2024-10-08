import QtQuick
import Booker

Item {
    id: root

    required property string textContent
    property color buttonColorIdle: styles.blueMedium
    property color buttonColorHovered: styles.blueDefault2
    property color buttonColorPressed: styles.blueDefault
    property color textColor: styles.white
    property int contentSize: styles.h8
    property bool textBold: false
    property int buttonCooldown: 1
    property bool defaultMouseAreaEnabled: true

    signal clicked()

    width: background.width
    height: background.height

    Rectangle {
        id: background
        width: text.implicitWidth + root.contentSize * 1.8
        height: root.contentSize * 2.5
        color: mouseArea.containsPress ? root.buttonColorPressed :
                   (mouseArea.containsMouse ? root.buttonColorHovered : root.buttonColorIdle)
        radius: styles.squareButtonRoundness

        Text {
            id: text
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: root.contentSize
            text: root.textContent
            color: root.textColor
            elide: Text.ElideRight
            maximumLineCount: 1
            font.bold: root.textBold
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: background
        hoverEnabled: true
        enabled: root.defaultMouseAreaEnabled
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
