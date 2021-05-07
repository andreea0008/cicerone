import QtQuick 2.12
import Felgo 3.0
import QtQuick.Layouts 1.3
import "../"

RowLayout {
    width: 300
    height: BaseProperty.heightDelegate

    property string textInformation: ""
    property string type:           ""
    property string latPosition: ""
    property string lngPosition: ""

    signal pressedAndHold(var clipText)

    Icon{
        id: icon
        icon: getLogoByType()
        Layout.alignment: Qt.AlignVCenter
        color: BaseProperty.red
        antialiasing: true
    }

    Text{
        id: informText
        verticalAlignment: Text.AlignVCenter
        text: textInformation
        Layout.preferredHeight: dp(BaseProperty.heightDelegate)
        color: BaseProperty.colorTextDelegate
        font.family: fontLoader.name
        font.pixelSize: sp(BaseProperty.h2)
        Layout.fillWidth: true
        wrapMode: Text.Wrap

        FontLoader{
            id: fontLoader
            source: "../fonts/Roboto-Medium.ttf"
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onPressAndHold: {
                pressedAndHold(informText.text)
                runEvent()
            }
        }
    }

    function getLogoByType()
    {
        if(type === "call")
            return IconType.phonesquare;

        else if (type === "facebook")
            return IconType.facebooksquare;

        else if (type == "instagram")
            return IconType.instagram;
        else if (type === "mail")
            return IconType.envelopesquare;
        else if (type === "location")
            return IconType.mapmarker
        else if (type === "schedule")
            return IconType.clocko
    }

    function runEvent()
    {
        if(type == "call")
            Qt.openUrlExternally("tel:%1".arg(informText.text))
        else if(type == "facebook")
            Qt.openUrlExternally("https://www.facebook.com/MAXIMGalaxy/")
        else if(type == "instagram")
            Qt.openUrlExternally("https://www.instagram.com/maximmagazinerussia")
        else if(type == "location")
            Qt.openUrlExternally("https://www.google.com/maps/@"+latPosition+","+lngPosition)
        console.log(lat, lng)
    }
}
