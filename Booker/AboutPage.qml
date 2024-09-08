import QtQuick
import Booker
//import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Controls
import app.Manager

Page {
    id: root

    required property StackView stackViewRef

    height: itemsContainer.height + 200
    Rectangle {
        id: background
        width: root.width
        height: root.height
        color: styles.mainBackground
    }

    Item {
        id: itemsContainer
        anchors {
            top: parent.top
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        width: styles.pageWidthContent
        height: title.height + description.height + 200

        Text {
            id: title

            font.pixelSize: styles.h4
            color: styles.black
            font.bold: true
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: 50
            }

            text: "Welcome to \"About\" page!"

            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }

        Text {
            id: description

            font.pixelSize: styles.h6
            color: styles.black
            anchors {
                top: title.top
                left: parent.left
                right: parent.right
            }

            text: "This app (or however you want to call it) is made for learning pupropses only. Author: " + styles.authorUrl

            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }
    }

    AppStyle { id: styles }
}
