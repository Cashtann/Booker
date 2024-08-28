#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "OffersController.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    OffersController* m_offersController = new OffersController(&app);
    qmlRegisterSingletonInstance("app.OffersController", 1, 0, "OffersController", m_offersController);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/Booker/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
