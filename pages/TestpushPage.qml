import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../delegates"
import "../components"
import "../"

Item{
    Finder{
        id: finder;
        properties: bp
        onTextChanged: CompanyList.searchCompanyByNameInFilteringList(text)
    }

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
            companyName: NameCompany
            isFavorite: IsFavorite
            address: Address
            scheduleByCurrentDate: Schedule
            facebook: FacebookLink
            onPressedFavorite: pressFavorite(index, companyName, isFavorite);
        }
    }

    function pressFavorite(index, companyName, isFavorite){
        if(isFavorite){
            CompanyList.changeIsFavoriteProperty(index, true)
            FavoriteCompanyList.addCompanyToFavorite(companyName)
        } else {
            FavoriteCompanyList.removeCompany(companyName)
            CompanyList.changeIsFavoriteProperty(index, false)
        }
    }
}
