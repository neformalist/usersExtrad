#include "DBCore.h"
#include <QDebug>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QMap>
#include <QSqlError>

DBCore::DBCore(const QVector<QMap<QString, QString>> * dbName, QObject *parent) : QObject(parent)
{
    for(int i = 0; i<dbName->size(); ++i)
    {
       DB[dbName->at(i).value("name")] = QSqlDatabase::addDatabase("QODBC3", dbName->at(i).value("name"));
       QSqlDatabase db =  DB.value(dbName->at(i).value("name"));

       QString connection = QString("DRIVER={SQL Server};SERVER=%1;DATABASE=%2;UID=%3;PWD=%4")
       .arg(dbName->at(i).value("hostname")).arg(dbName->at(i).value("dbname")).arg(dbName->at(i).value("username")).arg(dbName->at(i).value("password"));

       db.setDatabaseName(connection);

       if(db.open()) qDebug() << "OPEN";
       else qDebug() << db.lastError();
    }
}

void DBCore::test()
{
    qDebug() << DB["MUZLIB"].connectionName();
}

QSqlDatabase DBCore::getDataBase( const QString &name) const
{
    return DB[name];
}

DBCore::~DBCore()
{
    qDebug() << "Destructor";
    QMap<QString, QSqlDatabase>::iterator it = DB.begin();
    while(it != DB.end())
    {
        it.value().close();
        qDebug() << it.key() << " CLOSE";
        ++it;
    }
}

void DBCore::cppSlot(QString name, QString vorname, QString middlename, QString company, QString passport)
{
    qDebug() << name << " " << vorname << " " + middlename << " " + company << " " + passport << " ";
}

