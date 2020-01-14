#ifndef FAVORITECOMPANYLIST_H
#define FAVORITECOMPANYLIST_H

#include <QObject>
#include "companylistbycategory.h"

class FavoriteCompanyList : public CompanyListByCategory
{
public:
    FavoriteCompanyList(CompanyListByCategory *parent);
};

#endif // FAVORITECOMPANYLIST_H
