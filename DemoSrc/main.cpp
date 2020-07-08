#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#ifdef MyMapPlugin_Static
#include <QtPlugin>
#endif

#include  "GroupA/BoundaryModel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

#ifdef MyMapPlugin_Static
    Q_IMPORT_PLUGIN(GeoServiceProviderFactoryMyMap);
#endif

    QQmlApplicationEngine engine;

    qmlRegisterType<BoundaryModel>("MyMap", 1, 0, "BoundaryModel");
    engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
