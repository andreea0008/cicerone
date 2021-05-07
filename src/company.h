#ifndef COMPANY_H
#define COMPANY_H

#include <QObject>
#include <QVector>
#include <QTime>
#include <QVariant>
#include <QDebug>
#include <QPair>
#include <QDataStream>

static QString FORMAT_SCHEDULE = QString("hh:mm");

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

    QString workShedule() const
    {
        QString workSchedule = QString("%1-%2")
                .arg(workTimeFrom.toString(FORMAT_SCHEDULE))
                .arg(workTimeTo.toString(FORMAT_SCHEDULE));
        return workSchedule;
    }

    QString breakSchedule() const
    {
        QString breakSchedule = QString("%1-%2")
                .arg(breakTimeFrom.toString(FORMAT_SCHEDULE))
                .arg(breakTimeTo.toString(FORMAT_SCHEDULE));
        return breakSchedule;
    }

    bool nowIsBreak(QTime breakTime) const
    {
        return (breakTime > breakTimeFrom) && (breakTime < breakTimeTo);
    }

    friend QDataStream& operator<<(QDataStream& out, const Schedule& v);
    friend QDataStream& operator>>(QDataStream& in, Schedule& v);
};


struct LocationCompany
{
    QVector<Schedule> weekSchedule;
    QStringList phones;
    QString address;
    QString lat;
    QString lng;

    QPair<bool, QString> sheduleByCurrentDay() const
    {
        //1 = Monday to 7 = Sunday
        QLocale englishLocale = QLocale(QLocale::English);
        const QString nameCurrentDay = englishLocale.toString(QDate::currentDate(), "dddd").toLower();
//        qDebug() << __LINE__ << nameCurrentDay << weekSchedule.size() << weekSchedule.at(0).day;
        QPair<bool, QString> result;
        for(int indexDay = 0; indexDay < weekSchedule.size(); indexDay++){
            const auto currentSchedule = weekSchedule.at(indexDay);
            if(weekSchedule.at(indexDay).day.toLower() == nameCurrentDay){
                const auto workSchedule = currentSchedule.workShedule();
                const auto breakSchedule = currentSchedule.breakSchedule();
                const auto isNowBreak = currentSchedule.nowIsBreak(QTime::currentTime());
//                qDebug() << __LINE__ << workSchedule << breakSchedule << isNowBreak << QTime::currentTime();
                result = QPair<bool, QString>(isNowBreak,
                                              isNowBreak ? breakSchedule : workSchedule);
                break;
            }
        }
        return result;
    }
};

class Company {
public:
    Company();
    Company(const QString &nameBusinessCompany);

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

    friend QDataStream& operator<<(QDataStream& out, const Company& v);
    friend QDataStream& operator>>(QDataStream& in, Company& v);
private:
    int m_id;
    int categoryId;
    QString nameCompany;
    bool isFavorite;
    QVector<LocationCompany> locationsList;
    QVector<Schedule> scheduleWeek;
    QString facebook;
    QString instagramm;
    QString www;
    QString email;
    LocationCompany location;
    Schedule schedule;
};
Q_DECLARE_METATYPE(Schedule);
Q_DECLARE_METATYPE(Company);

inline QDataStream& operator<<(QDataStream& out, const Schedule& v) {
    out << v.day << v.workTimeTo;
    return out;
};

inline QDataStream& operator>>(QDataStream& in, Schedule& v) {
    in >> v.day;
    in >> v.workTimeTo;
    return in;
};

inline QDataStream& operator<<(QDataStream& out, const Company& v)
{
    out << v.nameCompany;
    return out;
}
inline QDataStream& operator>>(QDataStream& in, Company& v)
{
    in >> v.nameCompany;
    return in;
}
#endif // COMPANY_H
