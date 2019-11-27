#ifndef COMPANY_H
#define COMPANY_H

#include <QObject>
#include <QVector>

class Company : public QObject{
    Q_OBJECT

public:
    Company(const QString &nameCompany, QObject *parent = nullptr);

    Company(int id, const QString &nameCompany, QObject *parent = nullptr);

//    Company(int id,const QString &nameCompany, const QString &addressCompany, const QString &hourFrom, const QString &hourTo,
//           const QString &specialization = "", const QString &description = "", QObject *parent = 0);

    Company(int id, const QString &nameCompany, const QStringList &phonesCompany,
            const QStringList &schedule,  const QString &addressCompany = "", const QString &description = "",
            const QString url = "", const QString email = "", const QString facebookUrl="", QObject *parent = 0);

    int getIdCompany() const { return m_id; }
    QString getNameCompany() const { return m_company; }
    QString getAddressCompany() const { return m_address; }
    QString getHourFromWork() const { return m_hourFrom; }
    QString getHourToWork() const { return m_hourTo; }
    QString getTypeSpecialization() const { return m_typeSpecialization; }
    QString getDescription() const { return m_description; }
    QStringList getPhones() const { return m_phones; }
    QStringList getSchedule() const { return m_schedule; }
    QString getUrl() const { return m_url; }
    QString getEmail() const { return m_email; }
    QString getFacebookUrl() const { return m_facebook; }

private:
    QStringList m_phones;
    QStringList m_schedule;
    int m_id;
    QString m_company;
    QString m_address;
    QString m_hourFrom, m_hourTo;
    QString m_typeSpecialization;
    QString m_description;
    QString m_url;
    QString m_facebook;
    QString m_email;
};

#endif // COMPANY_H
