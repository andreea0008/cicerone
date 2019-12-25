#include "companylistbycategory.h"

CompanyListByCategory::CompanyListByCategory(QObject *parent)
    : QAbstractItemModel(parent)
{
//INIT ROLES
    roles[Id] = "CompanyId";
    roles[NameCompany] = "NameCompany",
    roles[IsFavorite] = "IsFavorite",
    roles[Address] = "Address",
    roles[ScheduleByCurrentDate] = "Schedule",
    roles[StateOpen] = "StateOpen",
    roles[Phone1] = "Phone1",
    roles[Phone2] = "Phone2",
    roles[Facebook] = "Facebook",
    roles[Instagramm] = "Instagramm",
    roles[Www] = "WWW",
    roles[Email] = "Email";
    roles[Location] = "Location";

    addCompany(new Company("vnjdnvjkdsnv"));

}

int CompanyListByCategory::rowCount(const QModelIndex &parent) const
{
    if(parent.isValid())
        return 0;
    return listCompany.size();
}

int CompanyListByCategory::columnCount(const QModelIndex &parent) const
{
    if(parent.isValid())
        return 0;
    return 1;
}

QModelIndex CompanyListByCategory::parent(const QModelIndex &child) const
{
    Q_UNUSED(child)
    return QModelIndex();
}

QVariant CompanyListByCategory::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || index.column() != 0 || index.row() < 0 || index.row() >= listCompany.count())
        return QVariant();

    const auto company = listCompany[index.row()];
    switch(role)
    {
    case Id: return company->id();
    case NameCompany: return company->getNameCompany();
    case IsFavorite: return company->getIsFavorite();
    case Address: return company->getAddress();
    case ScheduleByCurrentDate: return company->scheduleByCurrentDate();
    case StateOpen: return company->stateOpen();
    case Phone1: {
        if(company->getPhones().size() >= 2)
            return company->getPhones().at(0);
    }
    case Phone2: {
        if(company->getPhones().size() >= 2)
            return company->getPhones().at(1);
    }

    case Facebook: return company->getFacebook();
    case Instagramm: return company->getInstagramm();
    case Www: return company->getWww();
    case Email: return company->getEmail();
    case Location: return company->getFormattedLocation();
    default: return QVariant();
    }
}

QModelIndex CompanyListByCategory::index(int row, int column, const QModelIndex &parent) const
{
    return hasIndex(row, column, parent) ? createIndex(row,column) : QModelIndex();
}

QHash<int, QByteArray> CompanyListByCategory::roleNames() const
{
    return roles;
}

void CompanyListByCategory::addCompany(Company *company)
{
    beginInsertRows(QModelIndex(), listCompany.size(), listCompany.size());
    listCompany << company;
    endInsertRows();
}
