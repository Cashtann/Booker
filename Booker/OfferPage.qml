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

        Item {
            id: imgRightSide
            anchors {
                left: previewImage.right
                top: previewImage.top
                bottom: previewImage.bottom
                right: parent.right
                margins: 20
            }

            Text {
                id: textName
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                font.pixelSize: styles.h6
                elide: Text.ElideRight
                font.bold: true
                color: styles.black

                // text: element.elementName
                text: modelData === null ? "Loading..." : modelData.elementName
                Component.onCompleted: {
                    textName.text = modelData.elementName
                }

                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }

            IconText {
                id: textLocation
                anchors {
                    top: textName.bottom
                    left: parent.left
                }
                heightMultiplier: 2.5

                contentSize: styles.h8
                textColor: styles.black
                iconColor: styles.blueDefault
                imageSource: "qrc:/res/assets/icons/icon_gps.svg"

                //text: "Location: " + element.elementLocation
                textContent: modelData === null ? "Loading..." : "Location: " + modelData.elementLocation
                Component.onCompleted: {
                    textLocation.textContent = "Location: " + modelData.elementLocation
                }
            }

            IconText {
                id: textPrice
                anchors {
                    top: textLocation.bottom
                    left: parent.left
                    right: parent.right
                }
                heightMultiplier: 2.5

                contentSize: styles.h8
                textColor: styles.black
                iconColor: styles.greenMedium
                imageSource: "qrc:/res/assets/icons/icon_dollar.svg"

                //text: "Location: " + element.elementLocation
                textContent: modelData === null ? "Loading..." : "Price per night: " + modelData.elementPrice.toFixed(2) + "$"
                Component.onCompleted: {
                    textPrice.textContent = "Price per night: " + modelData.elementPrice.toFixed(2) + "$"
                }
            }

            StarRating {
                id: starRating
                textContent: "Rating: " + modelData.elementAverageRating.toFixed(2) + " "
                Component.onCompleted: {
                    starRating.textContent = "Rating: " + modelData.elementAverageRating.toFixed(2) + " "
                }
                rating: modelData.elementAverageRating
                anchors {
                    top: textPrice.bottom
                    left: parent.left
                    right: parent.right
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
