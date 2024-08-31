import QtQuick
import Booker

Item {
    id: root

    required property int fontSize
    required property color fontColor
    required property string textContent
    property int maxLinesCount: 1
    property bool fontBold: false
    property int textHAlignment: Text.AlignLeft
    property int textVAlignment: Text.AlignVCenter
    property bool isElideRight: false

    implicitHeight: fontSize * maxLinesCount * 1.2

    Text {
        width: parent.width
        height: parent.height

        font.pixelSize: root.fontSize
        color: root.fontColor
        font.bold: fontBold
        //font.weight: 300 // Cool thing, quite default value is i quess 400 but idk

        text: root.textContent

        elide: if (root.isElideRight)
                    elide: Text.ElideRight
                else
                    elide: Text.ElideNone

        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        maximumLineCount: root.maxLinesCount

        verticalAlignment: root.textVAlignment
        horizontalAlignment: root.textHAlignment

        anchors {
            fill: parent
        }
    }

}
