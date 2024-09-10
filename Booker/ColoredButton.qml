import QtQuick
import Booker

Item {
    id: root

    required property string textContent
    property color buttonColorIdle: styles.blueDefault
    property color buttonColorHovered: styles.blueDarker
    property color buttonColorPressed: styles.blueDarker
    property color textColor: styles.white

    signal clicked()


    AppStyle { id: styles }
}
