#include "mainsqlquery.h"
#include <QSqlQuery>

MainSqlQuery::MainSqlQuery(const QSqlDatabase &database, QObject *parent): QAbstractListModel(parent)
{
    this->_db = database;
}

int MainSqlQuery::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) {
           return 0;
       }

    return this->editionsItem.size();
}

QVariant MainSqlQuery::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
            return QVariant();
        }

        switch (role) {
        case CodeRole:
            return editionsItem.at(index.row())["code"];
        case FirstZaglRole:
            return editionsItem.at(index.row())["firstZagl"];
        case FNameRole:
            return editionsItem.at(index.row())["FName"];
        case LNameRole:
            return editionsItem.at(index.row())["LName"];
        case MInitialRole:
            return editionsItem.at(index.row())["MInitial"];
        default:
            return QVariant();
        }
}

QHash<int, QByteArray> MainSqlQuery::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
        roles[CodeRole] = "code";
        roles[FirstZaglRole] = "firstZagl";
        roles[FNameRole] = "FName";
        roles[LNameRole] = "LName" ;
        roles[MInitialRole] = "MInitial" ;

        return roles;
}

void MainSqlQuery::add(const QVariantMap &map)
{
        beginInsertRows(QModelIndex(), this->editionsItem.size(), this->editionsItem.size());
        this->editionsItem.append(map);
        endInsertRows();

        QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
        emit dataChanged(index, index);
}

void MainSqlQuery::remove(int item)
{
    beginRemoveRows(QModelIndex(),item,item);
    this->editionsItem.removeAt(item);
    endRemoveRows();

    QModelIndex index = createIndex(item, item, static_cast<void *>(0));
    emit dataChanged(index,index);
}


