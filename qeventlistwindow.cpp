#include "qeventlistwindow.h"
#include <QUrl>

qEventListWindow::qEventListWindow(QDeclarativeView *parent) :
    QDeclarativeView(parent)
{
}

void qEventListWindow::Init(void)
{
    setSource(QUrl("qrc:/eventListWin.qml"));
    connect(this, SIGNAL(goBack()),
            this, SLOT(close()));
    show();
}
