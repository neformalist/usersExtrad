#ifndef USERSMODEL_H
#define USERSMODEL_H
#include <QSqlQueryModel>

#define USERTABLE "userTable"
#define ID "id"
#define NAME "name"
#define VORNAME "vorname"
#define MIDDLENAME "middlename"
#define COMPANY "company"
#define PASSPORT "passport"

class UsersModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    UsersModel(const QSqlDatabase &database, QObject *parent = 0);

    enum Roles
    {
       IdRole = Qt::UserRole + 1,
       NameRole,
       VornameRole,
       MiddlenameRole,
       Company,
       Passport
    };

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;



protected:
     QHash<int, QByteArray> roleNames() const;
     bool validateInsertUser(QString name, QString company) const;
     bool update(int id, QString name, QString vorname, QString middlename, QString company, QString passport);
     bool insert(QString name, QString vorname, QString middlename, QString company, QString passport);

signals:
    void notValidateInsert();
    void notValidateUpdate();
    void errorInsertingToDb();
    void successInsertingToDb();
    void successUpdateToDb();
    void successDeleteUser();
    void errorDeleteUser();

public slots:
     int getID(int row);
     void updateModel();
     bool insertUser(QString name, QString vorname, QString middlename, QString company, QString passport);
     bool updateUser(int id, QString name, QString vorname, QString middlename, QString company, QString passport);
     bool removeRecord(const int id);
     QVariantMap get(int idx) const;
     QStringList fillComboBox() const;

private:
     QSqlDatabase _db;
};

#endif // USERSMODEL_H
