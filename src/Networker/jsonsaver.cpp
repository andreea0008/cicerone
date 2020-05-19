#include "jsonsaver.h"
#include <QFile>
#include <QDebug>

JsonSaver::JsonSaver(QJsonDocument document, QString location, QString name)
    : jsonDocument_(document),
      location_(location),
      name_(name)
{
    qDebug() << __FILE__ << __LINE__ << QString("%1.json").arg(name_);
    file_ = std::make_unique<QFile>(QString("%1.json").arg(name_));
    file_->open(QIODevice::WriteOnly | QIODevice::Text);
}

JsonSaver::~JsonSaver()
{
    file_->close();
    qDebug() << __FILE__ << __LINE__;
}

void JsonSaver::save()
{
    if(!file_->isOpen())
    {
        qDebug() << "JsonSaver File_not_open";
        return;
    }

    file_->write(jsonDocument_.toJson());
    file_->flush();
    file_->close();
}
