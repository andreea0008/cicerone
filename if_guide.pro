QT += quick xml
CONFIG += c++11 felgo

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    main.cpp \
    src/company.cpp \
    src/settings.cpp \
    src/xml.cpp \
    src/category.cpp \
    src/clipboard.cpp

RESOURCES += qml.qrc \
    xml_files.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
#qnx: target.path = /tmp/$${TARGET}/bin
#else: unix:!android: target.path = /opt/$${TARGET}/bin
#!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/category.h \
    src/settings.h \
    src/xml.h \
    src/company.h \
    src/saver.h \
    src/clipboard.h

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}

# set application icons for win and macx
win32 {
    #RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/res/drawable-hdpi/ic_launcher.png \
    android/res/drawable-mdpi/ic_launcher.png \
    android/res/drawable-xhdpi/ic_launcher.png \
    android/res/drawable-xxhdpi/ic_launcher.png \
    android/res/values/strings.xml \
    android/res/xml/file_paths.xml \
    assets/felgo-logo.png \
    ios/Assets.xcassets/AppIcon.appiconset/Contents.json \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x-1.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x-1.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x-1.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png \
    ios/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png \
    ios/Assets.xcassets/AppIcon.appiconset/ItunesArtwork@2x.png \
    ios/Assets.xcassets/Contents.json \
    ios/Assets.xcassets/LaunchImage.launchimage/Contents.json \
    ios/Assets.xcassets/LaunchImage.launchimage/Default1125x2436.png \
    ios/Assets.xcassets/LaunchImage.launchimage/Default1242x2208.png \
    ios/Assets.xcassets/LaunchImage.launchimage/Default1536x2048.png \
    ios/Assets.xcassets/LaunchImage.launchimage/Default2048x1536.png \
    ios/Assets.xcassets/LaunchImage.launchimage/Default2208x1242.png \
    ios/Assets.xcassets/LaunchImage.launchimage/Default2436x1125.png \
    ios/Assets.xcassets/LaunchImage.launchimage/Default640x1136.png \
    ios/Assets.xcassets/LaunchImage.launchimage/Default640x960.png \
    ios/Assets.xcassets/LaunchImage.launchimage/Default750x1334.png \
    ios/Assets.xcassets/LaunchImage.launchimage/Default768x1024.png \
    ios/Project-Info.plist \
    macx/app_icon.icns \
    qml/config.json \

