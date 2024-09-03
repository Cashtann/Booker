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

                var pos = elements.contentX;
                var destPos;

                elements.positionViewAtIndex(idx, ListView.Beginning);
                destPos = elements.contentX;

                anim.from = pos;
                anim.to = destPos;
                anim.running = true;
            }

            NumberAnimation { id: anim; target: elements; property: "contentX"; duration: 300; easing.type: Easing.InOutQuad }


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
                model: delegate.categoryLocations
                spacing: styles.previewOfferSpacing
                interactive: false

                delegate: Item {
                    id: element

                    required property string locationName
                    required property string locationDescription
                    required property url locationImageSource
                    required property QtObject locationElements

                    width: styles.previewOfferWidth
                    height: styles.previewOfferHeight

                    Image {
                        id: elementPreviewImage

                        width: styles.previewOfferWidth
                        //height: styles.previewOfferHeight
                        mipmap: true
                        fillMode: Image.PreserveAspectCrop
                        source: element.locationImageSource
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
                            //console.log(elements.currentIndex);
                            //stackViewRef.push("qrc:/res/OfferPage.qml", { modelData: element }, StackView.Immediate)
                            stackViewRef.push("OfferPage.qml", { modelData: element }, StackView.Immediate)
                            Manager.currentPage = "Other"
                        }
                    }

                    HeaderText {
                        id: previewOfferText1
                        fontSize: styles.h8
                        fontColor: styles.black
                        fontBold: true
                        textContent: element.locationName
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
                        textContent: element.locationDescription
                        maxLinesCount: 2
                        anchors {
                            left: parent.left
                            right: parent.right
                            bottom: element.bottom
                        }
                    }
                }
                // currentIndex:   if (count === 0)
                //                   0
                //                 else if (count < elements.visibleElementCount)
                //                 // (count <= ((elements.width / (styles.previewOfferWidth + styles.previewOfferSpacing)).toFixed() - 1))
                //                     count - 1
                //                 else elements.visibleElementCount - 1
                highlightFollowsCurrentItem: true
                        highlightMoveDuration: 500  // Duration for the scroll animation in milliseconds
                        highlight: Rectangle {       // Custom highlight item (can be empty or styled)
                            color: "transparent"     // Use transparent color if you don't want a visible highlight
                            width: 1
                            height: 1
                        }

            }

            RoundIconButton {
                imageColor: styles.black
                imageSource: "qrc:/res/assets/icons/icon_angle_right.svg"
                backgroundColor: styles.white
                imageWidth: 10
                width: if (opacity === 0) { 0 } else 50
                height: 50
                buttonCooldown: 200
                anchors {
                    horizontalCenter: elements.right
                    verticalCenter: elements.verticalCenter
                }
                opacity: if ((elements.count * styles.previewOfferWidth + (elements.count - 1) * styles.previewOfferSpacing) > elements.width){
                            if (elements.currentIndex >= elements.count - elements.visibleElementCount)
                                .3
                            else 1
                         }
                        else 0
                onClicked: {
                    if (opacity === 1) {
                        if (elements.currentIndex >= elements.count - elements.visibleElementCount) {
                            elements.currentIndex = elements.count - elements.visibleElementCount
                        }
                        else {
                            elements.incrementCurrentIndex()
                        }

                        //elements.positionViewAtIndex(elements.currentIndex, ListView.Contain)
                        gotoIndex(elements.currentIndex)
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
                buttonCooldown: 200
                anchors {
                    horizontalCenter: elements.left
                    verticalCenter: elements.verticalCenter
                }
                opacity: if ((elements.count * styles.previewOfferWidth + (elements.count - 1) * styles.previewOfferSpacing) > elements.width){
                            if (elements.currentIndex === 0)
                                .3
                            else 1
                         }
                        else 0
                onClicked: {
                    if (opacity === 1) {
                        elements.decrementCurrentIndex()

                        //elements.positionViewAtIndex(elements.currentIndex, ListView.Contain)
                        gotoIndex(elements.currentIndex)
                    }
                }
            }

        }
    }

    AppStyle { id: styles }
}
