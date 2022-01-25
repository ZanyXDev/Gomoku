#include <QtCore/QCoreApplication>
#include <QtCore/QDir>
#include <QtCore/QLocale>
#include <QtCore/QStandardPaths>
#include <QtCore/QString>
#include <QtCore/QTranslator>
#include <QtGui/QFontDatabase>
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QtQuickControls2/QQuickStyle>
#include <QScreen>

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras/QtAndroid>
#include <QtAndroidExtras/QAndroidJniObject>
#endif

#include "backend.h"
#include "tilemodel.h"

void createAppConfigFolder()
{
    QDir dirConfig(
                QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation));
    qDebug() << "dirConfig.path()" << dirConfig.path();
    if (dirConfig.exists() == false) {
        dirConfig.mkpath(dirConfig.path());
    }
}

int main(int argc, char *argv[]) {
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QCoreApplication::setOrganizationName("ZanyXDev");
    QCoreApplication::setApplicationName("Gomoku");
    QCoreApplication::setApplicationVersion(
                QString("%1-%2[%3]").arg(VERSION).arg(GIT_HASH).arg(GIT_BRANCH));

    ///TODO set default app font
    // QFontDatabase::addApplicationFont("qrc:/font/HoboStd.otf");

    QGuiApplication app(argc, argv);
    /*!
     * \brief Make docs encourage readers to query locale right
     * \sa https://codereview.qt-project.org/c/qt/qtdoc/+/297560
     */
    // create folder AppConfigLocation
    createAppConfigFolder();

    QTranslator myappTranslator;
    myappTranslator.load(QLocale(), QLatin1String("gomoku"), QLatin1String("_"),
                         QLatin1String(":/i18n"));
    app.installTranslator(&myappTranslator);
    //TODO it is
    QQuickStyle::setStyle(QStringLiteral("UniverSal"));

#ifdef Q_OS_ANDROID
    ///TODO replace +android folder
    const QUrl url(QStringLiteral("qrc:/res/qml/main_mobile.qml"));
    QtAndroid::hideSplashScreen();
#else
    const QUrl url(QStringLiteral("qrc:/res/qml/test_wnd.qml"));
#endif

    TileModel tileModel;
    BackEnd backend;

#ifdef QT_DEBUG
    for (int i = 0; i < 225; i++) {
        if (i == 7) {
            tileModel.append({false, true, true});
        }
        tileModel.append({false, false, false});
    }
    qDebug() << Q_FUNC_INFO
             << tileModel.rowCount(QModelIndex());
#endif

    qmlRegisterType<BackEnd>("io.github.zanyxdev", 1, 0, "BackEnd");

    // qmlRegisterType<Tile>("gameCore", 1, 0, "Tile");

#ifdef Q_OS_ANDROID
    //  BUG with dpi on some androids: https://bugreports.qt-project.org/browse/QTBUG-35701
    int density = QtAndroid::androidActivity().callMethod<jint>("getScreenDpi");
#else
    QScreen *screen = qApp->primaryScreen();
    float density = screen->physicalDotsPerInch();
    qDebug() << "density:" <<density;
#endif
    double scale = density >= 640 ? 4 :
                                    density >= 480 ? 3 :
                                                     density >= 320 ? 2 :
                                                                      density >= 240 ? 1.5 : 1;

    QQmlApplicationEngine engine;

    QQmlContext *context = engine.rootContext();
    context->setContextProperty("tileModel", &tileModel);
    context->setContextProperty("isMobile", false);
    context->setContextProperty("mm",density / 25.4);
    context->setContextProperty("pt", 1);
    context->setContextProperty("dp", scale);

    QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated, &app,
                [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) QCoreApplication::exit(-1);
    },
    Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
