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
#include <QtAndroidExtras/QAndroidJniEnvironment>
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
    QCoreApplication::setOrganizationName("ZanyXDev Inc.");
    QCoreApplication::setApplicationName("Gomoku");
    QCoreApplication::setApplicationVersion(
                QString("%1-%2[%3]").arg(VERSION).arg(GIT_HASH).arg(GIT_BRANCH));

    // QFontDatabase::addApplicationFont("qrc:/font/HoboStd.otf");

    QGuiApplication app(argc, argv);

    // create folder AppConfigLocation
    createAppConfigFolder();
    /*!
   * \brief Make docs encourage readers to query locale right
   * \sa https://codereview.qt-project.org/c/qt/qtdoc/+/297560
   */
    QTranslator myappTranslator;
    myappTranslator.load(QLocale(), QLatin1String("gomoku"), QLatin1String("_"),
                         QLatin1String(":/i18n"));
    app.installTranslator(&myappTranslator);

    /// TODO Global fix usage Material theme and color
    QQuickStyle::setStyle(QStringLiteral("Material"));

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

    int density = 0;
    bool isMobile = false;

#if defined(Q_OS_ANDROID)
    // Reference resolution Google Pixel
    //Pixel 1080 x 1920	-> View port 412 x 732

    const QUrl url(QStringLiteral("qrc:/res/qml/main_mobile.qml"));
    isMobile = true;
    float logicalDensity = 0;
    float yDpi = 0;
    float xDpi = 0;

    QAndroidJniEnvironment env;
    //  BUG with dpi on some androids: https://bugreports.qt-project.org/browse/QTBUG-35701
    QAndroidJniObject qtActivity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
    if (env->ExceptionCheck()) {
        env->ExceptionDescribe();
        env->ExceptionClear();
        return EXIT_FAILURE;
    }
    QAndroidJniObject resources = qtActivity.callObjectMethod("getResources", "()Landroid/content/res/Resources;");
    if (env->ExceptionCheck()) {
        env->ExceptionDescribe();
        env->ExceptionClear();
        return EXIT_FAILURE;
    }
    QAndroidJniObject displayMetrics = resources.callObjectMethod("getDisplayMetrics", "()Landroid/util/DisplayMetrics;");

    if (env->ExceptionCheck()) {
        env->ExceptionDescribe();
        env->ExceptionClear();
        return EXIT_FAILURE;
    }

    density = displayMetrics.getField<int>("densityDpi");
    logicalDensity = displayMetrics.getField<float>("density");
    yDpi = displayMetrics.getField<float>("ydpi");
    xDpi = displayMetrics.getField<float>("xdpi");

    qDebug() << "Native Android Call =>>>"
             << "DensityDPI: " << density << " | "
             << "Logical Density: " << logicalDensity << " | "
             << "yDpi: " << yDpi  << " | "
             << "xDpi: " << xDpi  << " | "
             << "++++++++++++++++++++++++";
#else
    const QUrl url(QStringLiteral("qrc:/res/qml/main_mobile.qml"));
    QScreen *screen = qApp->primaryScreen();
    density = screen->physicalDotsPerInch() * screen->devicePixelRatio();
    qDebug() << "Native destop app =>>>";
    qDebug() << "DensityDPI: " << density << " | "
             << "physicalDPI: " << screen->physicalDotsPerInch() << " | "
             << "devicePixelRatio(): " << screen->devicePixelRatio()  << " | ";
    qDebug() << "++++++++++++++++++++++++";
#endif

    double scale = density >= 640 ? 4 :
                                    density >= 480 ? 3 :
                                                     density >= 320 ? 2 :
                                                                      density >= 240 ? 1.5 : 1;
    qDebug() << "scale[dp]: " << scale;

    QQmlApplicationEngine engine;

    QQmlContext *context = engine.rootContext();
    context->setContextProperty("tileModel", &tileModel);
    context->setContextProperty("mm",density / 25.4);
    context->setContextProperty("pt", 1);
    context->setContextProperty("dp", scale);
    context->setContextProperty("isMobile",isMobile);

    QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated, &app,
                [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) QCoreApplication::exit(-1);
    },
    Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
