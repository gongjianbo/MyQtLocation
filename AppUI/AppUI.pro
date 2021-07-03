QT += core
QT += gui
QT += widgets
QT += quick
QT += qml
QT += multimedia
QT += sql
QT += network
QT += concurrent
QT += location
QT += positioning

TEMPLATE = app

CONFIG += c++11
CONFIG += utf8_source
CONFIG += resources_big

DESTDIR = $$PWD/../bin
CONFIG(debug, debug|release){
#    LIBS += $$PWD/../plugin/MyMapPlugind.lib
    TARGET = MyQtLocationd
}
else{
#    LIBS += $$PWD/../plugin/MyMapPlugin.lib
    TARGET = MyQtLocation
}

# using static plugin at demo
DEFINES += MyMapPlugin_Static
contains(DEFINES,MyMapPlugin_Static){
    INCLUDEPATH += $$PWD/../MyMapPlugin
    include($$PWD/../MyMapPlugin/MyMapPlugin.pri)

    LOCATION_PLUGIN_DESTDIR = $${OUT_PWD}/MyMapPlugin
    LOCATION_PLUGIN_NAME    = MyMapFactory
}

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        main.cpp

RESOURCES += $$PWD/QML/qml.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
