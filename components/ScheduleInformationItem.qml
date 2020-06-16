import QtQuick 2.0
import Felgo 3.0
import "../"

Row {
    width: 300
    height: BaseProperty.heightDelegate
    spacing: height /8

    property string textInformation: ""
    property bool isBreakHourNow: false

    signal pressedAndHold(var clipText)

    Image{
        source: isBreakHourNow ? "qrc:/img/delegate_icons/lock_schedule.png"
                               : "qrc:/img/delegate_icons/unlock_schedule.png"

        width: BaseProperty.heightDelegate /2
        height: width
        antialiasing: true
        anchors.verticalCenter: parent.verticalCenter
    }

    Text{
        verticalAlignment: Text.AlignVCenter
        text: textInformation
        height: BaseProperty.heightDelegate
        color: BaseProperty.colorTextDelegate
        font.family: fontLoader.name
        font.pixelSize: BaseProperty.h2

        FontLoader{
            id: fontLoader
            source: "../fonts/Roboto-Medium.ttf"
        }
    }
}
