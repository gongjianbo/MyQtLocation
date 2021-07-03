TEMPLATE = subdirs

SUBDIRS += \
#    MyMapPlugin \
    AppUI

#AppUI.depends += MyMapPlugin

lessThan(QT_MAJOR_VERSION, 5) | lessThan(QT_MINOR_VERSION, 12) {
    error("Qt version too low, minimum support Qt 5.12.")
}else{
    message(Qt version: $$QT_VERSION)
}

DISTFILES += \
    LICENSE \
    README.md
