import QtQuick
import Booker
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    id: root

    required property string textContent
    required property url imageSource
    property int contentSize: styles.h10
    property color textColor: styles.black
    property color iconColor: styles.black

    width: text.implicitWidth + img.width
    height: 2 * contentSize
    //Rectangle { anchors.fill: parent; color: styles.redDefault }

    Image {
        id: img

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
        anchors.fill: img
        source: img
        color: root.iconColor
    }

    Text {
        id: text

        height: font.pixelSize

        font.pixelSize: contentSize
        color: root.textColor
        //font.weight: 300 // Cool thing, quite default value is i quess 400 but idk

        text: root.textContent

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

    AppStyle { id: styles }

}
