#ifndef CATEGORY_H
#define CATEGORY_H

#include <QObject>
#include <QVariant>
#include <QAbstractItemModel>
#include <QJsonDocument>

class MyCategory : public QObject
{
    Q_OBJECT

public:
    MyCategory(const unsigned int id, const QString &category, QObject *parent = nullptr);
    MyCategory(const unsigned int id, const QString &category, const QString &pathToFile, QObject *parent = nullptr);
    MyCategory(const unsigned int id, const QString &category, const QString &pathToFile, const QString &pathToFileOnline, const QString &tag = "", QObject *parent = nullptr);

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
    explicit Category(QObject *parent = nullptr);
    ~Category()override;

    Q_PROPERTY(bool isLoaded READ isLoaded WRITE setIsLoaded NOTIFY isLoadedChanged)

    int rowCount(const QModelIndex &parent) const override;
    int columnCount(const QModelIndex &parent) const override;

    QModelIndex parent(const QModelIndex &child) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QModelIndex index(int row, int column, const QModelIndex &parent) const override;

    QHash<int, QByteArray> roleNames() const override;
    bool isLoaded() const;

public slots:
    void addElement(uint id, const QString &name);
    void addElement(const QString &name);
    void deleteElement(int index);
    void move(int from, int to);
    void parseData(QString stageName, QByteArray document);
    void setIsLoaded(bool isLoaded);

signals:
    void isLoadedChanged(bool isLoaded);

private:
    enum MyCategoryRoles{ Id, NameRole, PathToFile, UrlFile, Tag };
    const QString currentStage = "category";
    QHash<int, QByteArray> _roles;
    QVector<MyCategory *> m_data;
    QVector<MyCategory *> tmpCat;
    bool _isLoaded;
};

#endif // CATEGORY_H
