import Felgo 3.0
import QtQuick 2.12
import QtQuick.Layouts 1.12
import "."

Rectangle{
    id: topHead
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: app.height * 0.1
    color: BaseProperty.backgroundColor

    property FontLoader fontloader
    property bool filterBtnVisible: false
    property alias backArrowVisible: backArrow.visible

    signal pressedArrowButton(var categoryId)
    signal filterPressed()

    RowLayout {
        anchors {
            top: parent.verticalCenter
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        IconButton {
            id: backArrow
            Layout.preferredWidth: height
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
            icon: IconType.longarrowleft
            size: BaseProperty.whIcon
            color: BaseProperty.white
            onPressed: pressedArrowButton(BaseProperty.currentPageId)
        }

        Text{
            id: textGuideIf
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
            font.pixelSize: sp(28)
            color: BaseProperty.text_color
            text: "Cicerone"
            font.bold: true
            font.family: fontloader.name
        }

        IconButton {
            Layout.preferredWidth: height
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
            visible: filterBtnVisible
            icon: IconType.sliders
            size: BaseProperty.whIcon
            color: BaseProperty.white
            onPressed: filterPressed()
        }
    }

    Rectangle{
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: sp(1)
        color: BaseProperty.red_line_color
    }
}
