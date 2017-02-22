#ifndef SETTINGDB_H
#define SETTINGDB_H
#include <QObject>
#include <QVector>
#include <QMap>

class settingDB : QObject
{
public:
    settingDB(QObject * parent = 0);
    ~settingDB();

    void setDbSetting();

    const QVector<QMap<QString, QString> > *getDbSetting() const;
private:

    QVector<QMap<QString, QString>> SetDB;

    const QString name = "name";
    const QString hostname = "hostname";
    const QString dbname = "dbname";
    const QString username = "username";
    const QString password = "password";

};

#endif // SETTINGDB_H
