import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Booker
import app.OffersController
import app.Manager

Page {
    id: root

    required property StackView stackViewRef

    height: itemsContainer.height + welcomeImage.height + 200
    Rectangle {
        id: background
        width: root.width
        height: root.height
        color: styles.mainBackground
    }

    Image {
        id: welcomeImage

        anchors {
            horizontalCenter: parent.horizontalCenter
        }

        width: parent.width
        height: 400

        source: styles.mainPageOpeningImage

        fillMode: Image.PreserveAspectCrop

        Column {
            id: headerTexts
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            width: styles.pageWidthContent

            HeaderText {
                id: mainHeaderText
                fontSize: styles.h3
                fontColor: styles.white
                fontBold: true
                textContent: "A place to call home\non your next adventure"
                // textContent: "Rest beyond expectations \non your next adventure"
                maxLinesCount: 2
                anchors {
                    left: parent.left
                    right: parent.right
                }
            }
            HeaderText {
                fontSize: styles.h6
                fontColor: styles.white
                fontBold: false
                textContent: "Experience the joy of an entire place to yourself"
                maxLinesCount: 2
                anchors {
                    left: parent.left
                    right: parent.right
                }
            }
        }
    }

    ListView {
        id: itemsContainer

        interactive: false
        boundsBehavior: Flickable.StopAtBounds

        anchors {
            top: welcomeImage.bottom
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        width: styles.pageWidthContent
        height: contentHeight
        //clip: true
        model: OffersController
        spacing: 100

        delegate: Item {
            id: delegate

            required property string categoryName
            required property string categoryHeader
            required property string categoryDescription
            required property QtObject categoryLocations

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

            function gotoIndex(idx) {
                anim.running = false;

                var pos = locations.contentX;
                var destPos;

                locations.positionViewAtIndex(idx, ListView.Beginning);
                destPos = locations.contentX;

                anim.from = pos;
                anim.to = destPos;
                anim.running = true;
            }

            NumberAnimation { id: anim; target: locations; property: "contentX"; duration: 400; easing.type: Easing.InOutQuad }


            ListView {
                id: locations

                boundsBehavior: Flickable.StopAtBounds
                orientation: ListView.Horizontal

                property int visibleElementCount: (locations.width / (styles.previewOfferWidth + styles.previewOfferSpacing)).toFixed()

                anchors {
                    left: parent.left
                    right: parent.right
                    top: categoryDescriptionText.bottom
                    bottom: parent.bottom
                }
                clip: true
                model: delegate.categoryLocations
                spacing: styles.previewOfferSpacing
                interactive: false

                delegate: Item {
                    id: location

                    required property string locationName
                    required property string locationDescription
                    required property url locationImageSource
                    required property QtObject locationElements

                    width: styles.previewOfferWidth
                    height: styles.previewOfferHeight

                    Image {
                        id: elementPreviewImage

                        asynchronous: true

                        width: styles.previewOfferWidth
                        //height: styles.previewOfferHeight
                        mipmap: true
                        fillMode: Image.PreserveAspectCrop
                        source: location.locationImageSource
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
                        ListView {
                            anchors.fill: parent
                            model: location.locationElements
                            spacing: 30
                            delegate: Item {
                                required property string elementName
                                required property string elementHeader
                                required property string elementLocation
                                required property string elementDescription
                                required property real elementPrice
                                required property real elementAverageRating
                                required property url elementPreviewImageSource
                                Image { width: 25; height: 25; source: parent.elementPreviewImageSource; asynchronous: true }
                            }
                        }
                    }

                    MouseArea {
                        id: previewOfferMouseArea
                        anchors.fill: elementPreviewImage
                        onClicked: {
                            //stackViewRef.push("qrc:/res/OffersList.qml", { modelData: location.locationElements, stackViewRef: root.stackViewRef }, StackView.Immediate)
                            //offersListLoader.source = "OffersList.qml"
                            stackViewRef.push("OffersList.qml", { modelData: location.locationElements, stackViewRef: root.stackViewRef }, StackView.Immediate)
                            Manager.currentPage = "Other"
                            root.stackViewRef.pageChanged()
                        }
                    }

                    // Does not really work (no changes in performance)
                    // Loader {
                    //     id: offersListLoader
                    //     asynchronous: true
                    //     onLoaded: {
                    //         if (item) {
                    //             item.modelData = location.locationElements
                    //             item.stackViewRef = root.stackViewRef
                    //             stackViewRef.push(item, StackView.Immediate);
                    //         }
                    //     }
                    // }

                    HeaderText {
                        id: previewOfferText1
                        fontSize: styles.h8
                        fontColor: styles.black
                        fontBold: true
                        textContent: location.locationName
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
                        textContent: location.locationDescription
                        maxLinesCount: 2
                        anchors {
                            left: parent.left
                            right: parent.right
                            bottom: location.bottom
                        }
                    }
                }
            }

            RoundIconButton {
                imageColor: styles.black
                imageSource: "qrc:/res/assets/icons/icon_angle_right.svg"
                backgroundColor: styles.white
                imageWidth: 10
                width: if (opacity === 0) { 0 } else 50
                height: 50
                buttonCooldown: 400
                anchors {
                    horizontalCenter: locations.right
                    verticalCenter: locations.verticalCenter
                }
                opacity: if ((locations.count * styles.previewOfferWidth + (locations.count - 1) * styles.previewOfferSpacing) > locations.width){
                            if (locations.currentIndex >= locations.count - locations.visibleElementCount)
                                .3
                            else 1
                         }
                        else 0
                onClicked: {
                    if (opacity === 1) {
                        if (locations.currentIndex >= locations.count - locations.visibleElementCount) {
                            locations.currentIndex = locations.count - locations.visibleElementCount
                        }
                        else {
                            locations.incrementCurrentIndex()
                        }
                        gotoIndex(locations.currentIndex)
                    }
                }
            }
            RoundIconButton {
                imageColor: styles.black
                imageSource: "qrc:/res/assets/icons/icon_angle_left.svg"
                backgroundColor: styles.white
                imageWidth: 10
                width: if (opacity === 0) { 0 } else 50
                height: 50
                buttonCooldown: 400
                anchors {
                    horizontalCenter: locations.left
                    verticalCenter: locations.verticalCenter
                }
                opacity: if ((locations.count * styles.previewOfferWidth + (locations.count - 1) * styles.previewOfferSpacing) > locations.width){
                            if (locations.currentIndex === 0)
                                .3
                            else 1
                         }
                        else 0
                onClicked: {
                    if (opacity === 1) {
                        locations.decrementCurrentIndex()
                        gotoIndex(locations.currentIndex)
                    }
                }
            }

        }
    }

    AppStyle { id: styles }
}
