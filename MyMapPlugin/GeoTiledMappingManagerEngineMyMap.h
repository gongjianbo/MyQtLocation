#pragma once
#include <QtLocation/QGeoServiceProvider>
#include <QtLocation/private/qgeotiledmappingmanagerengine_p.h>

QT_BEGIN_NAMESPACE

/**
 * @brief 提供瓦片地图服务
 * @author 龚建波
 * @date 2021-07-03
 */
class GeoTiledMappingManagerEngineMyMap : public QGeoTiledMappingManagerEngine
{
    Q_OBJECT
public:
    GeoTiledMappingManagerEngineMyMap(
            const QVariantMap &parameters,
            QGeoServiceProvider::Error *error,
            QString *errorString);
    ~GeoTiledMappingManagerEngineMyMap();

    QGeoMap *createMap() override;
};
QT_END_NAMESPACE

