#include "networkloader.h"

NetworkLoader::NetworkLoader(QObject *parent)
    : LoaderInterface(parent)
{
    manager = std::make_unique<QNetworkAccessManager>(this);
}

NetworkLoader::~NetworkLoader()
{
}
