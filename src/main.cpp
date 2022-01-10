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

#include "backend.h"
#include "tilemodel.h"

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
  QDir dirConfig(
      QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation));
  qDebug() << "dirConfig.path()" << dirConfig.path();
  if (dirConfig.exists() == false) {
    dirConfig.mkpath(dirConfig.path());
  }
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

  const QUrl url(QStringLiteral("qrc:/res/qml/main.qml"));

  TileModel tileModel;
  BackEnd backend;

#ifdef QT_DEBUG

  for (int i = 0; i < 225; i++) {
    if (i == 7) {
      tileModel.append({false, true, true});
    }
    tileModel.append({false, false, false});
  }
  qDebug() << tileModel.rowCount(QModelIndex());
#endif
  
  // https://doc.qt.io/qt-5/scalability.html#calculating-scaling-ratio
  qreal refDpi = 216.;
  qreal refHeight = 1776.;
  qreal refWidth = 1080.;
  QRect rect = QGuiApplication::primaryScreen()->geometry();
  qreal height = qMax(rect.width(), rect.height());
  qreal width = qMin(rect.width(), rect.height());
  qreal dpi = QGuiApplication::primaryScreen()->logicalDotsPerInch();
  
  auto scalingRatio = qMin(
        height / refHeight,
        width / refWidth
  );
  
  auto fontSizeRatio = qMin(
        height * refDpi / (dpi * refHeight),
        width * refDpi / (dpi * refWidth)
  );   
  
  qmlRegisterType<BackEnd>("io.github.zanyxdev", 1, 0, "BackEnd");

  // qmlRegisterType<Tile>("gameCore", 1, 0, "Tile");
  QQmlApplicationEngine engine;

  QQmlContext *context = engine.rootContext();
  context->setContextProperty("tileModel", &tileModel);
  
  engine.rootContext()->setContextProperty("scalingRatio", QVariant(scalingRatio));
  engine.rootContext()->setContextProperty("fontSizeRatio", QVariant(fontSizeRatio));
  
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &app,
      [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);
  engine.load(url);

  return app.exec();
}
