#include "qthermoappviewer.h"
#include "qeventlistwindow.h"
#include <QDebug>

qThermoAppViewer::qThermoAppViewer(QtQuick1ApplicationViewer *parent) :
    QtQuick1ApplicationViewer(parent)
{
}

void qThermoAppViewer::Init(void)
{
    connect(this,SIGNAL(showEventWindow()),this,SLOT(LaunchEventListWin()));
    connect(this,SIGNAL(showWeatherWindow()),this,SLOT(LaunchWeatherWin()));
}


void qThermoAppViewer::LaunchEventListWin(void)
{
    qDebug() << "We're here!";
    qEventListWindow *evWin = new qEventListWindow();
    evWin->Init();
}

void qThermoAppViewer::LaunchWeatherWin(void)
{
    qDebug() << "We're here!";
}
