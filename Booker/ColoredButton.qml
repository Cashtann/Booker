import QtQuick
import Booker

Item {
    id: root

    required property string textContent
    property color buttonColorIdle: styles.blueDefault
    property color buttonColorHovered: styles.blueDarker
    property color buttonColorPressed: styles.blueDarker
    property color textColor: styles.white
    property int contentSize: styles.h8

    signal clicked()

    Rectangle {
        id: background
        width: text.implicitWidth + 50
        height: root.contentSize * 1.3
        color: mouseArea.containsPress ? root.buttonColorPressed :
                   (mouseArea.containsMouse ? root.buttonColorHovered : root.buttonColorIdle)

        Text {
            id: text
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: root.textContent
            color: root.textColor
            elide: Text.ElideRight
            maximumLineCount: 1
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: background
        hoverEnabled: true
        onClicked: root.clicked()
    }

    AppStyle { id: styles }
}
