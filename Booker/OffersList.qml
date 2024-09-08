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
                source: element.elementPreviewImageSource
                //source: modelData === null ? "qrc:/res/assets/images/loading_error.jpg" : element.elementPreviewImageSource
                asynchronous: true

                fillMode: Image.PreserveAspectCrop
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.horizontalCenter
                }
                property int imgRad: styles.imageRoundness

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

                    // text: element.elementName
                    text: modelData === null ? "Loading..." : element.elementName
                    Component.onCompleted: {
                        element.elementName.text = element.elementName
                    }

                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

                IconText {
                    id: textLocation
                    anchors {
                        top: textName.bottom
                        left: parent.left
                        right: parent.right
                    }
                    heightMultiplier: 2.5

                    contentSize: styles.h8
                    textColor: styles.black
                    iconColor: styles.blueDefault
                    imageSource: "qrc:/res/assets/icons/icon_gps.svg"

                    //text: "Location: " + element.elementLocation
                    textContent: modelData === null ? "Loading..." : "Location: " + element.elementLocation
                    Component.onCompleted: {
                        textLocation.textContent = "Location: " + element.elementLocation
                    }
                }

                Text {
                    id: textDescription
                    anchors {
                        top: textLocation.bottom
                        left: parent.left
                        right: parent.right
                        bottom: starRating.top
                    }

                    font.pixelSize: styles.h7
                    color: styles.black

                    // text: element.elementDescription
                    text: modelData === null ? "Loading..." : element.elementDescription
                    Component.onCompleted: {
                        textDescription.text = element.elementDescription
                    }

                    elide: Text.ElideRight

                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }



                StarRating {
                    id: starRating
                    textContent: "Rating: " + element.elementAverageRating.toFixed(1) + " "
                    Component.onCompleted: {
                        starRating.textContent = "Rating: " + element.elementAverageRating.toFixed(1) + " "
                    }
                    rating: element.elementAverageRating
                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                        right: parent.horizontalCenter
                    }
                }

                Text {
                    id: clickForMoreText
                    anchors {
                        left: starRating.right
                        right: parent.right
                        verticalCenter: starRating.verticalCenter
                    }

                    //horizontalAlignment: Text.AlignHCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: styles.h9
                    color: styles.blueDefault

                    // text: element.elementDescription
                    text: ">> Click for more info <<"
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
