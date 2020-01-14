import QtQuick 2.0
import QtQuick.Layouts 1.3

import "../components"
import "../"

Rectangle {
    id: delegate
    anchors.leftMargin: dp(2)
    anchors.rightMargin: dp(2)
    property int lrMar
    property bool isFavorite
    property string eventTitle: "Event_title"
    property string where: "address"

    property BaseProperty bp: BaseProperty{}

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
            height: bp.heightDelegate


            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                color: "white"
                font.family: bp.fontLoader.name
                font.pixelSize: bp.h1
                text: eventTitle
            }
        }

        Rectangle {
            id: redSpacer
            height: 1
            width: parent.width
            color: bp.red_line_color
        }

        Item {
            id: itemMainDescription
            anchors.left: parent.left
            anchors.right: parent.right
            height: bp.doubleHeightDelegate
            Text{
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.verticalCenter
                color: "white"
                font.family: bp.fontLoader.name
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: bp.h1
                text: where
            }

            Text{
                anchors.left: parent.left
                anchors.top: parent.verticalCenter
                anchors.bottom: parent.bottom
                color: "white"
                font.family: bp.fontLoader.name
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: bp.h1
                text: where
            }

            Rectangle{
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                width: parent.height /2
                height: width
                color: bp.red_line_color
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
                    onClicked: stackEvents.push("../pages/DetailEventPage.qml")
                }
            }
        }
    }


    states: [
        State {
            name: "hide"
            PropertyChanges {
                target: delegate
                height: bp.heightDelegate
                color: bp.backgroundDelegateColor
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
                height: bp.heightDelegate *3.2
                color: bp.pressed_color
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
