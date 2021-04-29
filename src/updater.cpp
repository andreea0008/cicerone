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
    //    connect(this, &Updater::dataChanged, this, &Updater::ondataChanged);
}

/**
 * @brief start load data for models
 */
bool Updater::loadDataByName(const QString& name, const Stages nextStage,  bool needUpdate)
{
    JsonFileLoader jsonFileLoader(QString("%1.json").arg(name));
    jsonFileLoader.load();
    if(jsonFileLoader.loadedJsonDocument().isEmpty() || needUpdate)
    {
        JsonNetworkLoader jsonNetworkLoader(QString("%1%2/").arg(MainUrl).arg(name), name, this);
        jsonNetworkLoader.load();
        jsonFileLoader.load();
    }
    auto isLoaded = !jsonFileLoader.loadedJsonDocument().toJson().isEmpty();
    if(isLoaded){
        dataChanged(name, jsonFileLoader.loadedJsonDocument().toJson());
        setNewStage(nextStage);
    }

    return isLoaded;
}

void Updater::startLoad()
{
    loadDataByName("country", Stages::CountryLoaded);
    loadDataByName("city", Stages::CityLoaded);
    loadDataByName("category", Stages::CategoryLoaded);
    loadDataByName("public_place", Stages::PublicPlacesLoaded);
    loadDataByName("event_type", Stages::EventTypeLoaded);
    loadDataByName("event", Stages::EventLoaded);

    if(currentStage == Stages::EventLoaded) emit dataLoaded();
}

QByteArray Updater::loadDataByStage(Updater::Resources resource)
{
    //QPair<name, url>
    QPair<QString, QString> data;
    switch (resource) {
    case Resources::PublicPlace: data = { "public_place", PublicPlaceUrl }; break;
    case Resources::EventType: data = { "event_type", EventTypeUrl }; break;
    case Resources::Event: data = { "event", EventUrl }; break;
    }

    const QString name = data.first;
    const QString url = data.second;

    JsonFileLoader jsonFileLoader(QString("%1.json").arg(name));
    jsonFileLoader.load();
    if(jsonFileLoader.loadedJsonDocument().isEmpty())
    {
        JsonNetworkLoader jsonNetworkLoader(url, QString("%1.json").arg(name), this);
        jsonNetworkLoader.load();
        jsonFileLoader.load();
    }

    return jsonFileLoader.loadedJsonDocument().toJson();
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
