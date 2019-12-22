#ifndef GEOTILEDMAPPINGMANAGERENGINEMYMAP_H
#define GEOTILEDMAPPINGMANAGERENGINEMYMAP_H

#include <QtLocation/QGeoServiceProvider>
#include <QtLocation/private/qgeotiledmappingmanagerengine_p.h>

#include <QVector>

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

    virtual QGeoMap *createMap();

private:

};
QT_END_NAMESPACE

#endif // GEOTILEDMAPPINGMANAGERENGINEMYMAP_H
