import QtQuick
import Booker
import QtQuick.Layouts
import QtQuick.Controls

Window {
    id: root
    width: 1920
    height: 1080
    visible: true
    title: qsTr("Hello World")
    color: styles.white

    minimumWidth: styles.pageWidthContent + 50
    minimumHeight: minimumWidth / 2


   MainPage { id: mainPage }
   //OfferPage { id: testPage }



    AppStyle {
        id: styles
    }
}
