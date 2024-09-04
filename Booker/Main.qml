import QtQuick
import Booker
import QtQuick.Layouts
import QtQuick.Controls

Window {
    id: root
    width: 1920
    height: 1080
    visible: true
    title: qsTr("Booker")
    color: styles.white

    minimumWidth: styles.pageWidthContent + 50
    minimumHeight: minimumWidth / 2

    Rectangle{
        id: background

        color: styles.mainBackground

        anchors {
            fill: parent
        }

        ScrollPageTemplate {
            id: scrollView
            signal goTop()
            onGoTop: {
                Qt.callLater(() => {
                    scrollView.contentItem.contentY = 0
                })
            }

            AppHeaderSection {
                id: appHeaderSection
                stackViewRef: stackView
            }
            StackView {
                id: stackView

                signal onInitialItemChanged()
                signal pageChanged()
                onPageChanged: {
                    scrollView.goTop()
                }

                initialItem: mainPage
                anchors {
                    left: parent.left
                    right: parent.right
                }
                height: mainPage.height

                MainPage {
                    id: mainPage
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    stackViewRef: stackView
                }
            }

            // MainPage {
            //     id: mainPage
            //     width: parent.width
            //     anchors.horizontalCenter: parent.horizontalCenter
            // }
        }

    }

    AppStyle { id: styles }
}
