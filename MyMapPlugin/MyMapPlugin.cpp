#include "MyMapPlugin.h"
#include "GeoTiledMappingManagerEngineMyMap.h"
#include <QtLocation/private/qgeotiledmappingmanagerengine_p.h>

QT_USE_NAMESPACE
MyMapPlugin::MyMapPlugin()
{

}

QGeoMappingManagerEngine *MyMapPlugin::createMappingManagerEngine(const QVariantMap &parameters, QGeoServiceProvider::Error *error, QString *errorString) const
{
    return new GeoTiledMappingManagerEngineMyMap(parameters, error, errorString);
}
