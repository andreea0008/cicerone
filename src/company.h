#ifndef COMPANY_H
#define COMPANY_H

#include <QObject>
#include <QVector>
#include <QTime>

struct Schedule
{
    QTime from;
    QTime to;
    QTime breakFrom;
    QTime breakTo;
};

struct Location
{
    QString ltg;
    QString lng;
};

class Company : public QObject{
    Q_OBJECT

public:
    Company(const QString &nameBusinessCompany, QObject *parent = nullptr);



    int id() const;
    void setId(int id);

    QString getNameCompany() const;
    void setNameCompany(const QString &value);

    bool getIsFavorite() const;
    void setIsFavorite(bool value);

    QString getAddress() const;
    void setAddress(const QString &value);

    QString scheduleByCurrentDate();
    bool getIsOpen();
    QVector<QString> getPhones() const;
    void setPhones(const QVector<QString> &value);

    QString getFacebook() const;
    void setFacebook(const QString &value);

    QString getInstagramm() const;
    void setInstagramm(const QString &value);

    QString getWww() const;
    void setWww(const QString &value);

    QString getEmail() const;
    void setEmail(const QString &value);

    QString stateOpen();
    Location getLocation() const;
    void setLocation(const Location &value);
    QString getFormattedLocation();

private:
    int m_id;
    QString nameCompany;
    bool isFavorite;
    QString address;
    QVector<Schedule> scheduleWeek;
    QVector<QString> phones;
    QString facebook;
    QString instagramm;
    QString www;
    QString email;
    Location location;
};

#endif // COMPANY_H
