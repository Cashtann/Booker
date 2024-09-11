import QtQuick
import Booker

QtObject {
    id: styleObject

    readonly property string authorUrl: "https://github.com/Cashtann"

    readonly property int minApplicationWidth: 100
    readonly property int minApplicationHeight: 100

    readonly property int appHeaderSectionHeight: 125
    readonly property int pageWidthContent: 1200


    readonly property int       t1 : 14
    readonly property int       t2 : 12
    readonly property int       t3 : 10

    readonly property int       h1 : 72
    readonly property int       h2 : 64
    readonly property int       h3 : 56
    readonly property int       h4 : 52
    readonly property int       h5 : 46
    readonly property int       h6 : 32
    readonly property int       h7 : 28
    readonly property int       h8 : 24
    readonly property int       h9 : 20
    readonly property int       h10: 18
    readonly property int       h11: 16


    readonly property color white: "#FFFFFF"
    readonly property color greyLight: "#F1F3F4"
    readonly property color grey: "#A9A9A9"
    readonly property color greyDarker: "#676767"
    readonly property color black: "#202124"

    readonly property color blueDefault: "#174EA6"
    readonly property color blueMedium: "#006CE4"
    readonly property color blueLight: "#D2E3FC"
    readonly property color blueDarker: "#0635A3"

    readonly property color redDefault: "#A50E0E"
    readonly property color redMedium: "#EA4335"
    readonly property color redLight: "#FAD2CF"

    readonly property color orangeDefault: "#E37400"

    readonly property color yellowDefault: "#FBBC04"
    readonly property color yellowLight: "#FEEFC3"

    readonly property color greenDefault: "#0D652D"
    readonly property color greenMedium: "#34A853"
    readonly property color greenLight: "#CEEAD6"

    readonly property url mainPageOpeningImage: "qrc:/res/assets/images/mainpage_welcome.png"

    readonly property int previewOfferSpacing: 25
    readonly property int previewOfferWidth: (pageWidthContent - 3 * previewOfferSpacing) / 4
    //readonly property int previewOfferWidth: 300
    readonly property int previewOfferHeight: 400
    readonly property int previewOfferImageMargins: 25

    readonly property int imageRoundness: 15
    readonly property int squareButtonRoundness: 7

    property bool isLightTheme: true

    property color mainBackground: isLightTheme ? white : black

    readonly property string loremIpsum: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    readonly property string loremIpsumShort: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."


}
