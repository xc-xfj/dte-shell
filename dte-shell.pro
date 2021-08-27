TEMPLATE = app
TARGET = dte-shell
VERSION = 0.1

target.path += /usr/bin
INSTALLS = target

CONFIG += sailfishapp
QT += core gui quick

SOURCES += \
    src/fileutils.cpp \
    src/main.cpp

HEADERS += \
    src/fileutils.h

RESOURCES += \
    dte-shell.qrc

OTHER_FILES += \
    qml/*.qml \
    rpm/dte-shell.spec

CONFIG += link_pkgconfig
PKGCONFIG += lipstick-qt5

