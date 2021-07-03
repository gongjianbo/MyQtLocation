QT -= gui
QT += core
QT += sql
QT += network
QT += concurrent
qtHaveModule(location-private){
    QT += location-private
}else{
    QT += location
}
qtHaveModule(positioning-private){
    QT += positioning-private
}else{
    QT += positioning
}

CONFIG += c++11
CONFIG += utf8_source

HEADERS += \
    $$PWD/GeoTileFetcherMyMap.h \
    $$PWD/GeoTiledMapReplyMyMap.h \
    $$PWD/GeoTiledMappingManagerEngineMyMap.h \
    $$PWD/MyMapFactory.h

SOURCES += \
    $$PWD/GeoTileFetcherMyMap.cpp \
    $$PWD/GeoTiledMapReplyMyMap.cpp \
    $$PWD/GeoTiledMappingManagerEngineMyMap.cpp \
    $$PWD/MyMapFactory.cpp

DISTFILES += \
    $$PWD/mymap_plugin.json
