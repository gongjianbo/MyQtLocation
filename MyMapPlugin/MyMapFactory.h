#pragma once
#include <QtCore/QObject>
#include <QtLocation/QGeoServiceProviderFactory>

QT_BEGIN_NAMESPACE

/**
 * @brief 插件入口
 * @author 龚建波
 * @date 2021-07-03
 * @details
 * 插件实现者需要子类化 QGeoServiceProviderFactory
 * 和他们想要为其提供实现的尽可能多的 ManagerEngine 类
 */
class MyMapFactory : public QObject, public QGeoServiceProviderFactory
{
    Q_OBJECT
    Q_INTERFACES(QGeoServiceProviderFactory)
    Q_PLUGIN_METADATA(IID "org.qt-project.qt.geoservice.serviceproviderfactory/5.0"
                      FILE "mymap_plugin.json")
public:
    MyMapFactory();

    //QGeoCodingManagerEngine *createGeocodingManagerEngine(const QVariantMap &parameters,
    //                                                      QGeoServiceProvider::Error *error,
    //                                                      QString *errorString) const;
    //QGeoRoutingManagerEngine *createRoutingManagerEngine(const QVariantMap &parameters,
    //                                                     QGeoServiceProvider::Error *error,
    //                                                     QString *errorString) const;
    //QPlaceManagerEngine *createPlaceManagerEngine(const QVariantMap &parameters,
    //                                              QGeoServiceProvider::Error *error,
    //                                              QString *errorString) const;
    QGeoMappingManagerEngine *createMappingManagerEngine(const QVariantMap &parameters,
                                                         QGeoServiceProvider::Error *error,
                                                         QString *errorString) const;
};
QT_END_NAMESPACE
