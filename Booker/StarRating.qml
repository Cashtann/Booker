import QtQuick
import Booker
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    id: root

    property string textContent: "Rating: "
    property url imageSource: "qrc:/res/assets/icons/icon_full_star.svg"
    property int contentSize: styles.h8
    property color textColor: styles.yellowDefault
    property color iconColorTrue: styles.yellowDefault
    property color iconColorFalse: styles.greyDarker
    required property real rating

    width: text.implicitWidth + img.width
    height: 2 * contentSize
    //Rectangle { anchors.fill: parent; color: styles.redDefault }

    function validateRating(value) {
        if (value < 0) {
            rating = 0.0
        } else if (value > 5) {
            rating = 5.0
        } else {
            rating = value
        }
    }

    Component.onCompleted: {
        validateRating(rating)
        console.log(rating)
    }

    Text {
        id: text

        height: font.pixelSize

        font.pixelSize: contentSize
        color: root.textColor

        text: root.textContent

        maximumLineCount: 1

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft

        anchors {
            verticalCenter: root.verticalCenter
            left: parent.left
        }
    }

    Repeater {
        model: Math.floor(rating)
        Item {
            Image {
                id: star

                source: root.imageSource

                height: 1.5 * root.contentSize
                fillMode: Image.PreserveAspectFit
                anchors {
                    left: root.left
                    verticalCenter: root.verticalCenter
                    leftMargin: .5 * root.contentSize
                }
            }
            ColorOverlay {
                anchors.fill: star
                source: star
                color: root.iconColor
            }
        }
    }

    // Image {
    //     id: img

    //     source: root.imageSource

    //     height: 1.5 * root.contentSize
    //     fillMode: Image.PreserveAspectFit
    //     anchors {
    //         left: root.left
    //         verticalCenter: root.verticalCenter
    //         leftMargin: .5 * root.contentSize
    //     }
    // }

    // ColorOverlay {
    //     anchors.fill: img
    //     source: img
    //     color: root.iconColor
    // }


    AppStyle { id: styles }

}
