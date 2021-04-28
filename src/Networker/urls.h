#ifndef URLS_H
#define URLS_H

#include <QString>

static const bool LOCAL_MODE = 0;
static const QString MainUrl = QString("%1/api/v1/catalog/")
        .arg(LOCAL_MODE ? "http://127.0.0.1:8000"
                        : "https://dev-cicerone.herokuapp.com");

static const QString PublicPlaceUrl = QString("%1public_place/").arg(MainUrl);
static const QString EventTypeUrl = QString("%1event_type/").arg(MainUrl);
static const QString EventUrl = QString("%1event/").arg(MainUrl);

#endif // URLS_H
