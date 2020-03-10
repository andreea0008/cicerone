#ifndef JSONNETWORKLOADER_H
#define JSONNETWORKLOADER_H

#include <QObject>
#include "networkloader.h"
#include <QJsonDocument>

class QNetworkRequest;
class JsonNetworkLoader : public NetworkLoader
{
public:
    JsonNetworkLoader(QUrl url, QObject *object =nullptr);
    JsonNetworkLoader(QUrl url, QString fileName, QObject *object =nullptr);

    virtual void load() override;
    virtual void save() override;

    QUrl url() const;
    void setUrl(const QUrl &url);

signals:
    void ready();

private slots:
    void onLoaded(QNetworkReply *reply);
protected:
    QJsonDocument loadedJsonDocument_;
    QUrl url_;
    QString fileName_;
};

#endif // JSONNETWORKLOADER_H
