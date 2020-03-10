#include "networkloader.h"

NetworkLoader::NetworkLoader(QObject *parent)
    : LoaderInterface(parent)
{
    manager = std::make_unique<QNetworkAccessManager>(this);
}

void NetworkLoader::load()
{

}

void NetworkLoader::save()
{

}
