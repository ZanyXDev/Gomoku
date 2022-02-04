!versionAtLeast(QT_VERSION, 5.10.0):error("Requires Qt version 5.10.0 or greater.")

TEMPLATE +=app
TARGET = gomuku
QT       += core gui concurrent qml quick quickcontrols2 multimedia purchasing

VERSION = 0.7

# allows use of version variable elsewhere
DEFINES += "VERSION=$$VERSION"

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

LANGUAGE  = C++

CONFIG += c++17 resources_big qml_debug

include(gitversion.pri)

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

DEFINES += QT_DEPRECATED_WARNINGS
# QT_NO_CAST_FROM_ASCII QT_NO_CAST_TO_ASCII

#don't use precompiled headers https://www.kdab.com/beware-of-qt-module-wide-includes/

SOURCES += \
    src/backend.cpp \
    src/main.cpp \
    src/tilemodel.cpp

HEADERS += \
    src/backend.h \
    src/tilemodel.h

RESOURCES += \
     qml.qrc \
     images.qrc \
     fonts.qrc
#    resources.qrc \

#TRANSLATIONS += \
#    G2_ru_RU.ts
#CONFIG += lrelease
#CONFIG += embed_translations

# Setting the application icon
#win32: RC_ICONS = res/icons/five_in_a_row-qt.ico # On Windows
#macx: ICON = res/icons/five_in_a_row-qt.ico # On Mac OSX


QMAKE_CFLAGS += $$(QMAKE_CFLAGS_ENV)
QMAKE_CXXFLAGS += $$(QMAKE_CXXFLAGS_ENV)
QMAKE_LFLAGS += $$(QMAKE_LFLAGS_ENV)

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += $$PWD

android {
    QT += androidextras

    disable-xcb {
        message("The disable-xcb option has been deprecated. Please use disable-desktop instead.")
        CONFIG += disable-desktop
    }

    CONFIG(release, debug|release) {
        CONFIG += qtquickcompiler
    }
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android/source
    DISTFILES += \
            android/source/AndroidManifest.xml \
            android/source/build.gradle \
            android/source/gradle.properties \
            android/source/gradlew \
            android/source/gradlew.bat \
            android/source/gradle/wrapper/gradle-wrapper.jar \
            android/source/gradle/wrapper/gradle-wrapper.properties \
            android/source/res/drawable-hdpi/ic_launcher_background.png \
            android/source/res/drawable-hdpi/ic_launcher_foreground.png \
            android/source/res/drawable-hdpi/ic_splash_qt.png \
            android/source/res/drawable-hdpi/ic_splash_theme.png \
            android/source/res/drawable-mdpi/ic_launcher_background.png \
            android/source/res/drawable-mdpi/ic_launcher_foreground.png \
            android/source/res/drawable-mdpi/ic_splash_qt.png \
            android/source/res/drawable-mdpi/ic_splash_theme.png \
            android/source/res/drawable-xhdpi/ic_launcher_background.png \
            android/source/res/drawable-xhdpi/ic_launcher_foreground.png \
            android/source/res/drawable-xhdpi/ic_splash_qt.png \
            android/source/res/drawable-xhdpi/ic_splash_theme.png \
            android/source/res/drawable-xxhdpi/ic_launcher_background.png \
            android/source/res/drawable-xxhdpi/ic_launcher_foreground.png \
            android/source/res/drawable-xxhdpi/ic_splash_qt.png \
            android/source/res/drawable-xxhdpi/ic_splash_theme.png \
            android/source/res/drawable-xxxhdpi/ic_launcher_background.png \
            android/source/res/drawable-xxxhdpi/ic_launcher_foreground.png \
            android/source/res/drawable-xxxhdpi/ic_splash_qt.png \
            android/source/res/drawable-xxxhdpi/ic_splash_theme.png \
            android/source/res/drawable/splash_qt.xml \
            android/source/res/drawable/splash_theme.xml \
            android/source/res/mipmap-anydpi-v26/ic_launcher.xml \
            android/source/res/mipmap-hdpi/ic_launcher.png \
            android/source/res/mipmap-mdpi/ic_launcher.png \
            android/source/res/mipmap-xhdpi/ic_launcher.png \
            android/source/res/mipmap-xxhdpi/ic_launcher.png \
            android/source/res/mipmap-xxxhdpi/ic_launcher.png \
            android/source/res/values-ru/strings.xml \
            android/source/res/values/colors.xml \
            android/source/res/values/libs.xml \
            android/source/res/values/strings.xml \
            android/source/res/values/styles.xml \
            android/source/res/xml/backup_content.xml
            android/source/src/io/github/zanyxdev/mobilephoteditor/MobilePhotoEditorActivity.java
}



