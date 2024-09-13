#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "OffersController.h"
#include "Manager.h"
#include "CartController.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    CartController* m_cartController = new CartController(&app);
    qmlRegisterSingletonInstance("app.CartController", 1, 0, "CartController", m_cartController);
    OffersController* m_offersController = new OffersController(&app);
    qmlRegisterSingletonInstance("app.OffersController", 1, 0, "OffersController", m_offersController);
    Manager* m_manager = new Manager(&app);
    qmlRegisterSingletonInstance("app.Manager", 1, 0, "Manager", m_manager);

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
