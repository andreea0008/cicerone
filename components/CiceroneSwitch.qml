import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.12
import "../"

AppSwitch{
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    backgroundColorOn: bp.red_line_color
    backgroundColorOff: bp.pressed_color
    backgroundColorOffPressed: bp.red_line_color
    knobBorderColor: bp.selected_color
    knobColorOff: bp.red_line_color
    knobColorOn: bp.selected_color
}
