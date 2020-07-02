#include "jsonfileloader.h"
#include <QJsonDocument>

JsonFileLoader::JsonFileLoader(const QString location, QObject *parent)
    : NetworkLoader(parent),
      location_(location)
{
    file_ = new QFile(location_);
}

JsonFileLoader::~JsonFileLoader()
{
    file_->close();
    delete  file_;
}

/**
 * @brief load data from file
 */

void JsonFileLoader::load()
{
    if(!file_->open(QIODevice::ReadOnly | QIODevice::Text)){
        qDebug() << "file_not_open";
    }
    auto ba = file_->readAll();
    jsonDocument_ = QJsonDocument::fromJson(ba);
}

void JsonFileLoader::save()
{

}

QJsonDocument JsonFileLoader::loadedJsonDocument() const
{
    return jsonDocument_;
}
