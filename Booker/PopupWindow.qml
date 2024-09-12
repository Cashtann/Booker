import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Controls
import Booker

Rectangle {
    id: root

    property bool hidden: true
    property color backgroundColor: styles.white
    property color shadowColor: styles.grey
    property int shadowSize: 12

    implicitWidth: 300
    implicitHeight: 500

    default property alias content: contentArea.data

    color: backgroundColor
    radius: 15

    Item {
        id: container
        anchors {
            fill: parent
            margins: 25
        }

        // ScrollPageTemplate {
        //     id: contentArea
        //     height: 1000
        //     Rectangle { width: 100; height: 100; color: styles.redDefault }
        // }

        ScrollView {
            anchors.fill: parent
            contentWidth: parent.width
            contentHeight: contentArea.height

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
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
            }
        }
    }

    DropShadow {
        anchors.fill: source
        cached: true
        horizontalOffset: 0
        verticalOffset: 0
        radius: root.shadowSize
        samples: 16
        color: root.shadowColor
        source: root
    }

    AppStyle { id: styles }
}
