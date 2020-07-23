#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QVector>
#include "company.h"

class QSettings;

class Settings : public QObject
{
    Q_OBJECT

    bool m_isSendData;

    explicit Settings(QObject *parent = nullptr);
    Settings(Settings&) = delete;
    ~Settings();

    static Settings* _settings;

public:
    Q_PROPERTY(bool isSendData READ isSendData WRITE setIsSendData NOTIFY isSendDataChanged)
    void operator=(Settings&) = delete;
    static Settings* Instance();

    bool isSendData() const;

signals:
    void isSendDataChanged(bool isSendData);

public slots:
    void setIsSendData(bool isSendData);
    void saveSettings();
    void loadSettings();

    void saveFavoriteListCompany(QVector<Company *> companies);

private:
    QSettings *mSettings;
    QVector<Company*> _listCompany;
};

#endif // SETTINGS_H
