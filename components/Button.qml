import QtQuick 2.0
import QtQuick.Controls 2.1

Rectangle{
    id: box
    color: bp.backgroundColor
    property string pressedIconState: ""
    property string unpressedIconState: ""
    property string textButton: ""

    property real koefHeight: 0.5
    property bool isChecked: false
    property int idCategorie: 999
    property int currentIdSelect: 888

    signal menuCategoryChange(var idCategory)
    signal pressCheckedButton()

    onCurrentIdSelectChanged: {
        if(currentIdSelect != idCategorie)
            isChecked = false
        else
            isChecked = true
    }

    Image{
        id: img
        height: parent.height * koefHeight
        width: height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        antialiasing: true
        source: isChecked ? pressedIconState : unpressedIconState
    }

    Text{
        anchors.top: img.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: textButton
        color: bp.text_color
    }

//    MouseArea{
//        anchors.fill: parent
//        onPressed: {
////            menuCategoryChange(idCategorie)
////            if(isChecked)
//                console.log(123)
////                pressCheckedButton()
////            isChecked = !isChecked
//        }
//    }
}
