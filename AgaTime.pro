QT += quick
CONFIG += c++11
QT += sql

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += main.cpp \
    api/sqliteapi.cpp \
    api/api.cpp

RESOURCES += qml.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    api/sqliteapi.h \
    api/api.h
