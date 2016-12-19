#include "forecastlistmodel.h"

forecastListModel::forecastListModel(QObject *parent) :
    QAbstractListModel(parent)
{

}

int forecastListModel::rowCount(const QModelIndex &parent) const
{
    return m_forecast.count();
}

QVariant forecastListModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid())
        return QVariant();

    if( index.row() >= m_forecast.count() || index.row() < 0 )
        return QVariant();

    if( role == Qt::DisplayRole ) {
        return QVariant::fromValue(m_forecast.at(index.row()));
    } else
        return QVariant();
}

int forecastListModel::addForecastData(WeatherData *d)
{
    // we only allow appending data
    beginInsertRows( QModelIndex(), rowCount(QModelIndex()), rowCount(QModelIndex()));
    m_forecast.append(d);
    endInsertRows();
}

WeatherData *forecastListModel::at(int row)
{
    if( row < m_forecast.count() )
        return m_forecast.at(row);
    else
        return new WeatherData();
}

bool forecastListModel::clearList(void)
{
    beginResetModel();
    m_forecast.clear();
    endResetModel();
}
