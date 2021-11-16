!versionAtLeast(QT_VERSION, 5.10.0):error("Requires Qt version 5.10.0 or greater.")

TEMPLATE +=app
QT       += core gui concurrent qml quick quickcontrols2

VERSION = 0.3

# allows use of version variable elsewhere
DEFINES += "VERSION=$$VERSION"

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

LANGUAGE  = C++

CONFIG += c++17 resources_big cmdline qml_debug

include(gitversion.pri)

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += $$PWD

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

#don't use precompiled headers https://www.kdab.com/beware-of-qt-module-wide-includes/

SOURCES += \
    src/main.cpp \
    src/tilemodel.cpp

HEADERS += \
    src/tilemodel.h

RESOURCES += \
     qml.qrc \
     images.qrc
#    resources.qrc \

#TRANSLATIONS += \
#    i18n/five_in_a_row_ru_RU.ts

# Setting the application icon
#win32: RC_ICONS = res/icons/five_in_a_row-qt.ico # On Windows
#macx: ICON = res/icons/five_in_a_row-qt.ico # On Mac OSX

#android {
#    QT += androidextras

#    disable-xcb {
#        message("The disable-xcb option has been deprecated. Please use disable-desktop instead.")
#        CONFIG += disable-desktop
#    }

#    CONFIG(release, debug|release) {
#        CONFIG += qtquickcompiler
#    }

#    OTHER_FILES += \
#        android/AndroidManifest.xml \
#        android/build.gradle \
#        android/gradle.properties \
#        android/gradlew \
#        android/gradlew.bat \
#        android/gradle/wrapper/gradle-wrapper.jar \
#        android/gradle/wrapper/gradle-wrapper.properties \
#        android/res/values/libs.xml

#ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android/source

#contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
 #       ANDROID_EXTRA_LIBS = \
 #          $$PWD/android/3rdparty/openssl/armeabi-v7a/libcrypto_1_1.so \
 #         $$PWD/android/3rdparty/openssl/armeabi-v7a/libssl_1_1.so
# }
#contains(ANDROID_TARGET_ARCH,arm64-v8a) {
        #ANDROID_EXTRA_LIBS = \
        #    $$PWD/android/3rdparty/openssl/arm64-v8a/libcrypto_1_1.so \
        #    $$PWD/android/3rdparty/openssl/arm64-v8a/libssl_1_1.so
# }
#}


# Default rules for deployment.
