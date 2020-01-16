#ifndef GEOTILEDMAPPINGMANAGERENGINEMYMAP_H
#define GEOTILEDMAPPINGMANAGERENGINEMYMAP_H

#include <QtLocation/QGeoServiceProvider>
#include <QtLocation/private/qgeotiledmappingmanagerengine_p.h>

QT_BEGIN_NAMESPACE

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

#endif // GEOTILEDMAPPINGMANAGERENGINEMYMAP_H
