#ifndef CATEGORY_H
#define CATEGORY_H

#include <QObject>
#include <QVariant>
#include <QDebug>
#include <QAbstractItemModel>

class MyCategory : public QObject
{
    Q_OBJECT

public:
    MyCategory(const unsigned int id, const QString &category, QObject *parent = 0);
    MyCategory(const unsigned int id, const QString &category, const QString &pathToFile, QObject *parent = 0);
    MyCategory(const unsigned int id, const QString &category, const QString &pathToFile, const QString &pathToFileOnline, const QString &tag = "", QObject *parent = 0);

    QString getCategory() const { return m_category; }
    unsigned int getId() const { return m_id; }
    QString getPathToFile() const { return m_pathToFile; }
    QString getUrlToFile() const { return m_urlToFile; }
    QString getTag() const { return m_tag; }

private:
    unsigned int m_id;
    QString m_category;
    QString m_pathToFile;
    QString m_urlToFile;
    QString m_tag;
};

class Category : public QAbstractItemModel
{
    Q_OBJECT
public:
    explicit Category(QObject *parent = 0);
    ~Category();

    int rowCount(const QModelIndex &parent) const override;
    int columnCount(const QModelIndex &parent) const override;

    QModelIndex parent(const QModelIndex &child) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QModelIndex index(int row, int column, const QModelIndex &parent) const override;

    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE void addElement(const QString &name);
    Q_INVOKABLE void deleteElement(int index);
    Q_INVOKABLE void move(int from, int to);

    void saveCategoryInFile();
    bool loadCategoryFromFile();

private slots:
    void sltRowsMoved(const QModelIndex &parent, int start, int end, const QModelIndex &destination, int row);
private:
    enum MyCategoryRoles{ Id, NameRole, PathToFile, UrlFile, Tag };
    bool isMoved;
    QHash<int, QByteArray> m_roles;
    QVector<MyCategory *> m_data;
    QVector<MyCategory *> tmpCat;
};

#endif // CATEGORY_H
