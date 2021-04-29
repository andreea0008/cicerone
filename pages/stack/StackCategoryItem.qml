import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.13

import "../../components"
import "../../delegates"
import "../../"
import "."

Item
{
    id: stackCategoryItem
    anchors.fill: parent
    visible: BaseProperty.visiblePage(2)
    property alias depthCount: stackCategory.depth
    property alias categoryStack: stackCategory
    onVisibleChanged: if(!visible) stackCategory.pop()

    StackView{
        id: stackCategory
        width: parent.width
        height: parent.height
        visible: true
        focus: true
        initialItem: Rectangle{
            width: parent.width
            height: parent.height
            color: BaseProperty.backgroundColor
            
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
                    onRelesed: {
                        CompanyList.filterCompanyByCategoryIndex(categoryId)
                        stackCategory.push("BusinessDelegatePage.qml")
                    }
                }
            }
        }
    }
}
