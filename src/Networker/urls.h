#ifndef URLS_H
#define URLS_H

#include <QString>
const QString MAIN_URL = "http://127.0.0.1:8000/api/v1/catalog";
const QString COUNTRIES_URL = QString("%1/country").arg(MAIN_URL);

#endif // URLS_H
