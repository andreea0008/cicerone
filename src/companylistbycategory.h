#ifndef COMPANYLISTBYCATEGORY_H
#define COMPANYLISTBYCATEGORY_H

#include <QObject>
#include <QAbstractItemModel>
#include <QVector>
#include "company.h"

class CompanyListByCategory : public QAbstractItemModel {
    Q_OBJECT

public:
    explicit CompanyListByCategory(QObject *parent = nullptr);
    ~CompanyListByCategory()override {}

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QModelIndex parent(const QModelIndex &child) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QModelIndex index(int row, int column, const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;

public slots:
    void addCompany(Company *company);
    void removeCompanyByIndex(int index);
    void removeCompany(QString companyName);
    void changeIsFavoriteProperty(const int index, bool isFavorite);
    void changeIsFavoriteProperty(QString companyName, bool isFavorite);
    void filterCompanyByCategoryIndex(const int index);
    void searchCompanyByNameInFilteringList(QString partNameCompany);

protected:
    void parseData(QByteArray document);
    QVector<Company*> allCompanies;
    QVector<Company*> filteredCompany;
    QVector<Company*> cloneFilteredCompany;
    void initializeRoles();
    enum CompanyRoles { NameCompany, IsFavorite, Address, ScheduleByCurrentDate,
                        StateOpen, Phones, Facebook, Instagramm, Www, Email, Location };
    QHash<int, QByteArray> roles;
private:
    QString previousPartNameForSearch;
    int currentCategoryIndex;
};

#endif // COMPANYLISTBYCATEGORY_H
