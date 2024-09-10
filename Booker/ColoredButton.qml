import QtQuick
import Booker

Item {
    id: root

    required property string textContent
    property color buttonColorIdle: styles.blueDefault
    property color buttonColorHovered: styles.blueDarker
    property color buttonColorPressed: styles.blueDarker
    property color textColor: styles.white
    property int contentSize: styles.h6
    property bool textBold: false

    signal clicked()

    Rectangle {
        id: background
        width: text.implicitWidth + root.contentSize
        height: root.contentSize * 1.8
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
        onClicked: root.clicked()
    }

    AppStyle { id: styles }
}
