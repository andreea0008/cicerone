#include "favoritecompanylist.h"
#include <QJsonObject>
#include "settings.h"

FavoriteCompanyList::FavoriteCompanyList(QObject *parent)
    : CompanyListByCategory(parent)
{
      auto loadedCompanies = Settings::Instance()->loadFavoriteListCompany();
      for (int allCompanyIndex = 0; allCompanyIndex < allCompanies.size(); allCompanyIndex++)
      {
          for (int savedCompanyIndex = 0; savedCompanyIndex < loadedCompanies.size(); savedCompanyIndex++)
          {
              if(allCompanies[allCompanyIndex]->id() == loadedCompanies[savedCompanyIndex])
              {
                auto favoriteLoadedCompany = allCompanies[allCompanyIndex];
                addCompany(favoriteLoadedCompany);
              }
          }
      }
}

FavoriteCompanyList::~FavoriteCompanyList()
{
}

void FavoriteCompanyList::refresh()
{
    filteredCompany.clear();
    for(int i = 0; i < filteredCompany.size(); i++)
    {
        auto currentCompany = filteredCompany.at(i);
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
            QModelIndex topLeft = createIndex(i,0);
            dataChanged(topLeft, topLeft);
            break;
        }
    }
    saveSettings();
}

void FavoriteCompanyList::removeCompanyFromFavorite(QString nameCompany)
{
    for(int i = 0; i < filteredCompany.size(); i++)
    {
        Company* currentCompany = filteredCompany.at(i);
        if(currentCompany->getNameCompany() == nameCompany)
        {
            currentCompany->setIsFavorite(false);
            beginRemoveRows(QModelIndex(), i,i);
            filteredCompany.remove(i);
            endRemoveRows();
        }
    }
    saveSettings();
}

void FavoriteCompanyList::saveSettings()
{
    Settings::Instance()->saveFavoriteListCompany(filteredCompany);
}

void FavoriteCompanyList::loadSettings()
{
    Settings::Instance()->loadFavoriteListCompany();
}

