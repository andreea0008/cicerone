import QtQuick 2.12
import QtQuick.Layouts 1.12
import Felgo 3.0
import "../"

RowLayout {
    width: 300
    height: BaseProperty.heightDelegate

    property string textInformation: ""
    property bool isBreakHourNow: false

    signal pressedAndHold(var clipText)

    Icon{
        icon: isBreakHourNow ? IconType.lock : IconType.unlock
        color: BaseProperty.red
    }

    Text{
        verticalAlignment: Text.AlignVCenter
        text: textInformation
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: BaseProperty.colorTextDelegate
        font.family: fontLoader.name
        font.pixelSize: sp(BaseProperty.h2)

        FontLoader{
            id: fontLoader
            source: "../fonts/Roboto-Medium.ttf"
        }
    }
}
