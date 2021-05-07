#include "settings.h"
#include <QSettings>
#include <QJsonObject>

static const QString favorite_ids = "favorite_ids";


//init static settings singleton
Settings* Settings::_settings = nullptr;

Settings::Settings(QObject *parent) : QObject(parent)
{
    mSettings = new QSettings("cicerone.ini", QSettings::IniFormat, this);
    loadSettings();
}

Settings::~Settings()
{
    saveSettings();
}

Settings *Settings::Instance(){
    if(_settings == nullptr)
        _settings = new Settings();
    return _settings;
}

bool Settings::isSendData() const
{
    return m_isSendData;
}

void Settings::setIsSendData(bool isSendData)
{
    if (m_isSendData == isSendData)
        return;
    m_isSendData = isSendData;
    isSendDataChanged(m_isSendData);
    saveSettings();
}

void Settings::saveSettings()
{
    mSettings->setValue("is_send_data", isSendData());
}

void Settings::loadSettings()
{
    setIsSendData(mSettings->value("is_send_data", false).toBool());
    mSettings->sync();
}

void Settings::saveFavoriteListCompany(QVector<Company*> companies)
{
    QVector<int> ids;
    for(int index = 0; index < companies.size(); index++)
        ids.push_back(companies[index]->id());
    mSettings->setValue(favorite_ids, QVariant::fromValue(ids));
}

QVector<int> Settings::loadFavoriteListCompany()
{
    return mSettings->value(favorite_ids).value<QVector<int>>();
}
