import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.13
import "."
import "../"

Item{
    id: footer
    RowLayout{
        id: rowLayout
        anchors.fill: parent
        spacing: 0
        
        Button{
            id: events
            Layout.preferredWidth: parent.width/BaseProperty.count_categories
            Layout.preferredHeight: parent.height
            iconType: IconType.calendar
            textButton: "Events"
            idCategorie: 1
            currentIdSelect: BaseProperty.currentPageId
        }
        Button{
            id: categories
            Layout.preferredWidth: parent.width/BaseProperty.count_categories
            Layout.preferredHeight: parent.height
            textButton: "Category"
            idCategorie: 2
            iconType: IconType.list
            currentIdSelect: BaseProperty.currentPageId
        }
        Button{
            id: favoriteCategories
            Layout.preferredWidth: parent.width/BaseProperty.count_categories
            Layout.preferredHeight: parent.height
            textButton: "Favorite"
            idCategorie: 3
            iconType: IconType.star
            currentIdSelect: BaseProperty.currentPageId
        }
        Button{
            id: settings
            Layout.preferredWidth: parent.width/BaseProperty.count_categories
            Layout.preferredHeight: parent.height
            textButton: "Settings"
            iconType: IconType.cogs
            idCategorie: 4
            currentIdSelect: BaseProperty.currentPageId
        }
    }
}
