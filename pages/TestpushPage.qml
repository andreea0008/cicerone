import QtQuick 2.0
import "../components"

Item{
    width: parent.width
    height: parent.height
    Finder{ id: finder; properties: bp }

    ListView{
        id: list
        width: parent.width
        anchors.top: finder.bottom
        anchors.bottom: parent.bottom
        spacing: dp(1)
        clip: true
        model: ['Кафе', 'Ресторани', 'Кафе', 'Ресторани', 'Кафе', 'Ресторани']
        antialiasing: true
        delegate: Rectangle {
            id: delegate
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: dp(2)
            anchors.rightMargin: dp(2)
            height: bp.heightDelegate
            color: bp.backgroundDelegateColor
            property int lrMar
            state: "hide"
            Column{
                id: columnInformation
                anchors.fill: parent
                anchors.leftMargin: dp(15)
                anchors.rightMargin: dp(15)

                Text {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: bp.heightDelegate
                    text: qsTr(modelData)
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                }
                Rectangle{
                    id: redSpacer
                    height: 1
                    width: parent.width
                    color: bp.red_line_color
                }

                InformationItem{
                    visible: redSpacer.visible
                    baseProperty: bp
                    textInformation: "ddededede"
                }

                Text{
                    id: addresss
                    visible: redSpacer.visible
                    text: "ddfrfvr rfrferf ref erfref"
                    height: bp.heightDelegate
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                    width: bp.heightDelegate
                }
            }


            MouseArea{
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onReleased: delegate.state = (delegate.state === "hide") ? "show" : "hide"
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
                },
                State {
                    name: "show"
                    PropertyChanges {
                        target: delegate
                        height: bp.heightDelegate *3
                        color: "#343339"
                    }

                    PropertyChanges {
                        target: redSpacer
                        visible: true
                        width: columnInformation.width
                    }
                }
            ]

            transitions: [
                Transition {
                    from: "hide"
                    to: "show"
                    NumberAnimation { target: redSpacer; properties: "width" }
                },
                Transition {
                    from: "show"
                    to: "hide"
                    NumberAnimation { target: redSpacer; properties: "width" }
                }

            ]
        }
    }
}
