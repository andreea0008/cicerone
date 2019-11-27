#include "category.h"
#include <QSettings>
#include "saver.h"
#include <QDataStream>
#include <QXmlStreamWriter>
#include <QFile>
#include <QDebug>
#include "src/xml.h"

Category::Category(QObject *parent) : QAbstractItemModel(parent),
    isMoved(false)
{
    m_roles[Id] = "categoryId";
    m_roles[NameRole] = "categoryName";
    m_roles[PathToFile] = "pathToFileCategory";
    m_roles[UrlFile] = "urlCategory";
    m_roles[Tag] = "tag";
    if(!loadCategoryFromFile())
        qDebug() << "failed_load";
    else {
        qDebug() << "loaded" << m_data.size();
    }
    connect(this, &QAbstractItemModel::rowsMoved, this, &Category::sltRowsMoved);
    addElement("deeded");
}

Category::~Category()
{
    saveCategoryInFile();
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
    Q_UNUSED(child);
    return QModelIndex();
}

QVariant Category::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || index.column() != 0 || index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    MyCategory *currentItem = m_data[index.row()];
    switch (role) {
    case Id:
        return currentItem->getId();
    case NameRole:
        return currentItem->getCategory();
    case PathToFile:
        return currentItem->getPathToFile();
    case UrlFile:
        return currentItem->getUrlToFile();
    case Tag:
        return currentItem->getTag();
    default:
        return QVariant();
    }
}

QModelIndex Category::index(int row, int column, const QModelIndex &parent) const
{
    return hasIndex(row, column, parent) ? createIndex(row,column) : QModelIndex();
}

QHash<int, QByteArray> Category::roleNames() const
{
    return m_roles;
}

void Category::addElement(const QString &name)
{
    beginInsertRows(QModelIndex(), m_data.count(), m_data.count());
    m_data << new MyCategory(m_data.count() + 1, name);
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
    isMoved = true;
}

void Category::saveCategoryInFile()
{
    if(!isMoved)
        return;
    if(tmpCat.isEmpty())
        xml::getInstance()->saveCategory(m_data);
    else
        xml::getInstance()->saveCategory(tmpCat, false);
}

bool Category::loadCategoryFromFile()
{
    bool isLoad = xml::getInstance()->loadCategory(m_data, xml::getInstance()->isExistCustomFile());
    return isLoad;
}

void Category::sltRowsMoved(const QModelIndex &parent, int start, int end, const QModelIndex &destination, int row)
{
    Q_UNUSED(parent)
    Q_UNUSED(end)
    Q_UNUSED(destination)

    if(tmpCat.size() == 0)
        tmpCat = m_data;

    tmpCat.insert(row, tmpCat.at(start));

    if(row < start)
        tmpCat.removeAt(start+1);
    else
        tmpCat.removeAt(start);
}


MyCategory::MyCategory(const unsigned int id, const QString &category, QObject *parent)
    : QObject(parent), m_id(id), m_category(category)
{

}

MyCategory::MyCategory(const unsigned int id, const QString &category, const QString &pathToFile, QObject *parent)
    : QObject(parent), m_id(id), m_category(category), m_pathToFile(pathToFile)
{

}

MyCategory::MyCategory(const unsigned int id, const QString &category, const QString &pathToFile, const QString &pathToFileOnline, const QString &tag, QObject *parent)
    : QObject(parent), m_id(id), m_category(category), m_pathToFile(pathToFile), m_urlToFile(pathToFileOnline), m_tag(tag)
{

}
