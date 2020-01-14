#ifndef COMPANYLISTBYCATEGORY_H
#define COMPANYLISTBYCATEGORY_H

#include <QObject>
#include <QAbstractItemModel>
#include "company.h"
#include <QVector>

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
    Q_INVOKABLE void removeCompany(int index);
    Q_INVOKABLE void removeCompany(QString companyName);
    Q_INVOKABLE void changeIsFavoriteProperty(const int index, bool isFavorite);
    Q_INVOKABLE void changeIsFavoriteProperty(QString companyName, bool isFavorite);
    Q_INVOKABLE void addCompanyToFavorite(QString nameCompany);

protected:
    QVector<Company*> listCompany;

private:
    enum CompanyRoles {Id, NameCompany, IsFavorite, Address, ScheduleByCurrentDate,
                      StateOpen, Phone1, Phone2, Facebook, Instagramm, Www, Email, Location };
    QHash<int, QByteArray> roles;
};

#endif // COMPANYLISTBYCATEGORY_H
