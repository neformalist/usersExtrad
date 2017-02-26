#include "settingdb.h"
#include <QDebug>

settingDB::settingDB(QObject *parent): QObject(parent)
{
    this->setDbSetting();
}

settingDB::~settingDB()
{
    qDebug() << "DESCTRUCTOR settingDB";
}

void settingDB::setDbSetting()
{
    QMap<QString, QString> map;
    map[name] = "MUZLIB";
    map[hostname] = "LOCALHOST\\SQLEXPRESS";
    map[dbname] = "muzlib";
    map[username] = "";
    map[password] = "";

    this->SetDB.push_back(map);

    map[name] = "USERS";
    map[hostname] = "LOCALHOST\\SQLEXPRESS";
    map[dbname] = "users";
    map[username] = "";
    map[password] = "";

    this->SetDB.push_back(map);
}

const QVector<QMap<QString, QString>> * settingDB::getDbSetting() const
{
    return &this->SetDB;
}
