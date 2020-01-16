#include "GeoTiledMappingManagerEngineMyMap.h"

#include "GeoTiledMapMyMap.h"
#include "GeoTileFetcherMyMap.h"

#include <QtLocation/private/qgeocameracapabilities_p.h>
#include <QtLocation/private/qgeomaptype_p.h>
#include <QtLocation/private/qgeotiledmap_p.h>
#include <QtLocation/private/qgeofiletilecache_p.h>

QT_BEGIN_NAMESPACE
GeoTiledMappingManagerEngineMyMap::GeoTiledMappingManagerEngineMyMap(const QVariantMap &parameters, QGeoServiceProvider::Error *error, QString *errorString)
{
    QGeoCameraCapabilities cameraCaps;
    cameraCaps.setMinimumZoomLevel(0.0);
    cameraCaps.setMaximumZoomLevel(20.0);
    cameraCaps.setSupportsBearing(true);
    cameraCaps.setSupportsTilting(true);
    cameraCaps.setMinimumTilt(0);
    cameraCaps.setMaximumTilt(80);
    cameraCaps.setMinimumFieldOfView(20.0);
    cameraCaps.setMaximumFieldOfView(120.0);
    cameraCaps.setOverzoomEnabled(true);
    setCameraCapabilities(cameraCaps);

    setTileSize(QSize(256, 256));

    //setTileCache(tileCache); //这应该是做离线地图的接口

    GeoTileFetcherMyMap *tileFetcher = new GeoTileFetcherMyMap(parameters, this);
    setTileFetcher(tileFetcher);

    //m_prefetchStyle = QGeoTiledMap::NoPrefetching;
    *error = QGeoServiceProvider::NoError;
    errorString->clear();
}

GeoTiledMappingManagerEngineMyMap::~GeoTiledMappingManagerEngineMyMap()
{

}

QGeoMap *GeoTiledMappingManagerEngineMyMap::createMap()
{
    GeoTiledMapMyMap *map=new GeoTiledMapMyMap(this);
    //map->setPrefetchStyle(m_prefetchStyle);
    return map;
}
QT_END_NAMESPACE
