import QtQuick 2.0
import "../../"
Rectangle {
    id: splash
    anchors.fill: parent
    property bool isLoaded: Category.isLoaded
    color: BaseProperty.backgroundColor

    onIsLoadedChanged: {
        if(isLoaded)
            timer.start()
        else
            splash.visible = true
    }

    Timer{
        id: timer
        interval: 6000
        onTriggered: splash.visible = false
    }

    Image{
        id: imageCompany
        anchors.centerIn: parent
        width: parent.width /8
        height: width
        antialiasing: true
        source: "qrc:/img/delegate_icons/128x128/favorite_check.png"
    }
    Text{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: imageCompany.bottom
        anchors.topMargin: dp(10)
        text: "created by Leochko"
        color: BaseProperty.colorTextDelegate
    }
}
