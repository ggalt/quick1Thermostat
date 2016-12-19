#ifndef FORECASTLISTMODEL_H
#define FORECASTLISTMODEL_H

#include <QAbstractListModel>
#include <QList>
#include <QVariant>
#include "weatherdata.h"


class forecastListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    forecastListModel(QObject *parent=0);

public:
    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;

    WeatherData* at(int row);
    int addForecastData(WeatherData *d);
    bool clearList(void);

private:
    QList<WeatherData*> m_forecast;

};

#endif // FORECASTLISTMODEL_H
