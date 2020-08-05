QT += quick xml location
CONFIG += felgo
CONFIG += C++14
#QMAKE_CXXFLAGS += -std=c++11
# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

 PRODUCT_VERSION_NAME = 1.0.0
 PRODUCT_VERSION_CODE = 1
 PRODUCT_IDENTIFIER = "com.smartgame.cicerone"
 PRODUCT_LICENSE_KEY = "B034D2200CF2E0787AD9D01293D4B481DC90D1F196D78470129F3EB7FCE29384B993C6FC60DB7C6A4D7EC1EA210E7E6823F51D1068D77C39CD2F3B4EC0263E1AA98759EFD55697C79AC55BB19A7B95743B5C792CC968C7B1D64989271E405CF9274297954CF977C8887166D0292C070F4F6FE8C810D74F3B4E256EC64354A6303C62E3C026891B4EAD228A0B125FA97A1CFAB6A80D0E2C8847A1B6A5244394A9AE10D0631755A58FF87E349184DEC7A2AA23F656AC881CAE886DE4EA3EBDA8B75C233EAE5683F9801530EB7B50FCBA3A69D09CBAC0DF4C3EC41518D27ED4FA9AD96D5F4F95FC8A3E5A3FAF2030CCF208FD80BD4B0ECD77CA98C654ED0BEA2E05E109137F508553F9DC99AF791662CB03AFE5021AC68524ECD9BBE960F8703FAAEB96B5DF33D921317B51DE825538D849"


# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    main.cpp \
    src/Event/eventcategory.cpp \
    src/Filters/filtermodel.cpp \
    src/Networker/jsonfileloader.cpp \
    src/Networker/jsonnetworkloader.cpp \
    src/Networker/jsonsaver.cpp \
    src/Networker/networkloader.cpp \
    src/company.cpp \
    src/companylistbycategory.cpp \
    src/favoritecompanylist.cpp \
    src/loaderinterface.cpp \
    src/settings.cpp \
    src/updater.cpp \
    src/xml.cpp \
    src/category.cpp \
    src/clipboard.cpp

RESOURCES += qml.qrc \
    api_data.qrc \
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
    src/Event/eventcategory.h \
    src/Filters/filtermodel.h \
    src/Logger/Errors.h \
    src/Networker/jsonfileloader.h \
    src/Networker/jsonnetworkloader.h \
    src/Networker/jsonsaver.h \
    src/Networker/networkloader.h \
    src/Networker/urls.h \
    src/category.h \
    src/companylistbycategory.h \
    src/favoritecompanylist.h \
    src/loaderinterface.h \
    src/settings.h \
    src/updater.h \
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

