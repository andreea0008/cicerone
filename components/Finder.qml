import QtQuick 2.12
import Felgo 3.0
import "../"

SearchBar {
    id: searchBar
    barBackgroundColor: BaseProperty.finderTextAreabackground//BaseProperty.finderBackground
    inputBackgroundColor: BaseProperty.finderTextAreabackground//BaseProperty.finderTextAreabackground
    textColor: BaseProperty.text_color
    showClearButton: true
}
