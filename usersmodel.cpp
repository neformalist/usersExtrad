#include "usersmodel.h"
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>

UsersModel::UsersModel(const QSqlDatabase &database, QObject *parent): QSqlQueryModel(parent)
{
    this->_db = database;
    this->updateModel();
}

QVariant UsersModel::data(const QModelIndex &index, int role) const
{
    int columnId = role - Qt::UserRole - 1;

    QModelIndex modelIndex = this->index(index.row(), columnId);

    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QStringList UsersModel::getData(int row)
{
    this->data(this->index(row, 0), IdRole).toInt();
}

QHash<int, QByteArray> UsersModel::roleNames() const
{
    QHash<int, QByteArray> roles;
        roles[IdRole] = "id";
        roles[NameRole] = "name";
        roles[VornameRole] = "vorname";
        roles[MiddlenameRole] = "middlename";
        roles[Company] = "company";
        roles[Passport] = "passport";
        return roles;
}

bool UsersModel::insert(QString name, QString vorname, QString middlename, QString company, QString passport)
{
    QSqlQuery query(this->_db);
    QString queryStr = QString("INSERT INTO " USERTABLE " (name, vorname, middlename, company, passport) VALUES ('%1', '%2', '%3', '%4', '%5')")
            .arg(name).arg(vorname).arg(middlename).arg(company).arg(passport);

    if(query.exec(queryStr))
    {
        this->updateModel();
        return true;
    }else
    {
        qDebug() << query.lastError();
        return false;
    }
}

int UsersModel::getID(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}

bool UsersModel::validateInsertUser(QString name, QString company) const
{
    if(name.isEmpty() && company.isEmpty()) return false;
    return true;
}

bool UsersModel::removeRecord(const int id)
{
    QSqlQuery query(this->_db);
    QString queryStr = QString("DELETE FROM " USERTABLE " WHERE id=%1").arg(id);
    if(query.exec(queryStr))
    {
        emit successDeleteUser();
        return true;
    }else
    {
        qDebug() << query.lastError();
        emit errorDeleteUser();
        return false;
    }
}

void UsersModel::updateModel()
{
    QString query = "SELECT * FROM " USERTABLE;
    this->setQuery(query, _db);
}

bool UsersModel::insertUser(QString name, QString vorname, QString middlename, QString company, QString passport)
{
    if(!this->validateInsertUser(name, company))
    {
        emit notValidateInsert();
        return false;
    }

    if(this->insert(name, vorname, middlename, company, passport))
    {
        emit successInsertingToDb();
        return true;
    }else
    {
        emit errorInsertingToDb();
        return false;
    }
}

