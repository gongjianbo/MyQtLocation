# exe dir
DESTDIR  += $$PWD/App

INCLUDEPATH += $$PWD/DemoSrc
include($$PWD/DemoSrc/DemoSrc.pri)

DEFINES += QT_DEPRECATED_WARNINGS

# using static plugin at demo
DEFINES += MyMapPlugin_Static
contains(DEFINES,MyMapPlugin_Static){
    INCLUDEPATH += $$PWD/MyMapPlugin
    include($$PWD/MyMapPlugin/MyMapPlugin.pri)

    LOCATION_PLUGIN_DESTDIR = $${OUT_PWD}/MyMapPlugin
    LOCATION_PLUGIN_NAME    = GeoServiceProviderFactoryMyMap
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    LICENSE \
    README.md
