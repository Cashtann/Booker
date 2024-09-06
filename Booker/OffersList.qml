import QtQuick
import Booker
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import app.Manager

Page {
    id: offerListPage

    property QtObject modelData: null
    property StackView stackViewRef: null

    height: itemsContainer.height + 200


    Rectangle {
        id: background
        width: parent.width
        height: parent.height
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
        model: offerListPage.modelData
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


            Rectangle {
                id: entireElementArea
                color: styles.greyLight
                anchors.fill: parent
                radius: previewImage.imgRad
                opacity: if (mouseAreaForOfferInOfferList.containsMouse)
                             .7
                        else 0
            }

            Image {
                id: previewImage
                source: element.elementPreviewImageSource
                fillMode: Image.PreserveAspectCrop
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.horizontalCenter
                }
                property int imgRad: 15

                height: 400
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: ShaderEffectSource {
                        sourceItem: Rectangle {
                            width: previewImage.width
                            height: previewImage.height
                            radius: previewImage.imgRad
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
                    margins: 20
                }

                // Rectangle { color: styles.greenLight; anchors.fill: parent }

                Text {
                    id: textName
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }

                    font.pixelSize: styles.h6
                    font.bold: true
                    color: styles.black

                    text: element.elementName

                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }
                Text {
                    id: textDescription
                    anchors {
                        top: textName.bottom
                        left: parent.left
                        right: parent.right
                        bottom: textLocation.top
                    }

                    font.pixelSize: styles.h7
                    color: styles.black

                    text: element.elementDescription
                    elide: Text.ElideRight

                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

                Text {
                    id: textLocation
                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                        right: parent.horizontalCenter
                    }

                    font.pixelSize: styles.h8
                    color: styles.black

                    text: "Location: " + element.elementLocation
                    elide: Text.ElideRight

                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }
                Text {
                    id: textRating
                    anchors {
                        bottom: parent.bottom
                        left: textLocation.right
                        right: parent.right
                    }

                    font.pixelSize: styles.h8
                    color: styles.yellowDefault

                    text: "Rating: " + element.elementAverageRating
                    elide: Text.ElideRight

                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }
            }
            MouseArea {
                id: mouseAreaForOfferInOfferList
                anchors.fill: entireElementArea
                hoverEnabled: true
                onClicked: {
                    offerListPage.stackViewRef.pop(StackView.Immediate)
                    stackViewRef.push("OfferPage.qml", { modelData: element, stackViewRef: offerListPage.stackViewRef }, StackView.Immediate)
                    Manager.currentPage = "Other"
                    offerListPage.stackViewRef.pageChanged()
                }
            }
        }
    }

    AppStyle { id: styles }
}
