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
                model: FavoriteCompanyList
                antialiasing: true
                delegate: DelegateLocaleBusinessItem {
                    id: delegate
                    anchors.left: parent.left
                    anchors.right: parent.right
                    color: bp.backgroundDelegateColor
                    height: bp.heightDelegate
                    state: "hide"
                    companyName: NameCompany
                    isFavorite: IsFavorite
                    onIsFavoriteChanged: {
                        if(!isFavorite){
                            FavoriteCompanyList.removeCompany(index)
                            CompanyList.changeIsFavoriteProperty(companyName, isFavorite)
                        }
                    }
                }
            }
        }
    }
}
