import QtQuick
import Booker

Item {
    id: root

    required property string placeHolderText
    property color innerColor: styles.white
    property color outerColor: styles.blueDefault
    property color placeHolderTextColor: styles.greyDarker
    property color inputTextColor: styles.black
    property int contentSize: styles.h8


    AppStyle { id: styles }
}
