#include "eventcategory.h"
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonValue>
#include <QDebug>
#include "src/updater.h"

EventController::EventController(QObject *parent) : QAbstractItemModel(parent)
{
    initializeRoles();
    parseEventTypeData(Updater::instance()->loadDataByStage(Updater::Resources::EventType));
    parseEventData(Updater::instance()->loadDataByStage(Updater::Resources::Event));


//    addEvent(new Event{ "first title "});
}

int EventController::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : eventsList.size();
}

int EventController::columnCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : 1;
}

QModelIndex EventController::parent(const QModelIndex &child) const
{
    Q_UNUSED(child)
    return QModelIndex();
}

QModelIndex EventController::index(int row, int column, const QModelIndex &parent) const
{
    return hasIndex(row, column, parent) ? createIndex(row,column) : QModelIndex();
}

QHash<int, QByteArray> EventController::roleNames() const
{
    return roles;
}

QVariant EventController::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || index.column() != 0 || index.row() < 0 || index.row() >= eventsList.size())
        return QVariant();

    const auto event = eventsList[index.row()];
    switch (role) {
    case EventTitle: return event->title;
    case EventDescription: return event->description;
    default:return QVariant();
    }
}

QVariantList EventController::eventTypes() const { return _eventTypesList; }

void EventController::setEventTypes(QVariantList eventTypes)
{
    if (_eventTypesList != eventTypes){
        _eventTypesList = eventTypes;
        eventTypesChanged();
    }
}

void EventController::addEvent(Event *event)
{
    beginInsertRows(QModelIndex(), eventsList.size(), eventsList.size());
    eventsList.push_back(event);
    endInsertRows();
}

void EventController::parseEventTypeData(QByteArray document)
{
    QJsonDocument jsonDocument = QJsonDocument::fromJson(document);
    QJsonArray array = jsonDocument.array();
    QVariantList list;
    for(int index = 0; index < array.size(); index++)
    {
        list.push_back(array.at(index).toObject().value("type").toString());
    }

    setEventTypes(list);
}

void EventController::parseEventData(QByteArray document)
{
    QJsonDocument jsonDocument = QJsonDocument::fromJson(document);
    QJsonArray array = jsonDocument.array();
    for(int index = 0; index < array.size(); index++)
    {
        const auto objectEvent = array.at(index).toObject();
        const auto titleEvent = objectEvent["title_event"].toString();
        const auto descriptionEvent  = objectEvent["description_event"].toString();
        Event *event = new Event { titleEvent, descriptionEvent };
        addEvent(event);
    }
}

void EventController::initializeRoles()
{
    roles[EventTitle] = "title";
    roles[EventDescription] = "description";



}


