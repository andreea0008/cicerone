#include "jsonsaver.h"
#include <QFile>
#include <QDebug>
#include "src/Logger/Errors.h"

JsonSaver::JsonSaver(QJsonDocument document, QString location, QString name, bool needClear)
    : jsonDocument_(document),
      location_(location),
      name_(name)
{
    file_ = new QFile(QString("%1.json").arg(name_));
    file_->open(QIODevice::WriteOnly | QIODevice::Text);
    if(needClear) file_->resize(0);
}

JsonSaver::~JsonSaver()
{
    file_->close();
    delete file_;
}

void JsonSaver::save()
{
    if(!file_->isOpen())
    {
        qDebug() << FILE_NOT_OPEN.arg(file_->fileName());
        return;
    }

    file_->write(jsonDocument_.toJson());
    file_->flush();
    file_->close();
}
