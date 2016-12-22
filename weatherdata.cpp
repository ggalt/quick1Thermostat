#include "weatherdata.h"

#define ZERO_KELVIN 273.15

WeatherData::WeatherData(QObject *parent) :
        QObject(parent)
{
}

WeatherData::WeatherData(const WeatherData &other) :
        QObject(0),
        m_dayOfWeek(other.m_dayOfWeek),
        m_weather(other.m_weather),
        m_weatherDescription(other.m_weatherDescription),
        m_temperature(other.m_temperature),
        m_tempMax(other.m_tempMax),
        m_tempMin(other.m_tempMin),
        m_windSpeed(other.m_windSpeed),
        m_windDirection(other.m_windDirection),
        m_visibility(other.m_visibility),
        m_humidity(other.m_humidity),
        m_sunRise(other.m_sunRise),
        m_sunSet(other.m_sunSet)
{
}

void WeatherData::setDayOfWeek(const QString &value)
{
    m_dayOfWeek = value;
    emit dataChanged();
}

/*!
 * The icon value is based on OpenWeatherMap.org icon set. For details
 * see
 * https://openweathermap.org/weather-conditions
 * e.g. 01d ->sunny day
 *
 * The icon string will be translated to
 * http://openweathermap.org/img/w/01d.png
 *
 * Icon list
 * Day icon 	Night icon 	Description
 * 01d.png      01n.png 	clear sky
 * 02d.png      02n.png 	few clouds
 * 03d.png      03n.png 	scattered clouds
 * 04d.png      04n.png 	broken clouds
 * 09d.png      09n.png 	shower rain
 * 10d.png      10n.png 	rain
 * 11d.png      11n.png 	thunderstorm
 * 13d.png      13n.png 	snow
 * 50d.png      50n.png 	mist

 */

void WeatherData::setWeatherIcon(const QString &value)
{
    m_weather = value;
    emit dataChanged();
}

void WeatherData::setWeatherDescription(const QString &value)
{
    m_weatherDescription = value;
    emit dataChanged();
}

void WeatherData::setTemperature(const qreal &value)
{
    m_temperature = value;
    emit dataChanged();
}

void WeatherData::setTempMax(const qreal &value)
{
    m_tempMax = value;
    emit dataChanged();
}

void WeatherData::setTempMin(const qreal &value)
{
    m_tempMin = value;
    emit dataChanged();
}

void WeatherData::setWindSpeed(const QString &value)
{
    m_windSpeed = value;
    emit dataChanged();
}

void WeatherData::setWindDirection(const QString &value)
{
    m_windDirection = value;
    emit dataChanged();
}

void WeatherData::setVisibility(const QString &value)
{
    m_visibility = value;
    emit dataChanged();
}

void WeatherData::setHumidity(const QString &value)
{
    m_humidity = value;
    emit dataChanged();
}

void WeatherData::setSunRise(const QString &value)
{
    m_sunRise = value;
    emit dataChanged();
}

void WeatherData::setSunSet(const QString &value)
{
    m_sunSet = value;
    emit dataChanged();
}

