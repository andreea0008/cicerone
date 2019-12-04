import QtQuick 2.0

Row {
    width: 200
    height: baseProperty.heightDelegate

    property string textInformation: ""
    property alias souce: icon.source

    property QtObject baseProperty

    Image{
        id: icon
        width: parent.height
        height: width
        antialiasing: true
    }

    Text{
        verticalAlignment: Text.AlignVCenter
        text: textInformation
        height: baseProperty.heightDelegate
        color: baseProperty.colorTextDelegate
    }
}
