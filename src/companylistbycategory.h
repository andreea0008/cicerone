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

    Q_INVOKABLE void addCompany(Company *company);
    Q_INVOKABLE void removeCompanyByIndex(int index);
    Q_INVOKABLE void removeCompany(QString companyName);
    Q_INVOKABLE void changeIsFavoriteProperty(const int index, bool isFavorite);
    Q_INVOKABLE void changeIsFavoriteProperty(QString companyName, bool isFavorite);
    Q_INVOKABLE void filterCompanyByCategoryIndex(const int index);
    void parseData(QByteArray document);

protected:
    QVector<Company*> filteredCompany;
    QVector<Company*> allCompanies;
    void initializeRoles();
    enum CompanyRoles {Id, NameCompany, IsFavorite, Address, ScheduleByCurrentDate,
                      StateOpen, Phones, Facebook, Instagramm, Www, Email, Location };
    QHash<int, QByteArray> roles;
};

#endif // COMPANYLISTBYCATEGORY_H
