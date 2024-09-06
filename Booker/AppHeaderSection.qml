import QtQuick
import Booker
import QtQuick.Controls
import app.Manager

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
                    id: buttonsRow

                    spacing: 10
                    anchors {
                        fill: parent
                    }

                    IconButton {
                        buttonTextContent: "Home"
                        imageSource: "qrc:/res/assets/icons/icon_bed.svg"
                        isActive: Manager.currentPage === "Home" ? true : false
                        onClicked: {
                            Manager.currentPage = "Home"
                            if (stackViewRef.currentItem !== stackViewRef.initialItem) {
                                stackViewRef.pop(StackView.Immediate)
                            }
                        }
                    }

                    IconButton {
                        buttonTextContent: "About"
                        imageSource: "qrc:/res/assets/icons/icon_person.svg"
                    }

                    IconButton {
                        buttonTextContent: "Contact"
                        imageSource: "qrc:/res/assets/icons/icon_calendar_default.svg"
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
