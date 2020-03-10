#ifndef JSONFILELOADER_H
#define JSONFILELOADER_H

#include <QObject>
#include <memory>
#include "networkloader.h"
#include <QFile>
#include <QJsonDocument>

/**
 * @brief The JsonFileLoader RAII class
 */

class JsonFileLoader : public NetworkLoader
{
    Q_OBJECT
public:
    JsonFileLoader(const QString location, QObject * parent= nullptr);
    ~JsonFileLoader() override;

    virtual void load() override;
    virtual void save() override;

    QJsonDocument loadedJsonDocument() const;

private:
    std::unique_ptr<QFile> file_;
    QJsonDocument jsonDocument_;
    QString location_;

};

#endif // JSONFILELOADER_H
