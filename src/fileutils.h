#ifndef FILEUTILS_H
#define FILEUTILS_H

#include <QObject>

class FileUtils : public QObject
{
    Q_OBJECT
public:
    explicit FileUtils(QObject *parent = nullptr);

    Q_INVOKABLE QString screenshotPath();
private:
    void makeDefaultMenu();
};

#endif // FILEUTILS_H
