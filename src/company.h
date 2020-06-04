#ifndef COMPANY_H
#define COMPANY_H

#include <QObject>
#include <QVector>
#include <QTime>
#include <QVariant>

struct Schedule
{
    QString day;
    QTime workTimeFrom;
    QTime workTimeTo;
    QTime breakTimeFrom;
    QTime breakTimeTo;

    static QTime setFromByString(const QString timeFromString)
    {
        return  QTime::fromString(timeFromString);
    }
};

struct LocationCompany
{
    QVector<Schedule> weekSchedule;
    QStringList phones;
    QString address;
    QString lat;
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

    QVector<LocationCompany> getAddress() const;
    void setAddress(const QVector<LocationCompany> &value);

    void  setSheduleByCurrentDay(const Schedule& scheduleByCurrentDay);
    QString scheduleByCurrentDate();
    bool getIsOpen();

    QString getFacebook() const;
    void setFacebook(const QString &value);

    QString getInstagramm() const;
    void setInstagramm(const QString &value);

    QString getWww() const;
    void setWww(const QString &value);

    QString getEmail() const;
    void setEmail(const QString &value);

    QString stateOpen();
    LocationCompany getLocation() const;
    QVariantMap getLocationList();

    void setLocation(const LocationCompany &value);
    QString getFormattedLocation();

    int getCategoryId() const;
    void setCategoryId(int value);

private:
    int m_id;
    int categoryId;
    QString nameCompany;
    bool isFavorite;
    QVector<LocationCompany> address;
    QVector<Schedule> scheduleWeek;
    QString facebook;
    QString instagramm;
    QString www;
    QString email;
    LocationCompany location;
    Schedule schedule;
};
Q_DECLARE_METATYPE(Schedule);
#endif // COMPANY_H
