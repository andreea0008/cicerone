import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.13
import "."

Item{
    id: footer
    RowLayout{
        id: rowLayout
        anchors.fill: parent
        spacing: 0
        
        Button{
            id: events
            Layout.preferredWidth: parent.width/bp.count_categories
            Layout.preferredHeight: parent.height
            pressedIconState:   "../img/event_red.png"
            unpressedIconState: "../img/event_white.png"
            textButton: "Events"
            idCategorie: 1
            currentIdSelect: bp.currentPageId
        }
        Button{
            id: categories
            Layout.preferredWidth: parent.width/bp.count_categories
            Layout.preferredHeight: parent.height
            pressedIconState:   "../img/category_red.png"
            unpressedIconState: "../img/category_white.png"
            textButton: "Category"
            idCategorie: 2
            currentIdSelect: bp.currentPageId
        }
        Button{
            id: categories4
            Layout.preferredWidth: parent.width/bp.count_categories
            Layout.preferredHeight: parent.height
            pressedIconState:   "../img/favorite_red.png"
            unpressedIconState: "../img/favorite_white.png"
            textButton: "Favorite"
            idCategorie: 3
            currentIdSelect: bp.currentPageId
        }
        Button{
            id: settings
            Layout.preferredWidth: parent.width/bp.count_categories
            Layout.preferredHeight: parent.height
            pressedIconState:   "../img/settings_red.png"
            unpressedIconState: "../img/settings_white.png"
            textButton: "Settings"
            idCategorie: 4
            currentIdSelect: bp.currentPageId
        }
    }
}
