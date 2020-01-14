#include "favoritecompanylist.h"
#include <QDebug>

FavoriteCompanyList::FavoriteCompanyList(CompanyListByCategory *parent)
    : CompanyListByCategory(parent)
{
    addCompany(new Company("cdcdcdcdcd"));
}

