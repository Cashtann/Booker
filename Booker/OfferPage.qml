import QtQuick
import Booker
//import QtQuick.Layouts
import QtQuick.Controls

Page {
    id: root

    required property QtObject modelData

    height: itemsContainer.height + 200
    Rectangle {
        id: background
        width: root.width
        height: root.height
        color: styles.mainBackground
    }
    Item {
        id: itemsContainer
        anchors {
            top: parent.top
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        width: styles.pageWidthContent

        Text {
            id: description
            width: parent.width / 2
            height: parent.height

            font.pixelSize: styles.h7
            color: styles.black

            text: modelData.locationDescription

            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }
    }


    AppStyle { id: styles }
}
