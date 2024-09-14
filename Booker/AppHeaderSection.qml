import QtQuick
import Booker
import QtQuick.Controls
import app.Manager
import app.CartController

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
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 100
                }
                //hidden: true
                popupWidth: 500
                popupHeight: 800
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
                    delegate: Item {
                        id: bookElement
                        required property string bookName
                        required property string bookLocation
                        required property real bookPrice
                        required property url bookPreviewImageSource
                        required property int bookNightsCount

                        width: popupCart.popupWidth
                        height: 100
                        Rectangle { width: 50; height: 50; color: styles.redDefault }
                        Text {
                            text: bookElement.bookName
                            color: styles.white
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
