#include "company.h"

Company::Company(const QString &nameCompany, QObject *parent):QObject(parent), m_company(nameCompany)
{}

Company::Company(int id, const QString &nameCompany, QObject *parent) : QObject(parent), m_id(id), m_company(nameCompany)
{

}

//Company::Company(int id, const QString &nameCompany, const QString &addressCompany, const QString &hourFrom, const QString &hourTo, const QString &specialization, const QString &description, QObject *parent) :
//    QObject(parent), m_id(id), m_company(nameCompany), m_address(addressCompany, m_hourFrom(hourFrom), m_hourTo(hourTo), m_typeSpecialization(specialization), m_description(description))
//{

//}

Company::Company(int id, const QString &nameCompany, const QStringList &phonesCompany, const QStringList &schedule, const QString &addressCompany, const QString &description, const QString url, const QString email, const QString facebookUrl, QObject *parent) :
    QObject(parent), m_id(id), m_company(nameCompany), m_phones(phonesCompany), m_schedule(schedule), m_address(addressCompany), m_description(description),
    m_url(url), m_email(email), m_facebook(facebookUrl)
{

}



