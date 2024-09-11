import QtQuick
import Booker
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects


Item {
    id: root

    required property string buttonTextContent
    required property url imageSource
    property int contentSize: styles.h10
    property bool isActive: false
    property color iconColor: styles.white

    z: 100

    // readonly property int margins: contentSize

    signal clicked

    height: 2.5 * contentSize

    width: text.implicitWidth + img.width + (4 * root.contentSize)

    Rectangle {
        id: bg

        color: styles.white

        radius: height / 2

        anchors {
            fill: parent
        }

        opacity: if (buttonMouseArea.containsPress || root.isActive) {
                           return 0.15
                       } else if (buttonMouseArea.containsMouse) {
                           return 0.1
                       } else {
                           0
                       }
    }

    Rectangle {
        id: border

        color: "transparent"
        anchors {
            fill: bg
        }

        radius: bg.radius

        border.color: styles.white
        border.width: root.isActive ? 1 : 0
        //border.width: buttonMouseArea.containsPress ? 1 : 0
    }

    Image {
        id: img

        source: root.imageSource

        height: 1.5 * root.contentSize
        fillMode: Image.PreserveAspectFit
        anchors {
            left: root.left
            verticalCenter: root.verticalCenter
            leftMargin: 1.5 * root.contentSize
        }
    }

    ColorOverlay {
        anchors.fill: img
        source: img
        color: root.iconColor
    }

    Text {
        id: text

        height: font.pixelSize


        font.pixelSize: contentSize
        color: styles.white
        //font.weight: 300 // Cool thing, quite default value is i quess 400 but idk

        text: root.buttonTextContent

        elide: Text.ElideRight
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        maximumLineCount: 1

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft

        anchors {
            verticalCenter: root.verticalCenter
            left: img.right
            leftMargin: root.contentSize
        }


    }



    MouseArea {
        id: buttonMouseArea

        anchors {
            fill: bg
        }

        hoverEnabled: true

        onClicked: {
            root.clicked()
        }
    }

    AppStyle { id: styles }
}

// Row {
//     id: root
//     height: styles.iconButtonHeight
//     width: text.implicitWidth


//     required property string buttonTextContent
//     required property url imageSource

//     signal clicked


//     Rectangle {
//         id: background
//         color: styles.white
//         opacity: 1

//         width: text.implicitWidth

//         anchors {
//             fill: parent
//         }
//     }

//     Image {
//         id: img

//         opacity: 1
//         source: root.imageSource

//         height: root.height * .8
//         fillMode: Image.PreserveAspectFit
//         anchors {
//             left: root.left
//             verticalCenter: root.verticalCenter
//         }
//     }

//     HeaderText {
//         id: text

//         opacity: 1
//         textContent: root.buttonTextContent
//         fontColor: styles.white
//         fontBold: false
//         fontSize: styles.h7

//         anchors {
//             left: img.right
//             right: root.right
//         }
//     }
//     // Text {
//     //     height: parent.height


//     //     font.pixelSize: styles.h5
//     //     color: styles.white
//     //     //font.weight: 300 // Cool thing, quite default value is i quess 400 but idk

//     //     text: root.buttonTextContent

//     //     elide: Text.ElideRight
//     //     wrapMode: Text.WrapAtWordBoundaryOrAnywhere
//     //     maximumLineCount: root.maxLinesCount

//     //     verticalAlignment: Text.AlignVCenter
//     //     horizontalAlignment: Text.AlignLeft

//     //     anchors {
//     //         left: img.right
//     //         top: parent.top
//     //         bottom: parent.bottom
//     //         right: parent.right
//     //     }
//     // }



//     AppStyle { id: styles }
// }
