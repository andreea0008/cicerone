#include "updater.h"
#include "Networker/urls.h"
#include "Networker/jsonfileloader.h"
#include "Networker/jsonnetworkloader.h"
#include "Networker/jsonsaver.h"

Updater* Updater::updater_ = nullptr;

Updater::Updater(QObject *parent) : QObject(parent)
{
    _settings = make_unique<Settings>(this);
}

/**
 * @brief start load data for models
 */
void Updater::startLoad()
{
    //check countries
    JsonFileLoader loaderCountry("country.json");
    loaderCountry.load();
    if(loaderCountry.loadedJsonDocument().isEmpty())
    {
        qDebug() << __LINE__ << "file is empty";
        JsonNetworkLoader jsonNetworkLoader(COUNTRIES_URL, "country", this);
//        connect(&jsonNetworkLoader, &JsonNetworkLoader::ready, this, &Updater::startLoad);
    }
    qDebug() << __LINE__ << "file is loaded";

}

/**
 * @brief get point Update
 * @return Updater::instance
 */
Updater *Updater::instance()
{
    if(updater_ == nullptr)
        updater_ = new Updater;

    return updater_;
}
