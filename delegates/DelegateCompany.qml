import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.13
import "../"

Rectangle {
    height: BaseProperty.heightDelegate
    color: BaseProperty.backgroundDelegateColor

    property alias text: label.text
//    property BaseProperty bp: BaseProperty{}
    
    signal relesed()

    Text {
        id: label
        anchors.fill: parent
        anchors.leftMargin: dp(15)
        text: qsTr(modelData)
        verticalAlignment: Text.AlignVCenter
        color: BaseProperty.text_color
        font.family: BaseProperty.fontLoader.name
        font.pixelSize: BaseProperty.h1
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onPressed: parent.color = BaseProperty.pressed_color
        onCanceled: parent.color = BaseProperty.backgroundDelegateColor
        onExited: parent.color = BaseProperty.backgroundDelegateColor
        onReleased: {
            parent.color = BaseProperty.backgroundDelegateColor
            relesed()
        }
    }
}
