import QtQuick 2.12
import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.13
import "../../components"
import "../../delegates"
import "../../"

Item
{
    anchors.fill: parent
    visible: BaseProperty.visiblePage(3)

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

            Text{
                anchors.centerIn: parent
                visible: listViewFavoriteCategory.count === 0
                text: qsTr("Тут поки пусто")
                color: BaseProperty.text_color
                font.family: BaseProperty.fontLoader.name
                font.pixelSize: sp(BaseProperty.h1)
            }
            
            ListView{
                id: listViewFavoriteCategory
                width: parent.width
                height: parent.height
                spacing: dp(1)
                clip: true
                model: FavoriteCompanyList
                onModelChanged: console.log("favorite_model_changed")
                antialiasing: true
                delegate: DelegateLocaleBusinessItem {
                    width: listViewFavoriteCategory.width
                    height: dp(BaseProperty.heightDelegate)
                    color: BaseProperty.backgroundDelegateColor
                    companyName: NameCompany
                    isFavorite: IsFavorite
                    address: Address
//                                        scheduleByCurrentDate: Schedule
                    locateInFavoriteCategory: true
                    facebook: FacebookLink

                    onRemoveFromFavoriteList: {
                        CompanyList.changeIsFavoriteProperty(companyName, false)
                        FavoriteCompanyList.removeCompanyFromFavorite(companyName)
                    }
                }
            }
        }
    }
}
