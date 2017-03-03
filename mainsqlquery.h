#ifndef MAINSQLQUERY_H
#define MAINSQLQUERY_H

#include <QObject>
#include <QSqlQuery>
#include <QVariantMap>
#include <QAbstractListModel>

class MainSqlQuery : public QAbstractListModel
{
    Q_OBJECT
    enum Roles {
            CodeRole = Qt::UserRole + 1,
            FirstZaglRole,
            LNameRole,
            FNameRole,
            MInitialRole
        };
public:
    explicit MainSqlQuery(const QSqlDatabase &database, QObject *parent = 0);

    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE void add(const QVariantMap &map);
    Q_INVOKABLE void remove(int item);

signals:
public slots:

private:
    QSqlDatabase _db;
    QVariantMap mainData;
    QList<QVariantMap> editionsItem;
};

#endif // MAINSQLQUERY_H
