import QtQuick 2.12
import Felgo 3.0
import QtQuick.Controls 2.1
import "../"

Rectangle{
    id: box
    color: BaseProperty.backgroundColor
    property string iconType: IconType.camera
    property string pressedIconState: ""
    property string unpressedIconState: ""
    property string textButton: ""

    property real koefHeight: 0.35
    property bool isChecked: false
    property int idCategorie: 999
    property int currentIdSelect: 888

    onCurrentIdSelectChanged: {
        if(currentIdSelect != idCategorie)
            isChecked = false
        else
            isChecked = true
    }

    Icon {
        id: img
        height: parent.height * koefHeight
        width: height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        icon: box.iconType
        color: isChecked ? BaseProperty.red : BaseProperty.white
    }

    Text{
        anchors.top: img.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: textButton
        color: BaseProperty.text_color
        font.family: BaseProperty.fontLoader.name
    }

    MouseArea{
        anchors.fill: parent
        onPressed: {
            BaseProperty.currentPageId = idCategorie
        }
    }
}
