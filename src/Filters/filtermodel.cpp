#include "filtermodel.h"

FilterModel::FilterModel(QObject *parent) :
    QSortFilterProxyModel(parent)
{}

QByteArray FilterModel::filterRole() const
{
    return _filterRole;
}

void FilterModel::setFilterRole(const QByteArray roleName)
{
    if(roleName != _filterRole) {
        _filterRole = roleName;
        emit filterRoleChanged();
    }
}

bool FilterModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    QModelIndex index = sourceModel()->index(source_row, 0, source_parent);
    int role = sourceModel()->roleNames().key(_filterRole, (int)Qt::DisplayRole);
    QVariant data = index.data(role);
    QVariant returnedValue;
    QMetaObject::invokeMethod(const_cast<FilterModel *>(this), "filter",
            Q_RETURN_ARG(QVariant, returnedValue),
            Q_ARG(QVariant, data));
    return true;
}
