#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "src/appcore.h"
#include "src/loader/notamscliloader.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;


    AppCore *core = new AppCore(new NotamsCLILoader());
    engine.rootContext()->setContextProperty("core", core);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&app, &QCoreApplication::aboutToQuit, [=] {
      core->deleteLater();
    });

    engine.load(url);

    return app.exec();
}
