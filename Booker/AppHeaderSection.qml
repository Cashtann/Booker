import QtQuick
import Booker
import QtQuick.Controls
import app.Manager
import app.CartController
import Qt5Compat.GraphicalEffects

Item {
    id: root

    required property StackView stackViewRef

    anchors {
        // top: parent.top
        left: parent.left
        right: parent.right
    }

    height: styles.appHeaderSectionHeight

    Rectangle {
        id: background
        anchors {
            fill: parent
        }
        color: styles.blueDarker

        Item {
            id: headerContnet

            width: styles.pageWidthContent
            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            Item {
                id: topSec
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }
                height: parent.height / 2

                HeaderText {
                    id: name
                    fontSize: styles.h6
                    fontBold: true
                    fontColor: styles.white
                    textContent: "Booker.com"

                    anchors {
                        top: parent.top
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                    }
                    width: parent.width / 2
                }

                Row {
                    id: topButtonsRow
                    anchors {
                        //left: parent.left
                        right: parent.right
                        top: parent.top
                        bottom: parent.bottom
                    }
                    spacing: 10

                    ColoredButton {
                        textContent: "Your cart"
                        anchors.verticalCenter: parent.verticalCenter
                        contentSize: styles.h11
                        buttonCooldown: 200
                        onClicked: {
                            // if (Manager.currentPage !== "Cart") {
                            //     //stackViewRef.push("AboutPage.qml", { stackViewRef: stackViewRef }, StackView.Immediate)
                            //     //Manager.currentPage = "Cart"
                            // }
                            popupCart.hidden = !popupCart.hidden
                        }
                    }

                    ColoredButton {
                        textContent: "Register"
                        buttonColorIdle: styles.white
                        buttonColorHovered: styles.blueLight
                        buttonColorPressed: styles.blueLight
                        textColor: styles.blueMedium
                        anchors.verticalCenter: parent.verticalCenter
                        contentSize: styles.h11
                        buttonCooldown: 1000
                        onClicked: {
                            if (Manager.currentPage !== "Register") {
                                //stackViewRef.push("AboutPage.qml", { stackViewRef: stackViewRef }, StackView.Immediate)
                                //Manager.currentPage = "Register"
                                console.log("[USER] Register")
                            }
                        }
                    }

                    ColoredButton {
                        textContent: "Sign in"
                        buttonColorIdle: styles.white
                        buttonColorHovered: styles.blueLight
                        buttonColorPressed: styles.blueLight
                        textColor: styles.blueMedium
                        anchors.verticalCenter: parent.verticalCenter
                        contentSize: styles.h11
                        buttonCooldown: 1000
                        onClicked: {
                            if (Manager.currentPage !== "Sign in") {
                                //stackViewRef.push("AboutPage.qml", { stackViewRef: stackViewRef }, StackView.Immediate)
                                //Manager.currentPage = "Sign_in"
                                console.log("[USER] Sign in")
                            }
                        }
                    }
                }
            }
            PopupWindow {
                id: popupCart
                anchors {
                    top: parent.top
                    //horizontalCenter: parent.horizontalCenter
                    //left: parent.horizontalCenter
                    right: parent.right
                    topMargin: 60
                }
                //hidden: true
                popupWidth: 700
                popupHeight: 850
                width: hidden ? 0 : implicitWidth
                z: 200
                ListView {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    height: popupCart.popupHeight
                    model: CartController
                    spacing: 25
                    boundsBehavior: Flickable.StopAtBounds
                    delegate: Item {
                        id: bookElement
                        required property string bookName
                        required property string bookLocation
                        required property real bookPrice
                        required property url bookPreviewImageSource
                        required property int bookNightsCount
                        required property int bookId

                        width: popupCart.popupWidth
                        height: 170
                        Rectangle { anchors.fill: parent; color: styles.redDefault }

                        Image {
                            id: bookPreviewImage
                            source: bookPreviewImage
                            Component.onCompleted: {
                                bookPreviewImage.source = bookElement.bookPreviewImageSource
                            }
                            height: parent.height
                            width: height * 1.7
                            asynchronous: true
                            anchors {
                                top: parent.top
                                left: parent.left
                                bottom: parent.bottom
                            }
                            fillMode: Image.PreserveAspectCrop

                            layer.enabled: true
                            layer.effect: OpacityMask {
                                maskSource: ShaderEffectSource {
                                    sourceItem: Rectangle {
                                        width: bookPreviewImage.width
                                        height: bookPreviewImage.height
                                        radius: 10
                                    }
                                }
                            }
                        }

                        // IconButton {
                        //     // id: bookPreviewDeleteButton
                        //     // required property string buttonTextContent
                        //     // required property url imageSource
                        //     // property int contentSize: styles.h10
                        //     // property bool isActive: false
                        //     // property color iconColor: styles.white
                        // }

                        Column {
                            id: bookPreviewDetails
                            anchors {
                                //top: parent.top
                                //bottom: parent.bottom
                                verticalCenter: parent.verticalCenter
                                left: bookPreviewImage.right
                                right: parent.right
                                leftMargin: 15
                            }
                            Text {
                                id: bookPreviewTextName
                                text: bookElement.bookName
                                color: styles.black
                                font.bold: true
                                font.pixelSize: styles.h7
                                elide: Text.ElideRight
                                anchors {
                                    //top: parent.top
                                    left: parent.left
                                }
                            }
                            IconText {
                                id: bookPreviewTextLocation
                                anchors {
                                    //top: bookPreviewTextName.bottom
                                    left: parent.left
                                }
                                heightMultiplier: 1.8
                                contentSize: styles.h11
                                textColor: styles.black
                                iconColor: styles.blueDefault
                                imageSource: "qrc:/res/assets/icons/icon_gps.svg"
                                textContent: "Location: " + bookElement.bookLocation
                            }
                            IconText {
                                id: bookPreviewTextPrice
                                anchors {
                                    //top: bookPreviewTextLocation.bottom
                                    left: parent.left
                                }
                                heightMultiplier: 1.8
                                contentSize: styles.h11
                                textColor: styles.black
                                iconColor: styles.greenMedium
                                imageSource: "qrc:/res/assets/icons/icon_dollar.svg"
                                textContent: "Price/night: $" + bookElement.bookPrice.toFixed(2)
                            }
                            IconText {
                                id: bookPreviewTextNightsCount
                                anchors {
                                    //top: bookPreviewTextPrice.bottom
                                    left: parent.left
                                }
                                heightMultiplier: 1.8
                                contentSize: styles.h11
                                textColor: styles.black
                                iconColor: styles.black
                                imageSource: "qrc:/res/assets/icons/icon_sleep.svg"
                                textContent: bookElement.bookNightsCount.toString() + (bookElement.bookNightsCount === 1 ? " night" : " nights")
                            }
                            IconText {
                                id: bookPreviewTextTotal
                                anchors {
                                    //top: bookPreviewTextNightsCount.bottom
                                    left: parent.left
                                }
                                heightMultiplier: 1.8
                                contentSize: styles.h11
                                textColor: styles.black
                                iconColor: styles.black
                                imageSource: "qrc:/res/assets/icons/icon_calc2.svg"
                                textContent: "Your total is: $" + (bookElement.bookNightsCount * bookElement.bookPrice).toFixed(2)
                            }
                            // Text {
                            //     // text: bookElement.bookName
                            //     text: bookElement.bookId
                            //     color: styles.white
                            // }
                        }
                    }
                }
            }

            Item {
                id: bottomSec
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    top: topSec.bottom
                }

                Row {
                    id: bottomButtonsRow

                    spacing: 10
                    anchors {
                        fill: parent
                    }

                    IconButton {
                        buttonTextContent: "Home"
                        imageSource: "qrc:/res/assets/icons/icon_bed.svg"
                        isActive: Manager.currentPage === "Home" ? true : false
                        onClicked: {
                            if (stackViewRef.currentItem !== stackViewRef.initialItem) {
                                stackViewRef.pop(StackView.Immediate)
                            }
                            if (Manager.currentPage !== "Home") {
                                Manager.currentPage = "Home"
                            }
                        }
                    }

                    IconButton {
                        buttonTextContent: "About"
                        imageSource: "qrc:/res/assets/icons/icon_info.svg"
                        isActive: Manager.currentPage === "About" ? true : false
                        onClicked: {
                            if (stackViewRef.currentItem !== stackViewRef.initialItem) {
                                stackViewRef.pop(StackView.Immediate)
                            }
                            if (Manager.currentPage !== "About") {
                                stackViewRef.push("AboutPage.qml", { stackViewRef: stackViewRef }, StackView.Immediate)
                                Manager.currentPage = "About"
                            }
                        }
                    }

                    IconButton {
                        buttonTextContent: "Contact"
                        imageSource: "qrc:/res/assets/icons/icon_contact2.svg"
                    }

                    IconButton {
                        buttonTextContent: "Help"
                        imageSource: "qrc:/res/assets/icons/icon_question_mark.svg"
                    }
                }
            }
        }
    }

    AppStyle { id: styles }
}
