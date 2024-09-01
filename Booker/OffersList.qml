import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Booker
import app.OffersController
import app.Manager

Item {
    id: root

    signal clicked

    ListView {
        id: itemsContainer

        interactive: false
        boundsBehavior: Flickable.StopAtBounds

        anchors {
            fill: parent
        }
        //clip: true
        model: OffersController
        spacing: 100

        delegate: Item {
            id: delegate

            required property string categoryName
            required property string categoryHeader
            required property string categoryDescription
            required property QtObject categoryElements

            height: categoryHeaderText.implicitHeight + categoryDescriptionText.implicitHeight + styles.previewOfferHeight

            anchors {
                left: parent.left
                right: parent.right
            }

            // Rectangle { id: background; anchors.fill: delegate; color: styles.greenLight }


            HeaderText {
                id: categoryHeaderText
                fontSize: styles.h6
                fontColor: styles.black
                fontBold: true
                textContent: delegate.categoryHeader
                isElideRight: true
                // maxLinesCount: 1
                anchors {
                    left: parent.left
                    right: parent.right
                }
                // Rectangle { anchors.fill: parent; color: styles.yellowDefault; anchors.leftMargin: 300 }
            }

            HeaderText {
                id: categoryDescriptionText
                fontSize: styles.h7
                fontColor: styles.black
                fontBold: false
                textContent: delegate.categoryDescription
                maxLinesCount: 1
                anchors {
                    left: parent.left
                    right: parent.right
                    top: categoryHeaderText.bottom
                    //topMargin: 10
                }
            }

            ListView {
                id: elements

                boundsBehavior: Flickable.StopAtBounds
                orientation: ListView.Horizontal

                property int visibleElementCount: (elements.width / (styles.previewOfferWidth + styles.previewOfferSpacing)).toFixed()

                anchors {
                    left: parent.left
                    right: parent.right
                    top: categoryDescriptionText.bottom
                    bottom: parent.bottom
                }
                clip: true
                model: delegate.categoryElements
                spacing: styles.previewOfferSpacing
                interactive: false

                delegate: Item {
                    id: element

                    required property string elementName
                    required property string elementHeader
                    required property string elementLocation
                    required property url elementPreviewImageSource
                    required property real elementPrice
                    required property real elementAverageRating
                    width: styles.previewOfferWidth
                    height: styles.previewOfferHeight

                    Image {
                        id: elementPreviewImage

                        width: styles.previewOfferWidth
                        //height: styles.previewOfferHeight
                        mipmap: true
                        fillMode: Image.PreserveAspectCrop
                        source: element.elementPreviewImageSource
                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: previewOfferText1.top
                            topMargin: styles.previewOfferImageMargins
                            bottomMargin: styles.previewOfferImageMargins / 2
                        }
                        layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: ShaderEffectSource {
                                sourceItem: Rectangle {
                                    width: elementPreviewImage.width
                                    height: elementPreviewImage.height
                                    radius: 15
                                }
                            }
                        }
                    }

                    MouseArea {
                        id: previewOfferMouseArea
                        anchors.fill: elementPreviewImage
                        onClicked: {
                            console.log(elements.currentIndex);
                        }
                    }

                    HeaderText {
                        id: previewOfferText1
                        fontSize: styles.h8
                        fontColor: styles.black
                        fontBold: true
                        textContent: element.elementName
                        maxLinesCount: 1
                        anchors {
                            left: parent.left
                            right: parent.right
                            bottom: previewOfferText2.top
                        }
                    }

                    HeaderText {
                        id: previewOfferText2
                        fontSize: styles.h9
                        fontColor: styles.black
                        fontBold: false
                        textContent: element.elementHeader
                        maxLinesCount: 2
                        anchors {
                            left: parent.left
                            right: parent.right
                            bottom: element.bottom
                        }
                    }
                }
                currentIndex:   if (count == 0)
                                  0
                                else if (count < elements.visibleElementCount)
                                // (count <= ((elements.width / (styles.previewOfferWidth + styles.previewOfferSpacing)).toFixed() - 1))
                                    count - 1
                                else elements.visibleElementCount - 1

            }

            IconRound {
                imageColor: styles.black
                imageSource: "qrc:/res/assets/icons/icon_angle_right.svg"
                backgroundColor: styles.greyLight
                imageWidth: 10
                width: 50
                height: 50
                anchors {
                    horizontalCenter: elements.right
                    verticalCenter: elements.verticalCenter
                }
                opacity: if ((elements.count * styles.previewOfferWidth + (elements.count - 1) * styles.previewOfferSpacing) > elements.width)
                             1
                        else .2
                onClicked: {
                    if (elements.currentIndex <= elements.visibleElementCount - 1) {
                        elements.currentIndex = elements.visibleElementCount
                    }
                    else {
                        elements.incrementCurrentIndex()
                    }

                    if (opacity === 1) elements.positionViewAtIndex(elements.currentIndex, ListView.Contain)
                }
            }
            IconRound {
                imageColor: styles.black
                imageSource: "qrc:/res/assets/icons/icon_angle_left.svg"
                backgroundColor: styles.greyLight
                imageWidth: 10
                width: 50
                height: 50
                anchors {
                    horizontalCenter: elements.left
                    verticalCenter: elements.verticalCenter
                }
                opacity: if ((elements.count * styles.previewOfferWidth + (elements.count - 1) * styles.previewOfferSpacing) > elements.width)
                             1
                        else .2
                onClicked: {
                    if (elements.currentIndex > elements.count - elements.visibleElementCount) {
                        elements.currentIndex = elements.count - elements.visibleElementCount - 1
                    }
                    else {
                        elements.decrementCurrentIndex()
                    }

                    if (opacity === 1) elements.positionViewAtIndex(elements.currentIndex, ListView.Contain)
                }
            }

        }
    }

    AppStyle { id: styles }
}
