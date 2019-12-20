#include "settings.h"
#include <QDebug>

Settings::Settings(QObject *parent) : QObject(parent)
{
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
}

void Settings::saveSettings()
{

}

void Settings::loadSettings()
{

}
