#ifndef JSONSAVER_H
#define JSONSAVER_H

#include <QObject>
#include <QJsonDocument>
#include <QFile>

class JsonSaver
{
public:
    JsonSaver(QJsonDocument document, QString location, QString name);
    ~JsonSaver();
    void save();

private:
    QJsonDocument jsonDocument_;
    QString location_;
    QString name_;
    QFile* file_;
};

#endif // JSONSAVER_H
