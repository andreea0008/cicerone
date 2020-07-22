#ifndef FAVORITECOMPANYLIST_H
#define FAVORITECOMPANYLIST_H

#include <QObject>
#include "companylistbycategory.h"

class FavoriteCompanyList : public CompanyListByCategory
{
    Q_OBJECT
public:
    FavoriteCompanyList(QObject *parent = nullptr);
    ~FavoriteCompanyList();

public slots:
    void refresh();
    void addCompanyToFavorite(QString nameCompany);
    void removeCompanyFromFavorite(QString companyName);

private:
    void saveSettings();
    void loadSettings();
};

#endif // FAVORITECOMPANYLIST_H
