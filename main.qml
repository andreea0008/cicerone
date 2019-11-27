import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Layouts 1.3
import "components"
App {
    id: app
    visible: true
    width: 640
    height: 480

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
    }
    Item{
        anchors.top: topHead.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottomMargin: app.height * 0.1

        SwipeView {
            id: swipeView
            anchors.fill: parent
            //events
//            StackView{
//                id: stackAllCategory

//                onVisibleChanged: {
//                    if(!visible)
//                        releaseStack()
//                }

//                focus: true
//                initialItem: Rectangle{
//                    width: parent.width
//                    height: parent.height
//                    color: bp.backgroundColor

//                    ListView{
//                        id: list
//                        width: parent.width
//                        height: parent.height
//                        spacing: dp(1)
//                        clip: true
//                        model: 10
//                        antialiasing: true
//                        delegate: Rectangle {
//                            id: name
//                            width: parent.width
//                            height: Theme.listItem.minimumHeight *2
//                            color: "red"
//                        }
//                    }
//                }
//            }
            //catalog
            StackView{
                id: stackAllCategory2

                onVisibleChanged: {
                    if(!visible)
                        releaseStack()
                }

                focus: true
                initialItem: Rectangle{
                    width: parent.width
                    height: parent.height
                    color: bp.backgroundColor

                    ListView{
                        id: list2
                        width: parent.width
                        height: parent.height
                        spacing: dp(1)
                        clip: true
                        model: 9// category_xml
                        antialiasing: true

                        delegate: Rectangle {
                            id: name2
                            width: parent.width
                            height: Theme.listItem.minimumHeight
                            color: bp.selected_color
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: sp(10)
                                text: modelData
                                color: "white"
                            }
                            onYChanged: console.log(y)
                        }
                    }
                }
            }
        }
    }

    Item{
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: app.height * 0.08
        RowLayout{
            id: rowLayout
            anchors.fill: parent
            spacing: 0

            Button{
                id: categories
                Layout.preferredWidth: parent.width/bp.count_categories
                Layout.preferredHeight: parent.height
                pressedIconState: "../img/event_red.png"
                unpressedIconState: "../img/event_white.png"
                textButton: "Events"
            }
            Button{
                id: categories2
                Layout.preferredWidth: parent.width/bp.count_categories
                Layout.preferredHeight: parent.height
                pressedIconState: "../img/category_red.png"
                unpressedIconState: "../img/category_white.png"
                textButton: "Category"
            }
            Button{
                id: categories4
                Layout.preferredWidth: parent.width/bp.count_categories
                Layout.preferredHeight: parent.height
                pressedIconState: "../img/favorite_red.png"
                unpressedIconState: "../img/favorite_white.png"
                textButton: "Favorite"
            }
            Button{
                id: settings
                Layout.preferredWidth: parent.width/bp.count_categories
                Layout.preferredHeight: parent.height
                pressedIconState: "../img/settings_red.png"
                unpressedIconState: "../img/settings_white.png"
                textButton: "Settings"
            }
        }
    }
}
