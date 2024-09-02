import QtQuick
import Booker
//import QtQuick.Layouts
import QtQuick.Controls

Page {
    id: root

    required property QtObject modelData

    height: itemsContainer.height + 200
    Rectangle {
        id: background
        width: root.width
        height: root.height
        color: styles.mainBackground
    }
    Item {
        id: itemsContainer
    }


    AppStyle { id: styles }
}
