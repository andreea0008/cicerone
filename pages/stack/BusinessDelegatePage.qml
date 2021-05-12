import QtQuick 2.12
import QtQuick.Controls 2.2
import Felgo 3.0
import QtGraphicalEffects 1.13

import "../../delegates"
import "../../components"
import "../../pages/stack"
import "../../"

Item{
    Finder{
        id: finder;
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
            width: parent.width
            color: BaseProperty.backgroundDelegateColor
            height: BaseProperty.heightDelegate
            companyName: NameCompany
            isFavorite: IsFavorite
            address: Address
            facebook: FacebookLnk
            instagram: InstagramLnk
            www: WwwLnk
            mail: EmailLnk
            onAddToFavoriteList: {
                CompanyList.changeIsFavoriteProperty(index, true)
                FavoriteCompanyList.addCompanyToFavorite(companyName)
            }

            onRemoveFromFavoriteList: {
                FavoriteCompanyList.removeCompany(companyName)
                CompanyList.changeIsFavoriteProperty(index, false)
            }
        }
    }
}
