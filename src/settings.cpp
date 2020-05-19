#include "settings.h"
#include <QSettings>

Settings::Settings(QObject *parent) : QObject(parent)
{
    mSettings = new QSettings("smartgame", "cicerone");
    loadSettings();
}

Settings::~Settings()
{
    saveSettings();
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
