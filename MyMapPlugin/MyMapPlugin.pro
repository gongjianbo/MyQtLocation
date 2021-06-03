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

TEMPLATE = lib

CONFIG += c++11
CONFIG += utf8_source
#CONFIG += staticlib
CONFIG += plugin
CONFIG += relative_qt_rpath  # Qt's plugins should be relocatable

DESTDIR = $$PWD/../plugin
CONFIG(debug, debug|release){
    TARGET = MyMapPlugind
}
else{
    TARGET = MyMapPlugin
}

PLUGIN_TYPE = geoservices
PLUGIN_CLASS_NAME = MyMapPlugin
target.path = $$[QT_INSTALL_PLUGINS]/$$PLUGIN_TYPE
INSTALLS += target

DEFINES += QT_DEPRECATED_WARNINGS

# Default rules for deployment.
unix {
    target.path = /usr/lib
}
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    GeoTileFetcherMyMap.h \
    GeoTiledMapReplyMyMap.h \
    GeoTiledMappingManagerEngineMyMap.h \
    MyMapPlugin.h

SOURCES += \
    GeoTileFetcherMyMap.cpp \
    GeoTiledMapReplyMyMap.cpp \
    GeoTiledMappingManagerEngineMyMap.cpp \
    MyMapPlugin.cpp

DISTFILES += \
    mymap_plugin.json
