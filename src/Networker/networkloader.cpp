#include "networkloader.h"

NetworkLoader::NetworkLoader(QObject *parent)
    : LoaderInterface(parent),
      manager(new QNetworkAccessManager(this)){}

