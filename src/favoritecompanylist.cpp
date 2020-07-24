#include "favoritecompanylist.h"
#include <QDebug>
#include "settings.h"
#include <QJsonObject>
#include <QDebug>

FavoriteCompanyList::FavoriteCompanyList(QObject *parent)
    : CompanyListByCategory(parent)
{
    //    refresh();
    allCompanies = Settings::Instance()->loadFavoriteListCompany();
//    qDebug() << allCompanies.size();
    const auto list = Settings::Instance()->loadFavoriteListCompany();
    for(int index = 0; index < list.size(); index++){
        addCompany(list[index]);
    }
//    qDebug() << allCompanies.size();
//    beginResetModel();
//    endResetModel();
}

FavoriteCompanyList::~FavoriteCompanyList()
{
}

void FavoriteCompanyList::refresh()
{
    filteredCompany.clear();
    for(int i = 0; i < allCompanies.size(); i++)
    {
        auto currentCompany = allCompanies.at(i);
        if(currentCompany->getIsFavorite())
        {
            addCompany(currentCompany);
        }
    }
    saveSettings();
}

void FavoriteCompanyList::addCompanyToFavorite(QString nameCompany)
{
    for(int i = 0; i < allCompanies.size(); i++)
    {
        Company* currentCompany = allCompanies.at(i);
        if(currentCompany->getNameCompany() == nameCompany)
        {
            currentCompany->setIsFavorite(true);
            addCompany(currentCompany);
            break;
        }
    }
    saveSettings();
}

void FavoriteCompanyList::removeCompanyFromFavorite(QString companyName)
{
    for(int i = 0; i < allCompanies.size(); i++)
    {
        Company* currentCompany = allCompanies.at(i);
        if(currentCompany->getNameCompany() == companyName)
        {
            currentCompany->setIsFavorite(false);
            break;
        }
    }
    beginResetModel();
    endResetModel();
}

void FavoriteCompanyList::saveSettings()
{
    Settings::Instance()->saveFavoriteListCompany(filteredCompany);
}

void FavoriteCompanyList::loadSettings()
{
    Settings::Instance()->loadFavoriteListCompany();
}

