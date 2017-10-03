TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    bridge.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =


HEADERS += \
    bridge.h

TARGET = eta-history


target.path = /usr/bin/

icon.files = history.svg
icon.commands = mkdir -p /usr/share/eta/eta-history/icon
icon.path = /usr/share/eta/eta-history/icon/

desktop_file.files = eta-history.desktop
desktop_file.path = /usr/share/applications/

INSTALLS += target icon desktop_file


