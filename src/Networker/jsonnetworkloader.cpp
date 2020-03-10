#include "jsonnetworkloader.h"
#include <QNetworkReply>
#include "jsonsaver.h"
#include <QDebug>
#include "jsonfileloader.h"

JsonNetworkLoader::JsonNetworkLoader(QUrl url, QObject *object)
    : NetworkLoader(object),
      url_(url)
{

}

JsonNetworkLoader::JsonNetworkLoader(QUrl url, QString fileName, QObject *object)
    : NetworkLoader(object),
      url_(url),
      fileName_(fileName)
{

}

void JsonNetworkLoader::load()
{
    connect(manager.get(), &QNetworkAccessManager::finished, this, &JsonNetworkLoader::onLoaded);
    manager->get(QNetworkRequest(url()));
}

void JsonNetworkLoader::save()
{
    JsonSaver saver(loadedJsonDocument_, "json_files", fileName_);
    saver.save();
}

QUrl JsonNetworkLoader::url() const
{
    return url_;
}

void JsonNetworkLoader::setUrl(const QUrl &url)
{
    url_ = url;
}

void JsonNetworkLoader::onLoaded(QNetworkReply *reply)
{
    auto data = reply->readAll();
    loadedJsonDocument_ = QJsonDocument::fromJson(data);
    save();
}
