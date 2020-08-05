#ifndef URLS_H
#define URLS_H

#include <QString>

static const QString MainUrl = QString("http://127.0.0.1:8000/api/v1/catalog/");
static const QString PublicPlaceUrl = QString("%1public_place/").arg(MainUrl);
static const QString EventTypeUrl = QString("%event_type/").arg(MainUrl);
static const QString EventUrl = QString("%1event/").arg(MainUrl);

#endif // URLS_H
