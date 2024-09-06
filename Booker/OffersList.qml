import QtQuick
import Booker
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Page {
    id: root

    property QtObject modelData: null
    property StackView stackViewRef: null

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

        anchors {
            top: parent.top
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        width: styles.pageWidthContent
        height: contentHeight
        //clip: true
        model: root.modelData
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
            height: previewImage.height


            // Rectangle { color: styles.redDefault; anchors.fill: parent }
            Image {
                id: previewImage
                source: element.elementPreviewImageSource
                fillMode: Image.PreserveAspectCrop
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.horizontalCenter
                }

                height: 400
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: ShaderEffectSource {
                        sourceItem: Rectangle {
                            width: previewImage.width
                            height: previewImage.height
                            radius: 15
                        }
                    }
                }
            }

            Item {
                id: additionalInfo
                anchors {
                    top: parent.top
                    left: previewImage.right
                    right: parent.right
                    bottom: previewImage.bottom
                }

                Rectangle { color: styles.greenLight; anchors.fill: parent }
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
    }

    AppStyle { id: styles }
}
