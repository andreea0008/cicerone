import QtQuick 2.12
import Felgo 3.0
import "."
Rectangle{
    id: topHead
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: app.height * 0.1
    color: BaseProperty.backgroundColor

    property FontLoader fontloader
    property alias backArrowVisible: backArrow.visible

    signal pressedArrowButton(var categoryId)

    Text{
        id: textGuideIf
        anchors.left: backArrow.visible ? backArrow.right : parent.left
        anchors.leftMargin: parent.height / 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: sp(5)
        font.pixelSize: sp(28)
        color: BaseProperty.text_color
        text: "Cicerone"
        font.bold: true
        font.family: fontloader.name
    }

    AppImage {
        id: backArrow
        height: textGuideIf.height * 0.5
        width: height
        anchors.left: parent.left
        anchors.leftMargin: height / 2
        anchors.verticalCenter: textGuideIf.verticalCenter
        source: "img/left-arrow.png"
        MouseArea{
            anchors.fill: parent
            onReleased: pressedArrowButton(BaseProperty.currentPageId)
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
