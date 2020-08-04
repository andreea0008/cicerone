#ifndef EVENTCATEGORY_H
#define EVENTCATEGORY_H

#include <QAbstractItemModel>

class EventCategory : public QAbstractItemModel
{
    Q_OBJECT
public:
    explicit EventCategory(QObject *parent = nullptr);

signals:

public slots:
};

#endif // EVENTCATEGORY_H
