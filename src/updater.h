#ifndef UPDATER_H
#define UPDATER_H

#include <QObject>
#include <memory>
#include <QMap>
#include "settings.h"


using std::unique_ptr;
using std::make_unique;

/**
 * @brief Singleton Updater class
 */
class Updater : public QObject
{
    Q_OBJECT

    enum Stages { NoLoaded, CountryLoaded, CityLoaded, CategoryLoaded, PublicPlacesLoaded };
    const QString MAIN_URL = "http://127.0.0.1:8000/api/v1/catalog/";

    Stages currentStage = Stages::NoLoaded;
    void setNewStage(const Stages stage);

    Updater(QObject *parent = nullptr);
    Updater(const Updater&) = delete;
    void operator=(const Updater &updater) = delete;
    unique_ptr<Settings> _settings;
    QMap<QString, QString> _namesAndUrls{ {"country", ""} };

    bool loadDataByName(const QString& name, const Stages nextStage);

signals:
    void dataLoaded();
    void dataChanged(QString stage, QByteArray jsonData);

protected:
    static Updater* updater_;
public:
    static Updater* instance();
    enum Resources { PublicPlace };
    void startLoad();
    QByteArray loadDataByStage(Resources resource);
};

#endif // UPDATER_H
