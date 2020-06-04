#include "company.h"
#include <QQmlPropertyMap>
#include <QDebug>
#include <QJsonArray>
Company::Company(const QString &nameBusinessCompany, QObject *parent)
    : QObject(parent),
      nameCompany(nameBusinessCompany),
      isFavorite(false)
{}

int Company::id() const
{
    return m_id;
}

void Company::setId(int id)
{
    m_id = id;
}

QString Company::getNameCompany() const
{
    return nameCompany;
}

void Company::setNameCompany(const QString &value)
{
    nameCompany = value;
}

bool Company::getIsFavorite() const
{
    return isFavorite;
}

void Company::setIsFavorite(bool value)
{
    isFavorite = value;
}

QVector<LocationCompany> Company::getAddress() const
{
    return address;
}

void Company::setAddress(const QVector<LocationCompany> &value)
{
    address = value;
}

void Company::setSheduleByCurrentDay(const Schedule &scheduleByCurrentDay)
{
    schedule = scheduleByCurrentDay;
}

QString Company::scheduleByCurrentDate()
{
//    qDebug() << QString("%1-%2").arg(schedule.breakTimeFrom.toString("hh:mm")).arg(schedule.workTimeTo.toString("hh:mm"));
//    return QString("%1-%2").arg(schedule.breakTimeFrom.toString("hh:mm")).arg(schedule.workTimeTo.toString("hh:mm"));
    if(address.isEmpty())
        return QString();

    for(int i = 0; i < address.size(); i++)
    {
        qDebug() << address.at(i).address << address.at(i).weekSchedule.size();
    }
    return QString("20:00 - 21:00");
}

bool Company::getIsOpen()
{
    return true;
}

QString Company::getFacebook() const
{
    return facebook;
}

void Company::setFacebook(const QString &value)
{
    facebook = value;
}

QString Company::getInstagramm() const
{
    return instagramm;
}

void Company::setInstagramm(const QString &value)
{
    instagramm = value;
}

QString Company::getWww() const
{
    return www;
}

void Company::setWww(const QString &value)
{
    www = value;
}

QString Company::getEmail() const
{
    return email;
}

void Company::setEmail(const QString &value)
{
    email = value;
}

QString Company::stateOpen()
{
    return QString("StateOpen");
}

LocationCompany Company::getLocation() const
{
    return location;
}

QVariantMap Company::getLocationList()
{
    QVariantMap mapLocations;
    for(int i = 0; i < address.size(); i++)
    {
        const auto currentAddress = address.at(i);
        QMap<QString, QVariant> propertyMap;
        propertyMap.insert("address", QVariant::fromValue(currentAddress.address));
        propertyMap.insert("lat", QVariant::fromValue(currentAddress.lat));
        propertyMap.insert("lng", QVariant::fromValue(currentAddress.lng));
        propertyMap.insert("phone", QVariant::fromValue(currentAddress.phones));
        propertyMap.insert("schedule", QVariant::fromValue<QVector<Schedule>>(currentAddress.weekSchedule));
        qDebug() << propertyMap.value("schedule");

//            QJsonArray result;
//            std::copy (currentAddress.weekSchedule.begin(), currentAddress.weekSchedule.end(), std::back_inserter(result));

//        const auto value = QJsonDocument::from;
//        qDebug() << result;
        mapLocations.insert(QString("location_%1").arg(rand()), QVariant::fromValue(propertyMap));
    }
    return mapLocations;
}

void Company::setLocation(const LocationCompany &value)
{
    location = value;
}

QString Company::getFormattedLocation()
{
    return "loca-location";
}

int Company::getCategoryId() const
{
    return categoryId;
}

void Company::setCategoryId(int value)
{
    categoryId = value;
}




