import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.13
import "../../components"
import "../../delegates"

Item
{
    anchors.fill: parent
    visible: bp.visiblePage(3)

    StackView{
        id: stackCategory
        width: parent.width
        height: parent.height
        visible: true
        focus: true
        initialItem: Rectangle{
            width: parent.width
            height: parent.height
            color: bp.backgroundColor

            Text{
                anchors.centerIn: parent
                visible: listViewFavoriteCategory.count === 0
                text: qsTr("Тут поки пусто")
                color: bp.text_color
                font.family: bp.fontLoader.name
                font.pixelSize: bp.h1
            }
            
            ListView{
                id: listViewFavoriteCategory
                width: parent.width
                height: parent.height
                spacing: dp(1)
                clip: true
//                model: ['Кафе', 'Ресторани', 'Кафе', 'Ресторани', 'Кафе', 'Ресторани']
                antialiasing: true
                delegate: DelegateCompany {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: dp(1)
                    anchors.rightMargin: dp(1)
                    onRelesed: stackCategory.push("pages/TestpushPage.qml")
                }
            }
        }
    }
}
