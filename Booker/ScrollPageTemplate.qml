import QtQuick
import QtQuick.Controls

ScrollView {
    anchors.fill: parent
    contentWidth: parent.width
    contentHeight: contentArea.height

    default property alias content: contentArea.data

    clip: true
    ScrollBar.vertical: ScrollBar {
        width: 0
        stepSize: 0
    }

    Flickable {
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        Column {
            id: contentArea
            width: parent.width
        }
    }
}
