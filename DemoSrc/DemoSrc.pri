QT += core gui qml quick
QT += concurrent
QT += location positioning

CONFIG += c++11 utf8_source

HEADERS += \
    $$PWD/GroupA/BoundaryModel.h

SOURCES += \
        $$PWD/GroupA/BoundaryModel.cpp \
        $$PWD/main.cpp

RESOURCES += $$PWD/qml.qrc \
    $$PWD/GroupA/GroupA.qrc \
    $$PWD/GroupB/GroupB.qrc



