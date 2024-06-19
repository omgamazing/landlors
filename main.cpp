#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "cardWeight.h"
#include <iostream>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/landlors/Window.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    CardNode cardNode(TripleWithOne, 3, 4);
    std::cout << cardNode.type << " " << cardNode.count;
    return app.exec();
}
