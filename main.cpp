#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "src/category.h"


int main(int argc, char *argv[])
{
//    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<Category>("com.yourcompany.xyz", 1, 0, "MyQMLType");
//    Category *cat = new Category(&engine);
//    engine.rootContext()->setContextProperty("category_xml", cat);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    if (engine.rootObjects().isEmpty())
//        return -1;

    return app.exec();
}
