import QtQuick
import Booker
//import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Controls
import app.Manager

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

    Item {
        id: itemsContainer
        anchors {
            top: parent.top
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        width: styles.pageWidthContent
        height: description.height + previewImage.height + 200

        Text {
            anchors {
                centerIn: previewImage
                fill: previewImage
                margins: 20
            }
            font.pixelSize: styles.h7
            text: "Loading..."
            color: styles.black
        }

        Image {
            id: previewImage
            source: modelData.elementPreviewImageSource
            Component.onCompleted: {
                previewImage.source = modelData.elementPreviewImageSource
            }
            height: 400
            asynchronous: true
            anchors {
                top: parent.top
                left: parent.left
                right: parent.horizontalCenter
            }
            fillMode: Image.PreserveAspectCrop

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: ShaderEffectSource {
                    sourceItem: Rectangle {
                        width: previewImage.width
                        height: previewImage.height
                        radius: styles.imageRoundness
                    }
                }
            }
        }

        Text {
            id: description

            font.pixelSize: styles.h7
            color: styles.black
            anchors {
                top: previewImage.bottom
                left: parent.left
                right: parent.right
                topMargin: 50
            }

            //text: modelData.elementDescription
            text: modelData === null ? "Loading..." : modelData.elementDescription
            Component.onCompleted: {
                description.text = modelData.elementDescription
            }

            wrapMode: Text.WrapAtWordBoundaryOrAnywhere

        }
    }

    AppStyle { id: styles }
}
