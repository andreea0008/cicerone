import QtQuick 2.0
import "../"
Rectangle {
    id: box
    anchors.fill: parent
    color: BaseProperty.backgroundColor

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
