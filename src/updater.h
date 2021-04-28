#ifndef UPDATER_H
#define UPDATER_H

#include <QObject>
#include <QMap>
#include "settings.h"



/**
 * @brief Singleton Updater class
 */
class Updater : public QObject
{
    Q_OBJECT

    enum Stages { NoLoaded, CountryLoaded, CityLoaded, CategoryLoaded, PublicPlacesLoaded,
                  EventTypeLoaded, EventLoaded };

    Stages currentStage = Stages::NoLoaded;
    void setNewStage(const Stages stage);

    Updater(QObject *parent = nullptr);
    Updater(const Updater&) = delete;
    void operator=(const Updater &updater) = delete;
    bool loadDataByName(const QString& name, const Stages nextStage, bool needUpdate=true);

signals:
    void dataLoaded();
    void dataChanged(QString stage, QByteArray jsonData);

protected:
    static Updater* updater_;

public:
    static Updater* instance();
    enum Resources { PublicPlace, EventType, Event };
    void startLoad();
    QByteArray loadDataByStage(Resources resource);
};

#endif // UPDATER_H
