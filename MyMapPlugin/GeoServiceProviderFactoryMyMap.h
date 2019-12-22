#ifndef GEOSERVICEPROVIDERFACTORYMYMAP_H
#define GEOSERVICEPROVIDERFACTORYMYMAP_H

#include <QtCore/QObject>
#include <QtLocation/QGeoServiceProviderFactory>

QT_BEGIN_NAMESPACE

class GeoServiceProviderFactoryMyMap : public QObject, public QGeoServiceProviderFactory
{
    Q_OBJECT
    Q_INTERFACES(QGeoServiceProviderFactory)
    Q_PLUGIN_METADATA(IID "org.qt-project.qt.geoservice.serviceproviderfactory/5.0"
                      FILE "mymap_plugin.json")
public:
    /*QGeoCodingManagerEngine *
    createGeocodingManagerEngine(const QVariantMap &parameters,
                                 QGeoServiceProvider::Error *error,
                                 QString *errorString) const override;*/
    QGeoMappingManagerEngine *
    createMappingManagerEngine(const QVariantMap &parameters,
                               QGeoServiceProvider::Error *error,
                               QString *errorString) const override;
    /*QGeoRoutingManagerEngine *
    createRoutingManagerEngine(const QVariantMap &parameters,
                               QGeoServiceProvider::Error *error,
                               QString *errorString) const override;
    QPlaceManagerEngine *
    createPlaceManagerEngine(const QVariantMap &parameters,
                             QGeoServiceProvider::Error *error,
                             QString *errorString) const override;*/
};

QT_END_NAMESPACE

#endif // GEOSERVICEPROVIDERFACTORYMYMAP_H
