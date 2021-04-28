pragma Singleton
import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Layouts 1.3

QtObject {
    readonly property color backgroundColor: "#28262E"
    readonly property color red_line_color: "#F01D44"
    readonly property color red: "#F01D44"
    readonly property color white: "white"
    readonly property color selected_color: "#1F1E23"
    readonly property color text_color: "white"
    readonly property color color_button_shadow: "white"
    readonly property color red_text_color: "#F01D44"
    readonly property int   count_categories: 4
    readonly property color pressed_color: "#343339"
    readonly property string formatDateTimeEvent: "dd/MM/yy\nhh:mm"

    //pages properties
    property int currentPageId: 2

    //delegates properties
    readonly property color backgroundDelegateColor: "#232228"
    readonly property int heightDelegate: Theme.listItem.minimumHeight * 1.25
    readonly property int heightEventDelegate: (heightDelegate * 5)
    readonly property int doubleHeightDelegate: 2*heightDelegate
    readonly property color colorTextDelegate: "white"
    readonly property color colorDropShadow: "#D2D2D2"

    //finder property
    property color finderBackground: "#232228"
    property color finderTextAreabackground: "#343339"

    //font
    property int h1: 16
    property int h2: 13
    property int h3: 10

    //margin
    property int margin: 15
    property int half_margin: 8

    //indicator
    readonly property real opacityActive: 1.0
    readonly property real opacityInactive: 0.4
    property int heigthIndicator: heightDelegate /8

    //delegate business item
    readonly property int whIcon: heightDelegate *0.5

    //MouseArea
    readonly property int whCloseMouseArea: whIcon *2
    readonly property int whMouseAreaSocial: heightDelegate *0.75

    //ListView
    readonly property int minContentYForStartUpdate: -100
    readonly property int minContentYForStartUpdatePositive: 100

    readonly property FontLoader fontLoader: FontLoader{
        id: fontLoader
        source: "fonts/Roboto-Medium.ttf"
    }

    function visiblePage(pageId)
    {
        if(pageId === currentPageId)
            return true
        return false
    }
}
