TEMPLATE = lib
CONFIG += plugin
CONFIG += relative_qt_rpath  # Qt's plugins should be relocatable
TARGET = qtgeoservices_mymap
TARGET = $$qt5LibraryTarget($$TARGET)

PLUGIN_TYPE = geoservices
PLUGIN_CLASS_NAME = GeoServiceProviderFactoryMyMap
target.path = $$[QT_INSTALL_PLUGINS]/$$PLUGIN_TYPE
INSTALLS += target

#DESTDIR = $$[QT_INSTALL_PLUGINS]/$$PLUGIN_TYPE

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

CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS

DISTFILES += \
    mymap_plugin.json

HEADERS += \
    GeoServiceProviderFactoryMyMap.h \
    GeoTileFetcherMyMap.h \
    GeoTiledMapMyMap.h \
    GeoTiledMapReplyMyMap.h \
    GeoTiledMappingManagerEngineMyMap.h

SOURCES += \
    GeoServiceProviderFactoryMyMap.cpp \
    GeoTileFetcherMyMap.cpp \
    GeoTiledMapMyMap.cpp \
    GeoTiledMapReplyMyMap.cpp \
    GeoTiledMappingManagerEngineMyMap.cpp

# Default rules for deployment.
#unix {
#    target.path = /usr/lib
#}
#!isEmpty(target.path): INSTALLS += target
