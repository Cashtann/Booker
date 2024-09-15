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
    property int popupWidth: 300
    property int popupHeight: 500
    readonly property int shadowPlaneSize: 100
    property int contentMargin: 25

    // width: popupWidth + 100
    // height: popupHeight + 100
    implicitWidth: popupWidth + shadowPlaneSize
    implicitHeight: popupHeight + shadowPlaneSize

    default property alias content: container.data

    color: "transparent"
    //radius: 15

    DropShadow {
        anchors.fill: source
        cached: true
        horizontalOffset: 0
        verticalOffset: 0
        radius: root.shadowSize
        samples: 16
        color: root.shadowColor
        source: background
    }
    Rectangle {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        width: root.width - shadowPlaneSize
        height: root.height - shadowPlaneSize

        id: background
        color: root.backgroundColor
        radius: 15
        Item {
            id: container
            anchors {
                fill: parent
                margins: root.contentMargin
            }

            //// ScrollPageTemplate {
            ////     id: contentArea
            ////     //Rectangle { width: 100; height: 100; color: styles.redDefault }
            //// }

            // ScrollView {
            //     anchors.fill: parent
            //     contentWidth: parent.width
            //     contentHeight: contentArea.height

            //     clip: true
            //     ScrollBar.vertical: ScrollBar {
            //         width: 0
            //         stepSize: 0
            //     }

            //     Flickable {
            //         anchors.fill: parent
            //         boundsBehavior: Flickable.StopAtBounds
            //         Column {
            //             id: contentArea
            //             width: parent.width
            //         }
            //     }
            // }
        }
    }

    AppStyle { id: styles }
}
