QT += quick

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        src/appcore.cpp \
        main.cpp \
        src/loader/abstractnotamsloader.cpp \
        src/loader/notamscliloader.cpp \
        src/loader/notamshttploader.cpp \
        src/notamsmodel.cpp \
        src/proxynotamsmodel.cpp \
        src/recentmodel.cpp

RESOURCES += qml.qrc \
    icons.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

CONFIG(release, debug|release): DEFINES += RELEASE

HEADERS += \
    src/appcore.h \
    src/loader/abstractnotamsloader.h \
    src/loader/notamscliloader.h \
    src/loader/notamshttploader.h \
    src/notamsmodel.h \
    src/proxynotamsmodel.h \
    src/recentmodel.h
