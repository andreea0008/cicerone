import QtQuick 2.12
import QtQuick.Layouts 1.3
import Felgo 3.0

import "../components"
import "../"

Rectangle {
    id: delegate
    anchors.leftMargin: dp(2)
    anchors.rightMargin: dp(2)
    property int lrMar
    property bool isFavorite
    property string eventTitle: "Event_title"
    property string descriptionEvent: ""
    property string where: "address"
    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onReleased: delegate.state = (delegate.state === "hide") ? "show" : "hide"
    }

    Column{
        id: columnInformation
        anchors.fill: parent
        anchors.leftMargin: dp(15)
        anchors.rightMargin: dp(15)

        Item{
            anchors.left: parent.left
            anchors.right: parent.right
            height: BaseProperty.heightDelegate


            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                color: "white"
                font.family: BaseProperty.fontLoader.name
                font.pixelSize: BaseProperty.h1
                text: eventTitle
            }
        }

        Rectangle {
            id: redSpacer
            height: 1
            width: parent.width
            color: BaseProperty.red_line_color
        }

        Item {
            id: itemMainDescription
            anchors.left: parent.left
            anchors.right: parent.right
            height: BaseProperty.doubleHeightDelegate
            Text{
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.verticalCenter
                color: "white"
                font.family: BaseProperty.fontLoader.name
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: BaseProperty.h1
                text: where
            }

            Text{
                anchors.left: parent.left
                anchors.top: parent.verticalCenter
                anchors.bottom: parent.bottom
                color: "white"
                font.family: BaseProperty.fontLoader.name
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: BaseProperty.h1
                text: where
            }

            Rectangle{
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                width: parent.height /2
                height: width
                color: BaseProperty.red_line_color
                radius: height /8
                opacity: mouseId.pressed ? 0.8 : 1.0

                Image{
                    source: "../img/delegate_icons/right_arrow.png"
                    width: parent.width * 0.5
                    height: width
                    anchors.centerIn: parent
                    antialiasing: true
                }

                MouseArea{
                    id: mouseId
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: stackEvents.push("../pages/DetailEventPage.qml", {"name_event": eventTitle,
                                                "descriptio_event": descriptionEvent})
                }
            }
        }
    }


    states: [
        State {
            name: "hide"
            PropertyChanges {
                target: delegate
                height: BaseProperty.heightDelegate
                color: BaseProperty.backgroundDelegateColor
            }

            PropertyChanges {
                target: redSpacer
                visible: false
                width: 0
            }

            PropertyChanges {
                target: itemMainDescription
                visible: false
            }
        },
        State {
            name: "show"
            PropertyChanges {
                target: delegate
                height: BaseProperty.heightDelegate *3.2
                color: BaseProperty.pressed_color
            }

            PropertyChanges {
                target: redSpacer
                visible: true
                width: columnInformation.width
            }

            PropertyChanges {
                target: itemMainDescription
                visible: true
            }
        }
    ]

    //    transitions: [
    //        Transition {
    //            from: "hide"
    //            to: "show"
    //            NumberAnimation { target: redSpacer; properties: "width" }
    //        },
    //        Transition {
    //            from: "show"
    //            to: "hide"
    //            NumberAnimation { target: redSpacer; properties: "width" }
    //        }
    //    ]
}
