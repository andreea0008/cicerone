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
        Component.onCompleted: CompanyList.isFavoriteList = false
        onVisibleChanged: CompanyList.isFavoriteList = false
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
            onIsFavoriteChanged:
            {
                CompanyList.changeIsFavoriteProperty(index, isFavorite)
                if(isFavorite)
                    FavoriteCompanyList.addCompanyToFavorite(companyName)
                else
                    FavoriteCompanyList.removeCompany(companyName)
            }
        }
    }
}
