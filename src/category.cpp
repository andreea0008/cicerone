#include "category.h"
#include <QSettings>
#include <QDataStream>
#include <QXmlStreamWriter>
#include <QFile>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonValue>
#include "src/xml.h"
#include "updater.h"
#include "saver.h"

Category::Category(QObject *parent) : QAbstractItemModel(parent)
{
    _roles[Id] = "categoryId";
    _roles[NameRole] = "categoryName";
    _roles[PathToFile] = "pathToFileCategory";
    _roles[UrlFile] = "urlCategory";
    _roles[Tag] = "tag";
    setIsLoaded(false);
    connect(Updater::instance(), &Updater::dataChanged, this, &Category::parseData);
    Updater::instance()->startLoad();
}

Category::~Category()
{
}

int Category::rowCount(const QModelIndex &parent) const
{
    if(parent.isValid())
        return 0;
    return m_data.count();
}

int Category::columnCount(const QModelIndex &parent) const
{
    if(parent.isValid())
        return 0;
    return 1;
}

QModelIndex Category::parent(const QModelIndex &child) const
{
    Q_UNUSED(child)
    return QModelIndex();
}

QVariant Category::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || index.column() != 0 || index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    MyCategory *currentItem = m_data[index.row()];
    switch (role) {
    case Id: return currentItem->getId();
    case NameRole: return currentItem->getCategory();
    case PathToFile: return currentItem->getPathToFile();
    case UrlFile: return currentItem->getUrlToFile();
    case Tag: return currentItem->getTag();
    default: return QVariant();
    }
}

QModelIndex Category::index(int row, int column, const QModelIndex &parent) const
{
    return hasIndex(row, column, parent) ? createIndex(row,column) : QModelIndex();
}

QHash<int, QByteArray> Category::roleNames() const
{
    return _roles;
}

void Category::addElement(uint id, const QString &name)
{
    beginInsertRows(QModelIndex(), m_data.count(), m_data.count());
    m_data << new MyCategory(id, name);
    endInsertRows();
}

void Category::addElement(const QString &name)
{
    beginInsertRows(QModelIndex(), m_data.count(), m_data.count());
    m_data << new MyCategory(uint(m_data.size() + 1), name);
    endInsertRows();
}

void Category::deleteElement(int index)
{
    if(index < 0 || index >= m_data.count())
        return;

    beginRemoveRows(QModelIndex(), index, index);
    m_data.removeAt(index);
    endRemoveRows();
}

void Category::move(int from, int to)
{
    if(from > to){
        beginMoveRows(QModelIndex(), from, from, QModelIndex(), to);
        m_data.insert(to, m_data[from]);
        m_data.removeAt(from +1);
        endMoveRows();
    }else{
        beginMoveRows(QModelIndex(), from, from, QModelIndex(), to+1);
        m_data.insert(to +1, m_data[from]);
        m_data.removeAt(from);
        endMoveRows();
    }
}

bool Category::isLoaded() const
{
    return _isLoaded;
}

void Category::parseData(QString stageName, QByteArray document)
{
    if(stageName != currentStage)
        return;
    QJsonDocument doc = QJsonDocument::fromJson(document);
    auto array = doc.array();
    for(const auto item : array)
    {
        auto objectCategory = item.toObject();
        const auto categoryId = uint(objectCategory.value("id").toInt());
        const auto nameCategory = objectCategory.value("name").toString();
        addElement(categoryId, nameCategory);
    }
    setIsLoaded(!m_data.isEmpty());
}

void Category::setIsLoaded(bool isLoaded)
{
    _isLoaded = isLoaded;
    emit isLoadedChanged(_isLoaded);
}


MyCategory::MyCategory(const unsigned int id, const QString &category, QObject *parent)
    : QObject(parent), m_id(id), m_category(category) {}

MyCategory::MyCategory(const unsigned int id, const QString &category, const QString &pathToFile, QObject *parent)
    : QObject(parent), m_id(id), m_category(category), m_pathToFile(pathToFile) {}

MyCategory::MyCategory(const unsigned int id, const QString &category, const QString &pathToFile, const QString &pathToFileOnline, const QString &tag, QObject *parent)
    : QObject(parent), m_id(id), m_category(category), m_pathToFile(pathToFile), m_urlToFile(pathToFileOnline)
    , m_tag(tag){}
