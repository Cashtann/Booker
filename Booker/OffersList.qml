import QtQuick
import Booker
import app.OffersController

Item {
    id: root

    signal clicked

    ListView {
        id: itemsContainer

        interactive: false

        anchors {
            fill: parent
        }
        //clip: true
        model: OffersController
        spacing: 10

        delegate: Item {
            id: delegate

            required property string categoryName
            required property string categoryHeader
            required property string categoryDescription


            height: 300

            anchors {
                left: parent.left
                right: parent.right
            }

            Rectangle {
                id: background

                anchors.fill: delegate

                color: styles.greenLight
            }


            HeaderText {
                id: categoryHeaderText
                fontSize: styles.h3
                fontColor: styles.black
                fontBold: false
                textContent: delegate.categoryHeader
                // textContent: "Rest beyond expectations \non your next adventure"
                maxLinesCount: 2
                anchors {
                    left: parent.left
                    right: parent.right

                }
            }

            HeaderText {
                id: categoryNameText
                fontSize: styles.h5
                fontColor: styles.black
                fontBold: false
                textContent: delegate.categoryName
                // textContent: "Rest beyond expectations \non your next adventure"
                maxLinesCount: 2
                anchors {
                    left: parent.left
                    right: parent.right

                }
            }

        }
    }

    AppStyle { id: styles }
}
