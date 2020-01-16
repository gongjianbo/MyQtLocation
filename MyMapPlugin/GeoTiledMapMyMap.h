#ifndef GEOTILEDMAPMYMAP_H
#define GEOTILEDMAPMYMAP_H

#include <QtLocation/private/qgeotiledmap_p.h>

QT_BEGIN_NAMESPACE
class GeoTiledMapMyMap : public QGeoTiledMap
{
    Q_OBJECT
public:
    GeoTiledMapMyMap(QGeoTiledMappingManagerEngine *engine, QObject *parent = nullptr);
};
QT_END_NAMESPACE

#endif // GEOTILEDMAPMYMAP_H
