#include "jsonnetworkloader.h"
#include <QNetworkReply>
#include <QEventLoop>
#include "jsonsaver.h"
#include <QDebug>
#include "jsonfileloader.h"

JsonNetworkLoader::JsonNetworkLoader(QString url, QObject *object)
    : NetworkLoader(object)
{
    url_ = url;
}

JsonNetworkLoader::JsonNetworkLoader(QString url, QString fileName, QObject *object)
    : NetworkLoader(object),
      fileName_(fileName)
{
    url_ = url;
}

void JsonNetworkLoader::load()
{
    QEventLoop loop;
    qDebug() << __FUNCTION__ << "start load";
    manager->get(QNetworkRequest(url_));
    connect(manager.get(), &QNetworkAccessManager::finished, this, &JsonNetworkLoader::onLoaded);
    connect(manager.get(), &QNetworkAccessManager::finished, &loop, &QEventLoop::quit);
    loop.exec();
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

void JsonNetworkLoader::setUrl(const QString &url)
{
    url_ = url;
}

void JsonNetworkLoader::onLoaded(QNetworkReply *reply)
{
    auto data = reply->readAll();
    loadedJsonDocument_ = QJsonDocument::fromJson(data);
    save();
}
