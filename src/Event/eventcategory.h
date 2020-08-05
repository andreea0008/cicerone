#ifndef EVENTCATEGORY_H
#define EVENTCATEGORY_H

#include <QAbstractItemModel>

struct Event {
    QString title;
    QString description;
};

class EventController : public QAbstractItemModel
{
    Q_OBJECT
    QVariantList _eventTypesList;

public:
    explicit EventController(QObject *parent = nullptr);
    ~EventController() override {}

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QModelIndex parent(const QModelIndex &child) const override;
    QModelIndex index(int row, int column, const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_PROPERTY(QVariantList eventTypes READ eventTypes NOTIFY eventTypesChanged)
    QVariantList eventTypes() const;

public slots:

private slots:
    void setEventTypes(QVariantList eventTypes);
    void addEvent(Event *event);
signals:
    void eventTypesChanged();

protected:
    void parseEventTypeData(QByteArray document);
    void parseEventData(QByteArray document);
    void initializeRoles();
    enum EventRoles { EventTitle, EventDescription };
    QHash<int, QByteArray> roles;
    QVector<Event*> eventsList;
    QVector<Event*> filteredEventsList;
};

#endif // EVENTCATEGORY_H
