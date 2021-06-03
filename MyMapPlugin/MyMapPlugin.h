#pragma once
#include <QtCore/QObject>
#include <QtLocation/QGeoServiceProviderFactory>

QT_BEGIN_NAMESPACE

class MyMapPlugin : public QObject, public QGeoServiceProviderFactory
{
    Q_OBJECT
    Q_INTERFACES(QGeoServiceProviderFactory)
    Q_PLUGIN_METADATA(IID "org.qt-project.qt.geoservice.serviceproviderfactory/5.0"
                      FILE "mymap_plugin.json")
public:
    MyMapPlugin();

    QGeoMappingManagerEngine *
    createMappingManagerEngine(const QVariantMap &parameters,
                               QGeoServiceProvider::Error *error,
                               QString *errorString) const override;
};

QT_END_NAMESPACE
