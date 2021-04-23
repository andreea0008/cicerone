import QtQuick 2.0
import Felgo 3.0
import "../"

SearchBar {
    id: searchBar
    iosAlternateStyle: true
    textField.placeholderText: qsTr("Search")
    barBackgroundColor: BaseProperty.finderBackground
    inputBackgroundColor: BaseProperty.finderTextAreabackground
    textColor: BaseProperty.text_color
    showClearButton: true
}
