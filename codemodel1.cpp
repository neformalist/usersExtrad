#include <QDebug>
#include <QSqlError>
#include <QSqlRecord>
#include <QSqlQuery>
#include <QVariantMap>
#include "codemodel1.h"

CodeModel1::CodeModel1(const QSqlDatabase &database, QObject * parent): QObject(parent)
{
    this->_db = database;
    this->clear();
}

bool CodeModel1::find(const QString &ask)
{
    QString str_query = QString("SELECT  Editions.shifr, Editions.firstZagl, "
                                "Composers.LName, Composers.FName, Composers.MInitial "
                                "FROM Editions "
                                "LEFT JOIN EditionsComposers "
                                "ON Editions.ID = EditionsComposers.EditionID "
                                "LEFT JOIN Composers "
                                "ON EditionsComposers.ComposersId = Composers.id "
                                "WHERE Editions.shifr = '%1'").arg(ask);

    QSqlQuery query(this->_db);
    query.exec(str_query);

    if(!query.numRowsAffected())
    {
        qDebug() << "false";
        this->clear();
        return false;
    }
    while(query.next())
    {
        this->data["Code"] = query.value(0).toString();
        this->data["FirstZagl"] = query.value(1).toString();
        this->data["LName"] = query.value(2).toString();
        this->data["FName"] = query.value(3).toString();
        this->data["MInitial"] = query.value(4).toString();
    }

    return true;

}

QVariantMap CodeModel1::get() const
{
    return this->data;
}

void CodeModel1::clear()
{
    this->data["Code"] = "";
    this->data["FirstZagl"] = "";
    this->data["LName"] = "";
    this->data["FName"] = "";
    this->data["MInitial"] = "";
}
