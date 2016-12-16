#ifndef QTHERMOAPPVIEWER_H
#define QTHERMOAPPVIEWER_H

#include "qtquick1applicationviewer.h"
#include <QDeclarativeItem>
#include <QList>

///
/// \brief The qThermoAppViewer class
///
/// Subclass the Application viewer so we can grab signals from
/// QML and respond to them
///

class qThermoAppViewer : public QtQuick1ApplicationViewer
{
    Q_OBJECT
public:
    explicit qThermoAppViewer(QtQuick1ApplicationViewer *parent = 0);
    void Init(void);

signals:

public slots:
    void LaunchEventListWin(void);
    void LaunchWeatherWin(void);
    void CheckTemp(void);

private:
    QObject *mainRec;
    static QDeclarativeItem* FindItemByName(QList<QObject*> nodes, const QString& name);
};

#endif // QTHERMOAPPVIEWER_H
