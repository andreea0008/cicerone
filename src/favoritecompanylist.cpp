#include "favoritecompanylist.h"
#include <QDebug>
#include "settings.h"
#include <QJsonObject>
#include <QDebug>

FavoriteCompanyList::FavoriteCompanyList(QObject *parent)
    : CompanyListByCategory(parent)
{

//    allCompanies =
      auto comp =       Settings::Instance()->loadFavoriteListCompany();
      qDebug() << "FavoriteCompanyList constructor: " << __LINE__ << comp.size();
      for(auto company : comp){
          qDebug() << company->getNameCompany();
          addCompany(company);
      }
//    qDebug() << allCompanies.size();
//    const auto list = Settings::Instance()->loadFavoriteListCompany();
//    allCompanies = QVector<Company*>{new Company("dfdsf")};
//    for(int index = 0; index < list.size(); index++){
//        addCompany(list[index]);
//    }
//    addCompany(new Company("dcdcd"));
//    qDebug() << "SIZE: " << __FUNCTION__ << allCompanies.size();
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
    qDebug() << "addCompanyToFavorite: " << allCompanies.size();

    qDebug() <<__FUNCTION__ << nameCompany;
    for(int i = 0; i < allCompanies.size(); i++)
    {
        Company* currentCompany = allCompanies.at(i);
        if(currentCompany->getNameCompany() == nameCompany)
        {
            qDebug() << "found" << currentCompany->getNameCompany();
            currentCompany->setIsFavorite(true);

            addCompany(currentCompany);
            break;
        }
    }
//    refresh();
    qDebug() << allCompanies.size();
    saveSettings();
}

void FavoriteCompanyList::removeCompanyFromFavorite(QString companyName)
{
    beginResetModel();
    for(int i = 0; i < allCompanies.size(); i++)
    {
        Company* currentCompany = allCompanies.at(i);
        if(currentCompany->getNameCompany() == companyName)
        {
            currentCompany->setIsFavorite(false);
            break;
        }
    }
    endResetModel();
}

void FavoriteCompanyList::saveSettings()
{
    qDebug() << __FUNCTION__ << filteredCompany.size();
    Settings::Instance()->saveFavoriteListCompany(filteredCompany);
}

void FavoriteCompanyList::loadSettings()
{
    Settings::Instance()->loadFavoriteListCompany();
}

