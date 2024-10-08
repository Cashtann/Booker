import QtQuick
import Booker
//import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Controls
import app.Manager
import app.CartController

Page {
    id: root

    required property QtObject modelData//: null
    required property StackView stackViewRef

    property string elementName
    property string elementHeader
    property string elementDescription
    property string elementLocation
    property url elementPreviewImageSource
    property real elementPrice
    //property QtObject shouldBeLoadedData

    property bool loaded: false

    Component.onCompleted: {
        elementName = modelData.elementName
        elementHeader = modelData.elementHeader
        elementDescription = modelData.elementHeader
        elementLocation = modelData.elementLocation
        elementPreviewImageSource = modelData.elementPreviewImageSource
        elementPrice = modelData.elementPrice
        //shouldBeLoadedData = modelData
        loaded = modelData !== null
        //console.log(shouldBeLoadedData)
    }

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

        MouseArea {
            id: inputCatcher
            //anchors.fill: itemsContainer
            width: itemsContainer.width + 10000
            height: itemsContainer.height + 10000
            x: -5000
            y: -50

            //Rectangle { anchors.fill: parent; color: styles.redDefault }

            onClicked: {
                inputCatcher.focus = true
            }
        }

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
                textContent: modelData === null ? "Loading..." : "Price per night: $" + modelData.elementPrice.toFixed(2)
                Component.onCompleted: {
                    textPrice.textContent = "Price per night: $" + modelData.elementPrice.toFixed(2)
                }
            }

            StarRating {
                id: starRating
                textContent: "Rating: " + modelData.elementAverageRating.toFixed(2) + " "
                Component.onCompleted: {
                    starRating.textContent = "Rating: " + modelData.elementAverageRating.toFixed(2) + " "
                    //console.log(modelData)
                }
                rating: modelData.elementAverageRating
                anchors {
                    top: textPrice.bottom
                    left: parent.left
                    right: parent.right
                }
            }

            Rectangle {
                id: buyContainer
                color: styles.yellowDefault
                radius: styles.squareButtonRoundness
                property int childrenSpacing: 4
                height: buyButton.height + 2 * childrenSpacing
                width: buyButton.width + inputField.width + 3 * childrenSpacing
                anchors {
                    top: starRating.bottom
                    left: parent.left
                    topMargin: 10
                }

                Rectangle {
                    id: buyButton
                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                        leftMargin: buyContainer.childrenSpacing
                    }
                    property int contentSize: styles.h8
                    width: buyButtonText.implicitWidth + buyButton.contentSize * 1.8
                    height: buyButton.contentSize * 2.5
                    color: buyButtonMouseArea.containsPress ? styles.blueDefault :
                               (buyButtonMouseArea.containsMouse ? styles.blueDefault2 : styles.blueMedium)
                    radius: styles.squareButtonRoundness
                    //Component.onCompleted: { buyButton.mData = root.modelData; console.log(mData) }

                    Text {
                        id: buyButtonText
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: buyButton.contentSize
                        // text: "Book now"
                        text: "Add to cart"
                        color: styles.white
                        elide: Text.ElideRight
                        maximumLineCount: 1
                    }
                }

                MouseArea {
                    id: buyButtonMouseArea
                    anchors.fill: buyButton
                    hoverEnabled: true
                    onClicked: {
                        buyButtonMouseArea.enabled = false
                        buyButtonCooldownTimer.start()
                        if (root.loaded){
                            CartController.addElementToCart(
                                        elementName,
                                        elementLocation,
                                        elementPrice,
                                        elementPreviewImageSource,
                                        inputField.inputValue === "" ? 1 : inputField.inputValue //if empty, set to 1
                                        )
                        }
                    }
                }

                Timer {
                    id: buyButtonCooldownTimer
                    interval: 200
                    running: false
                    repeat: false
                    onTriggered: {
                        buyButtonMouseArea.enabled = true
                    }
                }
                /////////////////
                ColoredInput {
                    id: inputField
                    placeHolderText: "1 night"
                    anchors {
                        left: buyButton.right
                        verticalCenter: parent.verticalCenter
                        leftMargin: buyContainer.childrenSpacing
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
