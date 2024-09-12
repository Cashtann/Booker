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

        PopupWindow {
            id: popupCart
            hidden: false
            anchors {
                top: parent.top
                right: parent.right
            }
            width: hidden ? 0 : implicitWidth
            z: 100
            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                height: 1000

                spacing: 10
                Rectangle { width: 100; height: 100; color: styles.redDefault }
                Rectangle { width: 100; height: 100; color: styles.redDefault }
                Rectangle { width: 100; height: 100; color: styles.redDefault }
                Rectangle { width: 100; height: 100; color: styles.redDefault }
                Rectangle { width: 100; height: 100; color: styles.redDefault }
                Rectangle { width: 100; height: 100; color: styles.redDefault }
                Rectangle { width: 100; height: 100; color: styles.redDefault }
            }
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
                z: 100
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

                onCurrentItemChanged: {
                    if (currentItem !== null) {
                        height = currentItem.height
                    }
                }

                MainPage {
                    id: mainPage
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    stackViewRef: stackView
                }
            }
        }

    }

    AppStyle { id: styles }
}
