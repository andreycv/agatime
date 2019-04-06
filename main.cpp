#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "api/api.h"

int main(int argc, char *argv[])
{
    Api api;
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    engine.rootContext()->setContextProperty("api", &api);
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
