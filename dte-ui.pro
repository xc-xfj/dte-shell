TEMPLATE = app
TARGET = lipstick
VERSION = 0.1

target.path += /usr/bin
INSTALLS = target

QT += core gui quick

SOURCES += \
    fileutils.cpp \
    main.cpp

RESOURCES += \
    dte-ui.qrc

CONFIG += link_pkgconfig
PKGCONFIG += lipstick-qt5

HEADERS += \
    fileutils.h
