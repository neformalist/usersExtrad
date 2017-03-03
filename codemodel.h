#ifndef CODEMODEL_H
#define CODEMODEL_H
#include <QSqlQueryModel>

#define CODETABLE "Editions"

class CodeModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    CodeModel(const QSqlDatabase &database, QObject * parent = 0);

    enum Roles
    {
       CodeRole = Qt::UserRole + 1,
       FirstZaglRole,
       LNameRole,
       FNameRole
    };


    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
public slots:
    void setQuery(const QString &query);
    Q_INVOKABLE QVariantMap get(int row = 0) const;
protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QSqlDatabase _db;

};

#endif // CODEMODEL_H
