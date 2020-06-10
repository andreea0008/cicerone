import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.12
import "../"

AppSwitch{
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    backgroundColorOn: BaseProperty.red_line_color
    backgroundColorOff: BaseProperty.pressed_color
    backgroundColorOffPressed: BaseProperty.red_line_color
    knobBorderColor: BaseProperty.selected_color
    knobColorOff: BaseProperty.red_line_color
    knobColorOn: BaseProperty.selected_color
}
