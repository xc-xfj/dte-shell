/*
 * Copyright (C) 2020 ~ 2021 Uniontech Software Technology Co.,Ltd.
 *
 * Author:     xiaoyaobing <xiaoyaobing@uniontech.com>
 *
 * Maintainer: xiaoyaobing <xiaoyaobing@uniontech.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "fileutils.h"

#include <lipstick-qt5/homeapplication.h>

#include <QString>
#include <QQmlEngine>
#include <QQmlContext>
#include <QScreen>

int main(int argc, char *argv[])
{
    HomeApplication app(argc, argv, QString());

    app.setCompositorPath("/usr/share/lipstick-dte-ui/qml/compositor.qml");

    FileUtils *fileUtils = new FileUtils();

    // Handle lock screen orientation
    Qt::ScreenOrientation nativeOrientation = app.primaryScreen()->nativeOrientation();
    QByteArray v = qgetenv("GLACIER_NATIVEORIENTATION");
    if (!v.isEmpty()) {
        switch (v.toInt()) {
        case 1:
            nativeOrientation = Qt::PortraitOrientation;
            break;
        case 2:
            nativeOrientation = Qt::LandscapeOrientation;
            break;
        case 4:
            nativeOrientation = Qt::InvertedPortraitOrientation;
            break;
        case 8:
            nativeOrientation = Qt::InvertedLandscapeOrientation;
            break;
        default:
            nativeOrientation = app.primaryScreen()->nativeOrientation();
        }
    }
    if (nativeOrientation == Qt::PrimaryOrientation)
        nativeOrientation = app.primaryScreen()->primaryOrientation();
    app.engine()->rootContext()->setContextProperty("nativeOrientation", nativeOrientation);
    app.engine()->rootContext()->setContextProperty("fileUtils", fileUtils);
    app.engine()->addImportPath("/usr/lib/qt/qml");

    return app.exec();
}
