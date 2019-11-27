#ifndef SAVER_H
#define SAVER_H
#include <QSettings>

class Saver : public QSettings
{
public:
    Saver() : QSettings(QSettings::IniFormat, QSettings::UserScope, "Guide", "Settings"){}
    Saver(QString fileName) : QSettings(QSettings::IniFormat, QSettings::UserScope, "Guide", fileName){}
};

#endif // SAVER_H
