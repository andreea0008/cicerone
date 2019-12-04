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

        Item
        {
            anchors.fill: parent
            visible: true
            //events
            StackView{
                id: stackEvents
                width: parent.width
                height: parent.height
                visible: true
                focus: true
                initialItem: Rectangle{
                    width: parent.width
                    height: parent.height
                    color: bp.backgroundColor

                    ListView{
                        id: list
                        width: parent.width
                        height: parent.height
                        spacing: dp(1)
                        clip: true
                        model: ['Кафе', 'Ресторани', 'Кафе', 'Ресторани', 'Кафе', 'Ресторани']
                        antialiasing: true
                        delegate: Rectangle {
                            id: name
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.leftMargin: dp(1)
                            anchors.rightMargin: dp(1)
                            height: bp.heightDelegate
                            color: bp.backgroundDelegateColor
                            Text {
                                anchors.fill: parent
                                anchors.leftMargin: dp(15)
                                text: qsTr(modelData)
                                verticalAlignment: Text.AlignVCenter
                                color: "white"
                            }
                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                onPressed: parent.color = "#343339"
                                onCanceled: parent.color = bp.backgroundDelegateColor
                                onExited: parent.color = bp.backgroundDelegateColor
                                onReleased: {
                                    parent.color = bp.backgroundDelegateColor
                                    stackEvents.push("pages/TestpushPage.qml")
                                }
                            }
                        }
                    }
                }
            }
        }
        Item
        {
            anchors.fill: parent
            visible: bp.visiblePage(2)
            Rectangle{anchors.fill: parent; color: "green" }
        }

        //events
        /*StackView{
                id: stackEvents
                visible: bp.visiblePage(1)
                focus: true
                initialItem: Rectangle{
                    width: parent.width
                    height: parent.height
                    color: bp.backgroundColor

                    ListView{
                        id: list
                        width: parent.width
                        height: parent.height
                        spacing: dp(1)
                        clip: true
                        model: ['Кафе', 'Ресторани']
                        antialiasing: true
                        visible: bp.visiblePage(1)
                        delegate: Rectangle {
                            id: name
                            width: parent.width
                            height: Theme.listItem.minimumHeight *2
                            color: "red"
                            Text {
                                text: qsTr(modelData)
                            }
                        }
                    }
                }
            }*/
    }

    Item{
        id: footer
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: app.height * 0.08
        RowLayout{
            id: rowLayout
            anchors.fill: parent
            spacing: 0

            Button{
                id: events
                Layout.preferredWidth: parent.width/bp.count_categories
                Layout.preferredHeight: parent.height
                pressedIconState: "../img/event_red.png"
                unpressedIconState: "../img/event_white.png"
                textButton: "Events"
                idCategorie: 1
                currentIdSelect: bp.currentPageId
            }
            Button{
                id: categories
                Layout.preferredWidth: parent.width/bp.count_categories
                Layout.preferredHeight: parent.height
                pressedIconState: "../img/category_red.png"
                unpressedIconState: "../img/category_white.png"
                textButton: "Category"
                idCategorie: 2
                currentIdSelect: bp.currentPageId
            }
            Button{
                id: categories4
                Layout.preferredWidth: parent.width/bp.count_categories
                Layout.preferredHeight: parent.height
                pressedIconState: "../img/favorite_red.png"
                unpressedIconState: "../img/favorite_white.png"
                textButton: "Favorite"
                idCategorie: 3
                currentIdSelect: bp.currentPageId
            }
            Button{
                id: settings
                Layout.preferredWidth: parent.width/bp.count_categories
                Layout.preferredHeight: parent.height
                pressedIconState: "../img/settings_red.png"
                unpressedIconState: "../img/settings_white.png"
                textButton: "Settings"
                idCategorie: 4
                currentIdSelect: bp.currentPageId
            }
        }
    }
}
