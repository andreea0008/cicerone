#ifndef FAVORITECOMPANYLIST_H
#define FAVORITECOMPANYLIST_H

#include <QObject>
#include "companylistbycategory.h"

class FavoriteCompanyList : public CompanyListByCategory
{
    Q_OBJECT
public:
    FavoriteCompanyList(QObject *parent = nullptr);

    Q_INVOKABLE void refresh();
    Q_INVOKABLE void addCompanyToFavorite(QString nameCompany);
    Q_INVOKABLE void removeCompanyFromFavorite(QString companyName);
};

#endif // FAVORITECOMPANYLIST_H
