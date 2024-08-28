import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Booker

Rectangle{
    id: background

    color: styles.mainBackground

    anchors {
        fill: parent
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: column.height
        id: root

        clip: true
        ScrollBar.vertical: ScrollBar {
            width: 0
            stepSize: 0
        }

        Column {
            id: column
            width: parent.width
            AppHeaderSection {
                id: appHeaderSection


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



            Rectangle {
                id: test

                anchors {
                    //top: appHeaderSection.bottom
                    left: parent.left
                    right: parent.right
                }

                height: 50

                color: styles.greyLight
            }

            Rectangle {
                id: test2

                anchors {
                    horizontalCenter: parent.horizontalCenter
                }

                width: styles.pageWidthContent
                height: 1500
                color: styles.redMedium

                OffersList {
                    id: offersList

                    anchors {
                        fill: parent
                    }
                }
            }
        }
    }





    AppStyle { id: styles }
}
