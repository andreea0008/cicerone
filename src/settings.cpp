#include "settings.h"
#include <QSettings>
#include <QJsonObject>

//init static settings singleton
Settings* Settings::_settings = nullptr;

Settings::Settings(QObject *parent) : QObject(parent)
{
    mSettings = new QSettings("smartgame", "cicerone");
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
    emit isSendDataChanged(m_isSendData);
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
    QVector<Company> companiesList;

    for(int index = 0; index < companies.size(); index++)
        companiesList.push_back(*companies[index]);

    mSettings->setValue("favorite_list_company", QVariant::fromValue(companiesList));
}

QVector<Company*> Settings::loadFavoriteListCompany()
{
    QVector<Company> list = mSettings->value("favorite_list_company").value<QVector<Company>>();
    QVector<Company*> favoriteCompanyList;
    for(int index = 0; index < list.size(); index++)
        favoriteCompanyList.push_back(new Company(list[index]));
    qDebug() << __FUNCTION__ << list[0].getNameCompany();
    return favoriteCompanyList;
}
