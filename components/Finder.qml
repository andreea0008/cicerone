import QtQuick 2.0
import Felgo 3.0

SearchBar {
    id: searchBar
    iosAlternateStyle: true
    property QtObject properties: QtObject{}
    textField.placeholderText: qsTr("Пошук")
    barBackgroundColor:properties.finderBackground
    inputBackgroundColor: properties.finderTextAreabackground
    textColor: properties.text_color
}
