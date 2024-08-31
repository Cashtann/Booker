import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Booker
import app.OffersController

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

                anchors {
                    left: parent.left
                    right: parent.right
                    top: categoryDescriptionText.bottom
                    bottom: parent.bottom
                }
                clip: true
                model: delegate.categoryElements
                spacing: styles.previewOfferSpacing

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
                            bottomMargin: styles.previewOfferImageMargins
                        }
                        layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: ShaderEffectSource {
                                sourceItem: Rectangle {
                                    width: elementPreviewImage.width
                                    height: elementPreviewImage.height
                                    radius: 20  // Set the desired corner radius
                                }
                            }
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
            }

        }
    }

    AppStyle { id: styles }
}
