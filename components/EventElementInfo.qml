import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import '../'

Item {
    property string sourceFile: ""
    property string text_information: ""
    property alias ref_text: text
    readonly property BaseProperty bp: BaseProperty{}

    Image{
        id: icon
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        height: bp.heightDelegate/2
        width: height
        source: sourceFile
        antialiasing: true
    }

    Text {
        id: text
        anchors.left: icon.right
        anchors.leftMargin: bp.half_margin
        anchors.right: parent.right
        height: bp.heightDelegate
        text: text_information
        verticalAlignment: Text.AlignVCenter
        color: bp.colorTextDelegate
    }
}
