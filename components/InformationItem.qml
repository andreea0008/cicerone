import QtQuick 2.0
import Felgo 3.0

Row {
    width: 300
    height: baseProperty.heightDelegate
    spacing: height /8

    property string textInformation: ""
    property string type:           ""

    property QtObject baseProperty

    signal pressedAndHold(var clipText)

    Image{
        id: icon
        source: getLogoByType()
        width: baseProperty.heightDelegate /2
        height: width
        antialiasing: true
        anchors.verticalCenter: parent.verticalCenter
    }

    Text{
        id: informText
        verticalAlignment: Text.AlignVCenter
        text: textInformation
        height: baseProperty.heightDelegate
        color: baseProperty.colorTextDelegate
        font.family: fontLoader.name
        font.pixelSize: baseProperty.h2

        FontLoader{
            id: fontLoader
            source: "../fonts/Roboto-Medium.ttf"
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onPressAndHold: pressedAndHold(informText.text)
            onPressed: runEvent()
        }
    }

    function getLogoByType()
    {
        if(type === "call")
            return "../img/delegate_icons/call.png"
        else if (type === "facebook")
            return "../img/delegate_icons/facebook.png"
        else if (type == "instagram")
            return "../img/delegate_icons/instagram.png"
        else if (type === "mail")
            return "../img/delegate_icons/mail.png"
        else if (type === "location")
            return "../img/delegate_icons/location.png"
        else if (type === "schedule")
            return "../img/delegate_icons/schedule.png"
    }

    function runEvent()
    {
//        if(type == "call")
//            Qt.openUrlExternally("tel:%1".arg(informText.text))
//        else if(type == "facebook")
//            Qt.openUrlExternally("https://www.facebook.com/MAXIMGalaxy/")
//        else if(type == "instagram")
//            Qt.openUrlExternally("https://www.instagram.com/maximmagazinerussia")
//        else if(type == "location")
//            Qt.openUrlExternally("https://www.google.com/maps/@50.4283136,30.5316465,14z")
    }
}
