#ifndef UPDATER_H
#define UPDATER_H

#include <QObject>
#include <memory>
#include "settings.h"


using std::unique_ptr;
using std::make_unique;

/**
 * @brief Singleton Updater class
 */
class Updater : public QObject
{
    Q_OBJECT
    Updater(QObject *parent = nullptr);
    Updater(const Updater&) = delete;
    void operator=(const Updater &updater) = delete;
    unique_ptr<Settings> _settings;

protected:
    static Updater* updater_;
public:
    static Updater* instance();
    void startLoad();
};

#endif // UPDATER_H
