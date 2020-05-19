#ifndef JSONNETWORKLOADER_H
#define JSONNETWORKLOADER_H

#include <QObject>
#include "networkloader.h"
#include <QJsonDocument>

class QNetworkRequest;
class JsonNetworkLoader : public NetworkLoader
{
    Q_OBJECT
public:
    JsonNetworkLoader(QString url, QObject *object =nullptr);
    JsonNetworkLoader(QString url, QString fileName, QObject *object =nullptr);

    virtual void load() override;
    virtual void save() override;

    QUrl url() const;
    void setUrl(const QString &url);

signals:
    void ready();

private slots:
    void onLoaded(QNetworkReply *reply);
protected:
    QJsonDocument loadedJsonDocument_;
    QString url_;
    QString fileName_;
    QNetworkReply *reply_;
};

#endif // JSONNETWORKLOADER_H
