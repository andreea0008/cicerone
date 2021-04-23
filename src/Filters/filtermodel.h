#ifndef FILTERMODEL_H
#define FILTERMODEL_H

#include <QSortFilterProxyModel>

class FilterModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(QByteArray filterRole READ filterRole WRITE setFilterRole NOTIFY filterRoleChanged)

public:
    FilterModel(QObject *parent = nullptr);

    QByteArray filterRole() const;
    void setFilterRole(const QByteArray roleName);

signals:
    void filterRoleChanged();

protected:
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const Q_DECL_OVERRIDE;

private:
    QByteArray _filterRole;
};

#endif // FILTERMODEL_H
