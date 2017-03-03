#ifndef CODEMODEL1_H
#define CODEMODEL1_H
#include <QSqlQuery>
#include <QVariantMap>

#define CODETABLE "Editions"

class CodeModel1 : public QObject
{
    Q_OBJECT
public:
    CodeModel1(const QSqlDatabase &database, QObject * parent = 0);


public slots:
    Q_INVOKABLE bool find(const QString &ask);
    Q_INVOKABLE QVariantMap get() const;
private:
    void clear();
    QSqlDatabase _db;
    QVariantMap data;
};

#endif // CODEMODEL1_H
