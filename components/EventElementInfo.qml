import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import '../'

Item {
    property string sourceFile: ""
    property string text_information: ""
    property alias ref_text: text

    Image{
        id: icon
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        height: BaseProperty.heightDelegate/2
        width: height
        source: sourceFile
        antialiasing: true
    }

    Text {
        id: text
        anchors.left: icon.right
        anchors.leftMargin: dp(BaseProperty.half_margin)
        anchors.right: parent.right
        height: BaseProperty.heightDelegate
        text: text_information
        verticalAlignment: Text.AlignVCenter
        color: BaseProperty.colorTextDelegate
    }
}
