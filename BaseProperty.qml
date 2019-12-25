import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Layouts 1.3

QtObject {
    readonly property color backgroundColor: "#28262E"
    readonly property color red_line_color: "#F01D44"
    readonly property color selected_color: "#1F1E23"
    readonly property color text_color: "white"
    readonly property int   count_categories: 4
    readonly property color pressed_color: "#343339"

    //pages properties
    property int currentPageId: 1

    //delegates properties
    property color backgroundDelegateColor: "#232228"
    property int heightDelegate: Theme.listItem.minimumHeight * 1.25
    property color colorTextDelegate: "white"

    //finder property
    property color finderBackground: "#232228"
    property color finderTextAreabackground: "#343339"

    //font
    property int h1: 16
    property int h2: 13

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
