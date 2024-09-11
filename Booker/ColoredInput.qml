import QtQuick
import Booker
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
    id: root

    required property string placeHolderText
    //property color innerColor: styles.white
    property color outerColor: styles.white
    property color placeHolderTextColor: styles.greyDarker
    property color inputTextColor: styles.black
    property int contentSize: styles.h8
    property TextField inputField: input

    implicitWidth: 100
    //width: 100
    //width: outerBackground.width
    height: root.contentSize * 2.5

    Rectangle {
        id: outerBackground
        width: root.width
        anchors {
            left: parent.left
            right: parent.right
        }

        height: root.height
        color: root.outerColor
        radius: styles.squareButtonRoundness


        TextField {
            id: input
            text: ""
            placeholderText: root.placeHolderText
            placeholderTextColor: root.placeHolderTextColor
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                leftMargin: styles.squareButtonRoundness
                rightMargin: styles.squareButtonRoundness
            }
            background: Rectangle { anchors.fill: parent; color: root.outerColor }
            color: root.inputTextColor
            font.pixelSize: root.contentSize

            validator: IntValidator {
                bottom: 1  // You can specify the range, for example 0 to 999
                top: 9999
            }

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: ShaderEffectSource {
                    sourceItem: Rectangle {
                        width: input.width
                        height: input.height
                        radius: styles.squareButtonRoundness
                    }
                }
            }

            Keys.onPressed: (event)=> {
                if (event.key === Qt.Key_Escape || event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Tab) {
                    input.focus = false;  // Unfocus on Escape, Enter, Tab
                }
            }
        }
    }

    AppStyle { id: styles }
}
