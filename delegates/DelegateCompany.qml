import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.13
import "../"

Rectangle {
    height: bp.heightDelegate
    color: bp.backgroundDelegateColor

    property alias text: label.text
    property BaseProperty bp: BaseProperty{}
    
    signal relesed()

    Text {
        id: label
        anchors.fill: parent
        anchors.leftMargin: dp(15)
        text: qsTr(modelData)
        verticalAlignment: Text.AlignVCenter
        color: bp.text_color
        font.family: bp.fontLoader.name
        font.pixelSize: bp.h1
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onPressed: parent.color = bp.pressed_color
        onCanceled: parent.color = bp.backgroundDelegateColor
        onExited: parent.color = bp.backgroundDelegateColor
        onReleased: {
            parent.color = bp.backgroundDelegateColor
            relesed()
        }
    }
}
