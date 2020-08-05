#include <QApplication>
#include <FelgoApplication>

#include <QQmlApplicationEngine>
#include <QQmlContext>

// uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
#include <FelgoLiveClient>
#include "src/settings.h"
#include "src/category.h"
#include "src/companylistbycategory.h"
#include "src/favoritecompanylist.h"
#include "src/Filters/filtermodel.h"

//TEST
#include "src/updater.h"
#include "src/Event/eventcategory.h"

//static QObject *singletonTypeProvider(QQmlEngine *, QJSEngine *)
//{
//    return Settings::Instance();
//}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    FelgoApplication felgo;

    qRegisterMetaTypeStreamOperators<Schedule>("Schedule");
    qRegisterMetaTypeStreamOperators<Company>("Company");
    qRegisterMetaTypeStreamOperators<QVector<Company>>("QVector<Company>");

    // Use platform-specific fonts instead of Felgo's default font
    felgo.setPreservePlatformFonts(true);

    QQmlApplicationEngine engine;
    felgo.initialize(&engine);
    qmlRegisterType<FilterModel>("com.cicerone.filterModel", 1, 0, "FilterModel");
    qmlRegisterSingletonType<Settings>("com.cicerone.filterModel", 1, 0, "Settings", /*singletonTypeProvider);*/
                                       [](QQmlEngine *qmlEngine, QJSEngine *scriptEngine)->QObject*
    {
//        qmlEngine->setContextOwnership(Settings::Instance(), QQmlEngine::CppOwnership);
        return Settings::Instance();
    });
//    Settings settings(&engine);
    Category category(&engine);
    EventController eventController(&engine);
    CompanyListByCategory companyListByCategory(&engine);
    FavoriteCompanyList favoriteCompanyList(&engine);
    // Set an optional license key from project file
    // This does not work if using Felgo Live, only for Felgo Cloud Builds and local builds
//    felgo.setLicenseKey(PRODUCT_LICENSE_KEY);

    // use this during development
    // for PUBLISHING, use the entry point below
    //felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));

    // use this instead of the above call to avoid deployment of the qml files and compile them into the binary with qt's resource system qrc
    // this is the preferred deployment option for publishing games to the app stores, because then your qml files and js files are protected
    // to avoid deployment of your qml files and images, also comment the DEPLOYMENTFOLDERS command in the .pro file
    // also see the .pro file for more details
    felgo.setMainQmlFileName(QStringLiteral("qrc:/main.qml"));

    engine.load(QUrl(felgo.mainQmlFileName()));
//    engine.rootContext()->setContextProperty("CiceroneSettings", &settings);
    engine.rootContext()->setContextProperty("Category", &category);
    engine.rootContext()->setContextProperty("CompanyList", &companyListByCategory);
    engine.rootContext()->setContextProperty("FavoriteCompanyList", &favoriteCompanyList);
    engine.rootContext()->setContextProperty("Events", &eventController);

    engine.addImportPath("qrc:/");
//    //    Test
//        Updater::instance()->startLoad();
//        //END TEST
    // to start your project as Live Client, comment (remove) the lines "felgo.setMainQmlFileName ..." & "engine.load ...",
    // and uncomment the line below
    //FelgoLiveClient client (&engine);

    return app.exec();
}
