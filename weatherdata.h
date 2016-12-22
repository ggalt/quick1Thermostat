#ifndef WEATHERDATA_H
#define WEATHERDATA_H

#include <QObject>
#include <QString>

class WeatherData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString dayOfWeek
               READ dayOfWeek WRITE setDayOfWeek
               NOTIFY dataChanged)
    Q_PROPERTY(QString weatherIcon
               READ weatherIcon WRITE setWeatherIcon
               NOTIFY dataChanged)
    Q_PROPERTY(QString weatherDescription
               READ weatherDescription WRITE setWeatherDescription
               NOTIFY dataChanged)
    Q_PROPERTY(qreal temperature
               READ temperature WRITE setTemperature
               NOTIFY dataChanged)
    Q_PROPERTY(qreal tempMax
               READ tempMax WRITE setTempMax
               NOTIFY dataChanged)
    Q_PROPERTY(qreal tempMin
               READ tempMin WRITE setTempMin
               NOTIFY dataChanged)
    Q_PROPERTY(QString windSpeed
               READ windSpeed WRITE setWindSpeed
               NOTIFY dataChanged)
    Q_PROPERTY(QString windDirection
               READ windDirection WRITE setWindDirection
               NOTIFY dataChanged)
    Q_PROPERTY(QString visibility
               READ visibility WRITE setVisibility
               NOTIFY dataChanged)
    Q_PROPERTY(QString humidity
               READ humidity WRITE setHumidity
               NOTIFY dataChanged)
    Q_PROPERTY(QString sunRise
               READ sunRise WRITE setSunRise
               NOTIFY dataChanged)
    Q_PROPERTY(QString sunSet
               READ sunSet WRITE setSunSet
               NOTIFY dataChanged)

public:
    explicit WeatherData(QObject *parent = 0);
    WeatherData(const WeatherData &other);

    QString dayOfWeek() const { return m_dayOfWeek;}
    QString weatherIcon() const { return m_weather;}
    QString weatherDescription() const {return m_weatherDescription; }
    qreal temperature() const { return m_temperature;}
    qreal tempMax() const { return m_tempMax;}
    qreal tempMin() const { return m_tempMin;}
    QString windSpeed() const { return m_windSpeed;}
    QString windDirection() const { return m_windDirection;}
    QString visibility() const { return m_visibility;}
    QString humidity() const { return m_humidity;}
    QString sunRise() const { return m_sunRise;}
    QString sunSet() const { return m_sunSet;}

    void setDayOfWeek(const QString &value);
    void setWeatherIcon(const QString &value);
    void setWeatherDescription(const QString &value);
    void setTemperature(const qreal &value);
    void setTempMax(const qreal &value);
    void setTempMin(const qreal &value);
    void setWindSpeed(const QString &value);
    void setWindDirection(const QString &value);
    void setVisibility(const QString &value);
    void setHumidity(const QString &value);
    void setSunRise(const QString &value);
    void setSunSet(const QString &value);

signals:
    void dataChanged();

private:
    QString m_dayOfWeek;
    QString m_weather;
    QString m_weatherDescription;
    qreal m_temperature;
    qreal m_tempMax;
    qreal m_tempMin;
    QString m_windSpeed;
    QString m_windDirection;
    QString m_visibility;
    QString m_humidity;
    QString m_sunRise;
    QString m_sunSet;
};

Q_DECLARE_METATYPE(WeatherData)



#endif // WEATHERDATA_H
