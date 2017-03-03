#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include <QFont>
#include <QObject>
#include <QDebug>
#include "DBCore.h"
#include "settingdb.h"
#include "usersmodel.h"
#include "codemodel.h"
#include "codemodel1.h"
#include "mainsqlquery.h"

int main(int argc, char *argv[])
{
    QObject mainApp;

    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/icons/logo.png"));

    app.setFont(QFont("Arial"));

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    DBCore db((new settingDB(&mainApp))->getDbSetting());

    UsersModel * usermodel = new UsersModel(db.getDataBase("USERS"));

    //CodeModel * codemodel = new CodeModel(db.getDataBase("MUZLIB"));

    CodeModel1 * codemodel = new CodeModel1(db.getDataBase("MUZLIB"));

    MainSqlQuery * mainModel = new MainSqlQuery(db.getDataBase("USERS"));

    engine.rootContext()->setContextProperty("mainModel", mainModel);

    engine.rootContext()->setContextProperty("codemodel", codemodel);

    engine.rootContext()->setContextProperty("usersModel", usermodel);

    return app.exec();
}
