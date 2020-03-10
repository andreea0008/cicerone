import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.13
import "components"
import "delegates"
import "pages/stack"

App {
    id: app
    visible: true
    width: 375
    height: 812

    onInitTheme: { Theme.normalFont = bp.fontLoader }

    property BaseProperty bp: BaseProperty{}
    // Background
    Rectangle {
        width: app.width
        height: app.height
        color: bp.backgroundColor
    }

    TopHead{
        id: topHead
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        fontloader: bp.fontLoader
        backArrowVisible: (stackCategoryItem.depthCount > 1 || stackEventItem.depthStack > 1) && (bp.currentPageId !== 3 || bp.currentPageId !== 4)
        onPressedArrowButton: {
            console.log(bp.currentPageId)
            switch(categoryId){
                case 1: stackEventItem.eventsStack.pop(); break;
                case 2: stackCategoryItem.categoryStack.pop(); break;
            }
        }
    }

    Item{
        anchors.top: topHead.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottomMargin: app.height * 0.1

        EventItem {
            id: stackEventItem
            anchors.fill: parent
        }

        StackCategoryItem {
            id: stackCategoryItem
            anchors.fill: parent
        }

        FavoriteCategoryItem{
            id: favoriteCategoryItem
            anchors.fill: parent
        }

        Settings{
            id: settingsItem
            anchors.fill: parent
        }
    }

    Footer {
        id: footer
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: app.height * 0.08
    }
}
