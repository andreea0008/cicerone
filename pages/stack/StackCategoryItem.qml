import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.13
import "../../components"
import "../../delegates"

Item
{
    id: stackCategoryItem
    anchors.fill: parent
    visible: bp.visiblePage(2)
    property alias depthCount: stackCategory.depth
    property alias categoryStack: stackCategory

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
            
            ListView{
                id: listViewCategory
                width: parent.width
                height: parent.height
                spacing: dp(1)
                clip: true
                model: Category
                antialiasing: true
                delegate: DelegateCompany {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: dp(1)
                    anchors.rightMargin: dp(1)
                    text: categoryName
                    onRelesed: stackCategory.push("../TestpushPage.qml")
                }
            }
        }
    }
}
