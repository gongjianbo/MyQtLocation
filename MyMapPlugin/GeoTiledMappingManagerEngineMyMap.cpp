#include "GeoTiledMappingManagerEngineMyMap.h"

#include "GeoTiledMapMyMap.h"
#include "GeoTileFetcherMyMap.h"

#include <QtLocation/private/qgeocameracapabilities_p.h>
#include <QtLocation/private/qgeomaptype_p.h>
#include <QtLocation/private/qgeotiledmap_p.h>
#include <QtLocation/private/qgeofiletilecache_p.h>

QT_BEGIN_NAMESPACE
GeoTiledMappingManagerEngineMyMap::GeoTiledMappingManagerEngineMyMap(
        const QVariantMap &parameters,
        QGeoServiceProvider::Error *error,
        QString *errorString)
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

    //瓦片加载
    GeoTileFetcherMyMap *tileFetcher = new GeoTileFetcherMyMap(parameters, this);
    setTileFetcher(tileFetcher);

    //瓦片缓存-这部分参考QtLocation的esri部分源码
    //没有用QGeoFileTileCache，默认加载地缓存不会释放，还没找到原因，估计要分析它的源码
    QString cacheDirectory=QAbstractGeoTileCache::baseLocationCacheDirectory() + QString("mymap");
    QGeoFileTileCache *tileCache = new QGeoFileTileCache(cacheDirectory,this);

    /*
     * Disk cache setup -- defaults to ByteSize (old behavior)
     */
    tileCache->setCostStrategyDisk(QGeoFileTileCache::ByteSize);

    /*
     * Memory cache setup -- defaults to ByteSize (old behavior)
     */
    tileCache->setCostStrategyMemory(QGeoFileTileCache::ByteSize);

    /*
     * Texture cache setup -- defaults to ByteSize (old behavior)
     */
    tileCache->setCostStrategyTexture(QGeoFileTileCache::ByteSize);

    /* PREFETCHING */
    m_prefetchStyle = QGeoTiledMap::NoPrefetching;
    setTileCache(tileCache);

    //m_prefetchStyle = QGeoTiledMap::NoPrefetching;
    *error = QGeoServiceProvider::NoError;
    errorString->clear();
}

GeoTiledMappingManagerEngineMyMap::~GeoTiledMappingManagerEngineMyMap()
{
}

QGeoMap *GeoTiledMappingManagerEngineMyMap::createMap()
{
    QGeoTiledMap *map=new QGeoTiledMap(this,nullptr);
    map->setPrefetchStyle(m_prefetchStyle);
    return map;
}
QT_END_NAMESPACE
