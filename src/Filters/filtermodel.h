#ifndef FILTERMODEL_H
#define FILTERMODEL_H

#include <QSortFilterProxyModel>

class FilterModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(QByteArray filterRole READ filterRole WRITE setFilterRole NOTIFY filterRoleChanged)
public:
    FilterModel(QObject *parent = Q_NULLPTR);

    QByteArray filterRole() const;
    void setFilterRole(const QByteArray roleName);

protected:
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const Q_DECL_OVERRIDE;

private:
    QByteArray m_filterRole;
signals:
    void filterRoleChanged();
};

#endif // FILTERMODEL_H
