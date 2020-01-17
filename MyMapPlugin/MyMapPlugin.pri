qtHaveModule(location-private) {
        QT += location-private
} else {
        QT += location
}
qtHaveModule(positioning-private) {
        QT += positioning-private
} else {
        QT += positioning
}
QT += network

DISTFILES += \
    $$PWD/mymap_plugin.json \
    $$PWD/MyMapPlugin.pro

HEADERS += \
    $$PWD/GeoServiceProviderFactoryMyMap.h \
    $$PWD/GeoTileFetcherMyMap.h \
    $$PWD/GeoTiledMapReplyMyMap.h \
    $$PWD/GeoTiledMappingManagerEngineMyMap.h

SOURCES += \
    $$PWD/GeoServiceProviderFactoryMyMap.cpp \
    $$PWD/GeoTileFetcherMyMap.cpp \
    $$PWD/GeoTiledMapReplyMyMap.cpp \
    $$PWD/GeoTiledMappingManagerEngineMyMap.cpp
