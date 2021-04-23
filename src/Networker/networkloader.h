#ifndef NETWORKLOADER_H
#define NETWORKLOADER_H

#include "src/loaderinterface.h"
#include <QNetworkAccessManager>

class NetworkLoader : public LoaderInterface
{
    Q_OBJECT
public:
    NetworkLoader(QObject *parent = nullptr);
    virtual ~NetworkLoader(){}
    virtual void load() = 0;
    virtual void save() = 0;

protected:
    QNetworkAccessManager* manager;
};

#endif // NETWORKLOADER_H
