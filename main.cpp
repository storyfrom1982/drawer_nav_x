// ekke (Ekkehard Gentz) @ekkescorner
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QTranslator>
#include <QQmlContext>

#include <src/camerafilter.h>
#include <src/videorenderer.h>

#include "applicationui.hpp"

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    qputenv("QT_QUICK_CONTROLS_STYLE", "material");
    QGuiApplication app(argc, argv);

    QTranslator translator;
    if (translator.load(QLocale(), QLatin1String("drawer_nav_x"), QLatin1String("_"), QLatin1String(":/translations"))) {
        app.installTranslator(&translator);
    } else {
        qDebug() << "cannot load translator " << QLocale::system().name() << " check content of translations.qrc";
    }

    ApplicationUI appui;
    QQmlApplicationEngine engine;

    CameraFilter::registerQmlType();
    VideoRenderer::registerQmlType();

    // from QML we have access to ApplicationUI as myApp
    QQmlContext* context = engine.rootContext();
    context->setContextProperty("myApp", &appui);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
