#ifndef NETWORKLOADER_H
#define NETWORKLOADER_H

#include "src/loaderinterface.h"
#include <QNetworkAccessManager>
#include <memory>

class NetworkLoader : public LoaderInterface
{
    Q_OBJECT
public:
    NetworkLoader(QObject *parent = nullptr);
    ~NetworkLoader();
    virtual void load() = 0;
    virtual void save() = 0;

protected:
    std::unique_ptr<QNetworkAccessManager> manager;
};

#endif // NETWORKLOADER_H
