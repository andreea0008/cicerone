import QtQuick 2.13
import Felgo 3.0
import "../"

Rectangle {
    id: box
    anchors.fill: parent
    color: "transparent"
    Component.onCompleted: {
        redBox.state = "visible"
    }

    Rectangle{
        id: redBox
//        anchors.fill: parent
        color: BaseProperty.backgroundColor

        x: parent.width
        y: parent.height

        width: 0; height: 0;

        states: [
            State {
                name: "visible"
//                when: box.visible
                PropertyChanges {
                    target: redBox
                    x: 0; y: 0
                    width: box.width; height: box.height
                    opacity: 1.0
                }
            },
            State {
                name: "unvisible"
//                when: !box.visible
                PropertyChanges {
                    target: redBox
                    x: 0; y: 0
                    width: box.width; height: box.height
                    opacity: 1.0
                }
            }
        ]

        Behavior on x {
            NumberAnimation { duration: 500 }

        }
        Behavior on y {
            NumberAnimation { duration: 500 }
        }
        OpacityAnimator on opacity{
            from: 0;
            to: 1;
            duration: 1000
        }

//        transitions: [
//            Transition {
//                NumberAnimation { property: "opacity"; duration: 500}
//            }
//        ]
    }

    MouseArea{
        anchors{
            top: parent.top
            right: parent.right
            topMargin: dp(30)
            rightMargin: dp(15)
        }
        width: BaseProperty.whCloseMouseArea
        height: BaseProperty.whCloseMouseArea


        Image{
            id: closeOverviewScreen
            anchors.centerIn: parent
            width: BaseProperty.whIcon
            height: BaseProperty.whIcon
            source: "qrc:/img/close_icon.png"
        }
        Rectangle {
            anchors.fill: parent
            color: "red"
            opacity: 0.2
        }

        onPressed: app.hideEvent()
    }

    Text {
        id: name
        anchors.centerIn: parent
        color: "#fff"
        text: qsTr("this need to be info about\nevent in this location")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font: BaseProperty.fontLoader.name
    }
}
