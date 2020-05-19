#include "companylistbycategory.h"
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonValue>
#include <QDebug>
#include "updater.h"

CompanyListByCategory::CompanyListByCategory(QObject *parent)
    : QAbstractItemModel(parent)
{
    //INIT ROLES
    initializeRoles();

    parseData(Updater::instance()->loadDataByStage(Updater::Resources::PublicPlace));
}

int CompanyListByCategory::rowCount(const QModelIndex &parent) const
{
    if(parent.isValid())
        return 0;
    return filteredCompany.size();
}

int CompanyListByCategory::columnCount(const QModelIndex &parent) const
{
    if(parent.isValid())
        return 0;
    return 1;
}

QModelIndex CompanyListByCategory::parent(const QModelIndex &child) const
{
    Q_UNUSED(child)
    return QModelIndex();
}

void CompanyListByCategory::initializeRoles()
{
    roles[Id] = "CompanyId";
    roles[NameCompany] = "NameCompany";
    roles[IsFavorite] = "IsFavorite";
    roles[Address] = "Address";
    roles[ScheduleByCurrentDate] = "Schedule";
    roles[StateOpen] = "StateOpen";
    roles[Phones] = "Phones";
    roles[Facebook] = "FacebookLink";
    roles[Instagramm] = "Instagramm";
    roles[Www] = "WWW";
    roles[Email] = "Email";
    roles[Location] = "Location";
}

QVariant CompanyListByCategory::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || index.column() != 0 || index.row() < 0 || index.row() >= filteredCompany.count())
        return QVariant();

    const auto company = filteredCompany[index.row()];
    switch(role)
    {
    case Id: return company->id();
    case NameCompany: return company->getNameCompany();
    case IsFavorite: return company->getIsFavorite();
    case Address: return QVariant::fromValue(company->getLocationList());
    case ScheduleByCurrentDate: return company->scheduleByCurrentDate();
    case StateOpen: return company->stateOpen();
    case Facebook: return company->getFacebook();
    case Instagramm: return company->getInstagramm();
    case Www: return company->getWww();
    case Email: return company->getEmail();
    case Location: return company->getFormattedLocation();
    default: return QVariant();
    }
}

QModelIndex CompanyListByCategory::index(int row, int column, const QModelIndex &parent) const
{
    return hasIndex(row, column, parent) ? createIndex(row,column) : QModelIndex();
}

QHash<int, QByteArray> CompanyListByCategory::roleNames() const
{
    return roles;
}

void CompanyListByCategory::addCompany(Company *company)
{
    beginInsertRows(QModelIndex(), filteredCompany.size(), filteredCompany.size());
    filteredCompany.push_back(company);
    endInsertRows();
}

void CompanyListByCategory::removeCompanyByIndex(int index)
{
    if(index >= 0 && index < filteredCompany.size()){
        beginRemoveRows(QModelIndex(), index, index);
        filteredCompany.removeAt(index);
        endRemoveRows();
    }
}

void CompanyListByCategory::removeCompany(QString companyName)
{
    int companyNameIndex = -1;
    for(int i = 0; i < filteredCompany.size(); i++){
        if(filteredCompany.at(i)->getNameCompany() == companyName){
            companyNameIndex = i;
            break;
        }
    }

    if(companyNameIndex != -1)
        removeCompanyByIndex(companyNameIndex);
}

void CompanyListByCategory::changeIsFavoriteProperty(const int index, bool isFavorite)
{
    filteredCompany.at(index)->setIsFavorite(isFavorite);
}

void CompanyListByCategory::changeIsFavoriteProperty(QString companyName, bool isFavorite)
{
    for(int i = 0; i < filteredCompany.size(); i++){
        if(filteredCompany.at(i)->getNameCompany() == companyName){
            filteredCompany.at(i)->setIsFavorite(isFavorite);

            break;
        }
    }
}

void CompanyListByCategory::filterCompanyByCategoryIndex(const int index)
{
    //clear filtered company
    filteredCompany.clear();

//    start filter by category id
    for(Company* company : allCompanies)
        if(company->getCategoryId() == index)
            addCompany(company);
}

void CompanyListByCategory::parseData(QByteArray document)
{
    QJsonDocument doc = QJsonDocument::fromJson(document);
    auto array = doc.array();
    for(const auto item : array)
    {
        auto objectCompany = item.toObject();
        auto name_company = objectCompany.value("name_company").toString();
        Company *company = new Company(name_company, this);

        company->setCategoryId(objectCompany.value("category").toInt());

        //parse phone calls
        auto phonesArray = objectCompany.value("phones").toArray();
        QStringList phonesList;
        for(const auto phoneItem : phonesArray)
        {
            auto phoneObject = phoneItem.toObject();
            const auto phone = phoneObject.value("phone").toString();
            phonesList.push_back(phone);
        }
        auto locationArray = objectCompany.value("location").toArray();

        //parse locations
        QVector<LocationCompany> vectorAddresses;
        for(const auto location : locationArray)
        {
            auto locationObject = location.toObject();
            LocationCompany locationCompany;
            locationCompany.address = locationObject.value("address_location").toString();
            locationCompany.lat = locationObject.value("lat").toString();
            locationCompany.lng = locationObject.value("lng").toString();

            //add phones
            QStringList phonesList;
            const auto listJsonPhones = locationObject.value("phones").toArray();
            for(const auto phoneObject : listJsonPhones)
            {
                phonesList.push_back(phoneObject.toObject().value("phone_number").toString());
            }
            locationCompany.phones = phonesList;
            vectorAddresses.push_back(locationCompany);
        }
        company->setAddress(vectorAddresses);

        //parse schedule

        //!!!!! need to do very well
        {
            auto workingDaySchedule = objectCompany.value("working_days_schedule").toArray();
            for(const auto scheduleItem : workingDaySchedule)
            {
                auto scheduleObject = scheduleItem.toObject();
                auto workHourFrom = scheduleObject.value("work_time_from").toString();
                auto workHourTo = scheduleObject.value("work_time_to").toString();
                Schedule schedule;
                schedule.setFromByString(workHourFrom);
                company->setSheduleByCurrentDay(schedule);
            }
        }

        //parse social account
        {

            auto socialsArray = objectCompany.value("social").toArray();
            for(const auto socialItem : socialsArray)
            {
                const auto socialObject = socialItem.toObject();
                const auto nameSocial = socialObject.value("name_social_network").toString();
                const auto linkSocial = socialObject.value("link_social_network").toString();
                if(nameSocial == "facebook")
                    company->setFacebook(linkSocial);

                if(nameSocial == "instagram")
                    company->setInstagramm(linkSocial);

                if(nameSocial == "email")
                    company->setEmail(linkSocial);

            }
        }
        allCompanies.push_back(company);
    }
}
