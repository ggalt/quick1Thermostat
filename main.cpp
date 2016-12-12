#include "qthermoappviewer.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qThermoAppViewer viewer;
    viewer.addImportPath(QLatin1String("modules"));
    viewer.setOrientation(QtQuick1ApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qrc:/main.qml"));
//    viewer.Init();
    QObject *obj = (QObject*)viewer.rootObject();

    QObject::connect(obj, SIGNAL(showEventWindow()), &viewer, SLOT(LaunchEventListWin()));
    viewer.showExpanded();

    return app.exec();
}
