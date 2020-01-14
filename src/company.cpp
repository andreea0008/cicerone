#include "company.h"

Company::Company(const QString &nameBusinessCompany, QObject *parent):QObject(parent), nameCompany(nameBusinessCompany)
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

QString Company::getAddress() const
{
    return address;
}

void Company::setAddress(const QString &value)
{
    address = value;
}

QString Company::scheduleByCurrentDate()
{
    return QString("Here will be schedule");
}

bool Company::getIsOpen()
{
    return true;
}

QVector<QString> Company::getPhones() const
{
    return phones;
}

void Company::setPhones(const QVector<QString> &value)
{
    phones = value;
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

Location Company::getLocation() const
{
    return location;
}

void Company::setLocation(const Location &value)
{
    location = value;
}

QString Company::getFormattedLocation()
{
    return "loca-location";
}




