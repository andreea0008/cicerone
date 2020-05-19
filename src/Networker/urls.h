#ifndef URLS_H
#define URLS_H
#include <QString>
#include <QUrl>

#define COUNTRY_URL "127.0.0.1:8000/api/v1/catalog/country/"

struct Urls
{
public:
    QString countryUrl = "127.0.0.1:8000/api/v1/catalog/country/";

};

//#include <QString>
//class AllUrls{
//public:
//    inline static QString MAIN_URL ="127.0.0.1:8000/api/v1/catalog";
//    inline static QString COUNTRIES_URL = QString("%1/country/").arg(MAIN_URL);
//    inline QString country_url()
//    {
//        return COUNTRIES_URL;
//    }
//};

#endif // URLS_H
