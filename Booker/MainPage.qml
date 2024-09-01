import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Booker

Rectangle{
    id: background

    color: styles.mainBackground

    anchors {
        fill: parent
    }

    ScrollPageTemplate {

        AppHeaderSection {
            id: appHeaderSection
        }


        OffersList {
            id: offersList
            //width: styles.pageWidthContent
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }





    AppStyle { id: styles }
}
