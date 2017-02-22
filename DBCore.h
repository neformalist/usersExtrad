#ifndef DBCORE_H
#define DBCORE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QMap>
#include <QVector>

class DBCore : public QObject
{
    Q_OBJECT
public:
    explicit DBCore(const QVector<QMap<QString, QString> > *dbName, QObject *parent = 0);

    void test();

    QSqlDatabase getDataBase(const QString &name) const;

    ~DBCore();
signals:

public slots:
    void cppSlot(QString name, QString vorname, QString middlename, QString company, QString passport );
private:
    QMap<QString, QSqlDatabase> DB;

};

#endif // DBCORE_H
