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

    virtual void load();
    virtual void save();

protected:
    std::unique_ptr<QNetworkAccessManager> manager;
};

#endif // NETWORKLOADER_H
