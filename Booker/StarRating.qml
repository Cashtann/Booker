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
    property color iconColorFalse: styles.grey
    required property real rating

    width: text.implicitWidth + starRow.width
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
    Row {
        id: starRow
        anchors {
            left: text.right
            top: text.top
            bottom: text.bottom
        }

        Repeater {
            model: 5
            delegate: Item {
                id: delegate
                width: starFalse.width
                height: starFalse.height
                Image {
                    id: starFalse

                    source: root.imageSource

                    height: root.contentSize
                    fillMode: Image.PreserveAspectFit
                    layer.enabled: true
                    layer.effect: ColorOverlay {
                        color: root.iconColorFalse
                        source: starFalse
                    }
                }
                Image {
                    id: starTrue
                    anchors {
                        //top: starFalse.top
                        //left: starFalse.left
                        //horizontalCenter: parent.horizontalCenter
                    }
                    horizontalAlignment: Image.AlignLeft
                    source: starFalse.source
                    //width: starFalse.width
                    width:  if (index + 1 <= rating) starFalse.width;
                            else if (index + 1 > rating && index < rating) (starFalse.width * (rating - index));
                            else 0
                    height: starFalse.height
                    fillMode: Image.PreserveAspectCrop
                    layer.enabled: true
                    layer.effect: ColorOverlay {
                        color: root.iconColorTrue
                        source: starTrue
                    }
                }
                // ColorOverlay {
                //     //anchors.fill: starFull
                //     width: starFull.width
                //     height: starFull.height
                //     source: starFull
                //     //color: root.iconColorTrue
                //     color: if (index + 1 <= rating) root.iconColorTrue
                //             else root.iconColorFalse
                // }
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
