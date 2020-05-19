#include "updater.h"
#include <QUrl>
#include "Networker/urls.h"
#include "Networker/jsonfileloader.h"
#include "Networker/jsonnetworkloader.h"
#include "Networker/jsonsaver.h"

Updater* Updater::updater_ = nullptr;

void Updater::setNewStage(const Updater::Stages stage)
{
    currentStage = stage;
}

Updater::Updater(QObject *parent) : QObject(parent)
{
    _settings = make_unique<Settings>(this);
//    connect(this, &Updater::dataChanged, this, &Updater::ondataChanged);
}

/**
 * @brief start load data for models
 */
bool Updater::loadDataByName(const QString& name, const Stages nextStage)
{
    JsonFileLoader loaderCountry(QString("%1.json").arg(name));
    loaderCountry.load();
    if(loaderCountry.loadedJsonDocument().isEmpty())
    {
        JsonNetworkLoader jsonNetworkLoader(QString("%1%2/").arg(MAIN_URL).arg(name), name, this);
        jsonNetworkLoader.load();
    }
    auto isLoaded = !loaderCountry.loadedJsonDocument().toJson().isEmpty();
    if(isLoaded){
        dataChanged(name, loaderCountry.loadedJsonDocument().toJson());
        setNewStage(nextStage);
    }

    return isLoaded;
}

void Updater::startLoad()
{
    loadDataByName("country", Stages::CountryLoaded);
    loadDataByName("city", Stages::CityLoaded);
    loadDataByName("category", Stages::CategoryLoaded);
    loadDataByName("public-place", Stages::PublicPlacesLoaded);

    if(currentStage == Stages::PublicPlacesLoaded)
        emit dataLoaded();
}

QByteArray Updater::loadDataByStage(Updater::Resources resource)
{
    QString name = "";
    switch (resource) {
    case Resources::PublicPlace:
        name = "public-place";
        break;
    }

    JsonFileLoader loaderCountry(QString("%1.json").arg(name));
    loaderCountry.load();
    if(loaderCountry.loadedJsonDocument().isEmpty())
    {
        JsonNetworkLoader jsonNetworkLoader(QString("%1%2/").arg(MAIN_URL).arg(name), name, this);
        jsonNetworkLoader.load();
    }

    return loaderCountry.loadedJsonDocument().toJson();
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
