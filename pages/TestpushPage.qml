import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../delegates"
import "../components"
import "../"

Item{
    //width: parent.width
    //height: parent.height
    Finder{ id: finder; properties: bp }

    ListView{
        id: list
        width: parent.width
        anchors.top: finder.bottom
        anchors.bottom: parent.bottom
        spacing: dp(1)
        clip: true
        model: CompanyList
        antialiasing: true
        delegate: DelegateLocaleBusinessItem {
            id: delegate
            anchors.left: parent.left
            anchors.right: parent.right
            color: bp.backgroundDelegateColor
            height: bp.heightDelegate
            state: "show"
            companyName: NameCompany
            isFavorite: IsFavorite
            address: Address
            scheduleByCurrentDate: Schedule
            facebook: FacebookLink
            onIsFavoriteChanged:
            {
                if(isFavorite){
                    CompanyList.changeIsFavoriteProperty(index, true)
                    FavoriteCompanyList.addCompanyToFavorite(companyName)
                }
                else{
                    CompanyList.changeIsFavoriteProperty(index, false)
                    FavoriteCompanyList.removeCompany(companyName)
                }
            }
        }
    }
}
