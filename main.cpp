#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "cardNode.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/landlors/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    //测试description
    CardNode node;
    node.setCards({1, 14});
    std::cout << node.description() << std::endl;

    //测试getpower
    float power = node.getPower();
        std::cout << "failded" << std::endl;
        std::cout << "power:" << power << std::endl;

        return app.exec();
}
