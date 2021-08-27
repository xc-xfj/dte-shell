#include "fileutils.h"

#include <QDir>
#include <QFile>
#include <QDateTime>
#include <QTextStream>
#include <QStandardPaths>

FileUtils::FileUtils(QObject *parent)
    : QObject(parent)
{
    if(!QFile::exists(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/lipstick/applications.menu")) {
        makeDefaultMenu();
    }
}

QString FileUtils::screenshotPath()
{
    QString screenshotDir = QStandardPaths::writableLocation(QStandardPaths::PicturesLocation)+"/Screenshots";

    QDir scrDir;

    if(!scrDir.exists(screenshotDir)) {
        scrDir.mkpath(screenshotDir);
    }

    QString path = screenshotDir+"/"+tr("Screenshot")+"_"+QDateTime::currentDateTime().toString("ddMMyyyy-hhmmss")+".png";

    return path;
}

void FileUtils::makeDefaultMenu()
{
    QDir lipctickConfigDir(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/lipstick");
    if(!lipctickConfigDir.exists()) {
        lipctickConfigDir.mkpath(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/lipstick");
    }

    QFile menu(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/lipstick/applications.menu");
    menu.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream out(&menu);
    out << "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    out << "<Menu>\n";
    out << "    <Filename>glacier-dialer.desktop</Filename>\n";
    out << "    <Filename>glacier-messages.desktop</Filename>\n";
    out << "    <Filename>glacier-contacts.desktop</Filename>\n";
    out << "    <Filename>glacier-settings.desktop</Filename>\n";
    out << "    <Filename>glacier-camera.desktop</Filename>\n";
    out << "</Menu>\n";
    menu.close();
}
