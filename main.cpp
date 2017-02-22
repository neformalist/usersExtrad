#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QObject>
#include <QDebug>
#include "DBCore.h"
#include "settingdb.h"
#include "usersmodel.h"

int main(int argc, char *argv[])
{
    QObject mainApp;

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    DBCore db((new settingDB(&mainApp))->getDbSetting());

    UsersModel * usermodel = new UsersModel(db.getDataBase("USERS"));

    engine.rootContext()->setContextProperty("usersModel", usermodel);

    return app.exec();
}
