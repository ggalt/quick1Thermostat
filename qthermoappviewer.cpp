#include "qthermoappviewer.h"
#include "qeventlistwindow.h"
#include <QDebug>
#include <QVariant>
#include <QMetaObject>
#include <QMetaProperty>
#include <QString>
#include <QHash>
#include <QHashIterator>
#include <QObjectList>
#include <QListIterator>
#include <QGraphicsObject>
#include <QGraphicsItem>
#include <QDeclarativeEngine>
#include <QDeclarativeItem>
#include <QTimer>

//#include <QtQml/QQmlProperty>

qThermoAppViewer::qThermoAppViewer(QtQuick1ApplicationViewer *parent) :
    QtQuick1ApplicationViewer(parent)
{
    initializingApp = true;
}

void qThermoAppViewer::Init(void)
{
    mainRec = this->rootObject();

    connect(&tick, SIGNAL(timeout()),
            this, SLOT(CheckTemp()));

    tick.setInterval(5000);
    tick.start();

    m_weather = new WeatherNetworkConnection(this);
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

void qThermoAppViewer::CheckTemp(void)
{
    mainRec->setProperty("outsideCurrentTemp",m_weather->niceTemperatureString(m_weather->weather()->temperature()));
    mainRec->setProperty("curTemp", m_weather->niceTemperatureString(294.261));
    mainRec->setProperty("targetTemp", m_weather->niceTemperatureString(294.261,false));
    mainRec->setProperty("currentWeatherIcon", m_weather->weather()->weatherIcon());
    mainRec->setProperty("curHumidity", m_weather->weather()->humidity());

    WeatherData *today = m_weather->forecast()->at(0);
    WeatherData *tomorrow = m_weather->getWeatherForDay(1);
    WeatherData *nextDay = m_weather->getWeatherForDay(2);

    mainRec->setProperty("todayHiTemp", m_weather->niceTemperatureString( today->tempMax() ));
    mainRec->setProperty("todayLoTemp", m_weather->niceTemperatureString(today->tempMin()) );
    mainRec->setProperty("tomorrowHiTemp", m_weather->niceTemperatureString(tomorrow->tempMax()) );
    mainRec->setProperty("tomorrowLoTemp", m_weather->niceTemperatureString(tomorrow->tempMin()) );
    mainRec->setProperty("nextDayHiTemp", m_weather->niceTemperatureString(nextDay->tempMax()) );
    mainRec->setProperty("nextDayLoTemp", m_weather->niceTemperatureString(nextDay->tempMin()) );
    mainRec->setProperty("todayName", QDateTime::fromString(today->dayOfWeek(),"yyyy-MM-dd hh:mm:ss").toString("ddd"));
    mainRec->setProperty("tomorrowName", QDateTime::fromString(tomorrow->dayOfWeek(),"yyyy-MM-dd hh:mm:ss").toString("ddd"));
    mainRec->setProperty("nextDayName", QDateTime::fromString(nextDay->dayOfWeek(),"yyyy-MM-dd hh:mm:ss").toString("ddd"));
    mainRec->setProperty("todayIcon", today->weatherIcon());
    mainRec->setProperty("tomorrowIcon", tomorrow->weatherIcon() );
    mainRec->setProperty("nextDayIcon", nextDay->weatherIcon() );


    if(initializingApp) {
        mainRec->setProperty("state", "MainWindowState");
        initializingApp = false;
    }
}

QDeclarativeItem* qThermoAppViewer::FindItemByName(QList<QObject*> nodes, const QString& name)
{

    for(int i = 0; i < nodes.size(); i++){
        // search for node
        if (nodes.at(i) && nodes.at(i)->objectName() == name){
            qDebug() << "found it at:"  << i << nodes.at(i)->objectName();
            return dynamic_cast<QDeclarativeItem*>(nodes.at(i));
        }
        // search in children
        else if (nodes.at(i) && nodes.at(i)->children().size() > 0){
            QDeclarativeItem* item = FindItemByName(nodes.at(i)->children(), name);
            if (item)
                qDebug() << "found it at:"  << i << nodes.at(i)->objectName();
                return item;
        }
        qDebug() << i;
    }
    // not found
    return NULL;
}
