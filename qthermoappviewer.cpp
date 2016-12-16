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
}

void qThermoAppViewer::Init(void)
{
//    mainRec = this->rootObject();
//    QObject *rect = mainRec->findChild<QObject*>("mainRectangle");
//    qDebug() << "Found rect:" << (rect != NULL);
//    if(rect)
//        qDebug() << "temp" << rect->property("curTemp");

//    QTimer t;
//    t.singleShot(1000,Qt::PreciseTimer,this, SLOT(CheckTemp()));
//    mainRec = findChild<QObject*>("mainRectangle");
//    qDebug() << "Object found:" << (mainRec == NULL);

//    qDebug() << "this has child count of:" <<this->children().count();
//    mainRec = this->rootObject()->findChild<QRect*>("mainRectangle");
//    qDebug() << "Found main Rec:" << (mainRec != NULL);
//    QListIterator<QObject*> i(this->children());
//    const QMetaObject *meta = mainRec->metaObject();

//    QHash<QString, QVariant> list;
//    for (int i = 0; i < meta->propertyCount(); i++)
//    {
//        QMetaProperty property = meta->property(i);
//        const char* name = property.name();
//        QVariant value = mainRec->property(name);
//        list[name] = value;
//    }

//    QString out;
//    QHashIterator<QString, QVariant> i(list);
//    while (i.hasNext()) {
//        i.next();
//        out.append(i.key());
//        out.append(": ");
//        out.append(i.value().toString());
//        if (!out.isEmpty())
//        {
//            qDebug() << out;
//            out.clear();
//        }
//    }

//    qDebug() << "dynamic props:" << mainRec->dynamicPropertyNames();
//    FindItemByName(this->children(), "mainRectangle");
    // not found
//    connect(this,SIGNAL(showEventWindow()),this,SLOT(LaunchEventListWin()));
//    connect(this,SIGNAL(showWeatherWindow()),this,SLOT(LaunchWeatherWin()));
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
    mainRec = this->rootObject();
    QObject *rect = mainRec->findChild<QObject*>("mainRectangle");
    qDebug() << "Found rect:" << (rect != NULL);
    if(rect)
        qDebug() << "temp" << rect->property("curTemp");
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
