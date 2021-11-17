#include <QtCore/QString>
#include <QtCore/QLocale>
#include <QtCore/QTranslator>
#include <QtCore/QCoreApplication>
#include <QtCore/QDir>
#include <QtCore/QString>
#include <QtCore/QStandardPaths>

#include <QtGui/QGuiApplication>

#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QtQuickControls2/QQuickStyle>

#include "tilemodel.h"
#include "backend.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QCoreApplication::setOrganizationName("ZanyXDev Inc.");
    QCoreApplication::setApplicationName("Gomoku");
    QCoreApplication::setApplicationVersion(QString("%1-%2[%3]")
                                            .arg(VERSION)
                                            .arg(GIT_HASH)
                                            .arg(GIT_BRANCH) );

    QGuiApplication app(argc, argv);

    // create folder AppConfigLocation
    QDir dirConfig(QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation));
    qDebug() << "dirConfig.path()" <<dirConfig.path();
    if (dirConfig.exists()==false) {
        dirConfig.mkpath(dirConfig.path());
    }
    /*!
     * \brief Make docs encourage readers to query locale right
     * \sa https://codereview.qt-project.org/c/qt/qtdoc/+/297560
     */
    QTranslator myappTranslator;
    myappTranslator.load(QLocale(), QLatin1String("gomoku"), QLatin1String("_"), QLatin1String(":/i18n"));
    app.installTranslator(&myappTranslator);

    QQuickStyle::setStyle(QStringLiteral("Universal"));
#ifdef QT_DEBUG
    const QUrl url(QStringLiteral("qrc:/res/qml/TestWindow.qml"));
#else
    const QUrl url(QStringLiteral("qrc:/res/qml/main.qml"));
#endif
    TileModel tileModel;
    BackEnd backend;

#ifdef QT_DEBUG

    for (int i=0;i <225;i++){
        if (i == 7){
            tileModel.append({false,true,true});
        }
        tileModel.append({false,false,false});
    }
    qDebug() << tileModel.rowCount(QModelIndex());
#endif

    qmlRegisterType<BackEnd>("io.github.zanyxdev", 1, 0, "BackEnd");

    //qmlRegisterType<Tile>("gameCore", 1, 0, "Tile");
    QQmlApplicationEngine engine;

    QQmlContext* context = engine.rootContext();
    context->setContextProperty("tileModel", &tileModel);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
