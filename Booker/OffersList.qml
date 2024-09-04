import QtQuick
import Booker
import QtQuick.Controls

Page {
    id: root

    required property QtObject modelData
    required property StackView stackViewRef

    height: itemsContainer.height + 200

    Rectangle {
        id: background
        width: root.width
        height: root.height
        color: styles.mainBackground
    }

    ListView {
        id: itemsContainer

        interactive: false
        boundsBehavior: Flickable.StopAtBounds

        //Rectangle { color: styles.yellowDefault; anchors.fill: parent }
        anchors {
            top: parent.top
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        width: styles.pageWidthContent
        height: 5000
        //clip: true
        model: modelData
        spacing: 100

        delegate: Item {
            id: element

            required property string elementName
            required property string elementHeader
            required property string elementLocation
            required property string elementDescription
            required property real elementPrice
            required property real elementAverageRating
            required property url elementPreviewImageSource

            anchors {
                left: parent.left
                right: parent.right
            }

            width: styles.previewOfferWidth
            height: 500
            //Rectangle { color: styles.redDefault; anchors.fill: parent }
            Image {
                id: previewImage
                source: element.elementPreviewImageSource
                width: 100
                height: 100
            }
            // Rectangle {
            //     color: styles.redDefault
            //     width: 100
            //     height: 100
            // }
            Text {
                id: description
                width: parent.width / 2
                height: parent.height

                font.pixelSize: styles.h7
                color: styles.black

                text: element.elementName

                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }
        }
    }

    AppStyle { id: styles }
}
