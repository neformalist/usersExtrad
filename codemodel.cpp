#include "codemodel.h"
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>
#include <QSqlRecord>
#include <QSqlQueryModel>

CodeModel::CodeModel(const QSqlDatabase &database, QObject *parent): QSqlQueryModel(parent)
{
    this->_db = database;
}

void CodeModel::setQuery(const QString &query)
{
    QString str_query = QString("SELECT  Editions.shifr, Editions.firstZagl, "
                                "Composers.LName, Composers.FName "
                                "FROM Editions "
                                "LEFT JOIN EditionsComposers "
                                "ON Editions.ID = EditionsComposers.EditionID "
                                "LEFT JOIN Composers "
                                "ON EditionsComposers.ComposersId = Composers.id "
                                "WHERE Editions.shifr = '%1'").arg(query);
    QSqlQueryModel::setQuery(str_query, _db);
}

QVariantMap CodeModel::get(int row) const
{
    QVariantMap map;
    foreach (int k, roleNames().keys()) {
        map[roleNames().value(k)] = data(index(row,0), k);
    }
    return map;
}

QVariant CodeModel::data(const QModelIndex &index, int role) const
{
    int columnId = role - Qt::UserRole - 1;

    QModelIndex modelIndex = this->index(index.row(), columnId);

    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> CodeModel::roleNames() const
{
    QHash<int, QByteArray> roles;
        roles[CodeRole] = "shifr";
        roles[FirstZaglRole] = "firstZagl";
        roles[LNameRole] = "LName";
        roles[FNameRole] = "FName";
        return roles;
}
