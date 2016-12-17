#include "weathernetworkconnection.h"

#include <QDebug>


#define REFRESH_RATE 10*60*1000     // refresh weather every 10 minutes
#define BETHESDA "4348599"
#define ZERO_KELVIN 273.15


WeatherNetworkConnection::WeatherNetworkConnection(QObject *parent) :
    QObject(parent)
{
    m_forecastURL = QUrl("http://api.openweathermap.org/data/2.5/forecast");
    m_weatherURL = QUrl("http://api.openweathermap.org/data/2.5/weather");
    m_apiKey = "f3f0986ce37ed779a9eab754fa0e1d86";

    tick.setInterval(REFRESH_RATE);

    setCity(BETHESDA);
    constructURLs();

    m_netManager = new QNetworkAccessManager(this);
    connect(m_netManager,SIGNAL(finished(QNetworkReply*)),
            this,SLOT(processWeather(QNetworkReply*)));

    qState = WeatherNetworkConnection::Weather;
    tempPref = WeatherNetworkConnection::Fahrenheit;

    refreshWeather();


    connect(this,SIGNAL(cityChanged()),
            this,SLOT(constructURLs()));

    connect(&tick,SIGNAL(timeout()),
            this,SLOT(refreshWeather()));

    tick.start();
}

void WeatherNetworkConnection::constructURLs(void)
{
    QUrlQuery openWeatherQuery;
    openWeatherQuery.addQueryItem("id",m_city);
    openWeatherQuery.addQueryItem("appid",m_apiKey);
    openWeatherQuery.addQueryItem("mode","json");

    m_forecastURL.setQuery(openWeatherQuery);
    m_weatherURL.setQuery(openWeatherQuery);
    qDebug() << "forecast URL" << m_forecastURL.toString();
    qDebug() << "weather URL" << m_weatherURL.toString();
}

void WeatherNetworkConnection::setCity(const QString &value)
{
    m_city = value;
    emit cityChanged();
}

WeatherData *WeatherNetworkConnection::weather()
{
    return &m_now;
}

QDeclarativeListProperty<WeatherData> WeatherNetworkConnection::forecast() const
{
    return *fcProp;
}

void WeatherNetworkConnection::refreshWeather(void)
{
    if(qState == WeatherNetworkConnection::Weather)
        m_netManager->get(QNetworkRequest(m_weatherURL));
    else
        m_netManager->get(QNetworkRequest(m_forecastURL));
}

void WeatherNetworkConnection::processWeather(QNetworkReply *networkReply)
{

    if (!networkReply->error()) {
        QJsonDocument document = QJsonDocument::fromJson(networkReply->readAll());

        if (document.isObject()) {
            QJsonObject obj = document.object();

            if(qState == WeatherNetworkConnection::Weather) {
                JsonProcessWeatherObject(m_now, obj);
                JsonProcessMainInfoObject(m_now, obj);
                JsonProcessSysInfoObject(m_now, obj);

                qState = WeatherNetworkConnection::Forecast;    // set next state
                refreshWeather();
                return;
            }   // end state weather

            if( qState == WeatherNetworkConnection::Forecast ) {
                m_forecast.clear();

                if (obj.contains(QStringLiteral("list"))) {
                    QJsonValue val = obj.value(QStringLiteral("list"));
                    QJsonArray listArray = val.toArray();
                    foreach(const QJsonValue &value, listArray) {
                        QJsonObject tempObj = value.toObject();
                        WeatherData *data = new WeatherData();
                        JsonProcessWeatherObject(*data, tempObj);
                        JsonProcessMainInfoObject(*data,tempObj);
                        JsonProcessDateTextObject(*data,tempObj);
                        m_forecast.append(data);
                    }   // end for loop
                }   // end list
                qState = WeatherNetworkConnection::Weather;
            }   // end state forecast
        }   // end if document
    }   // end if network
    qDebug() << m_now.temperature();
    qDebug() << m_forecast.at(0)->temperature();
}

void WeatherNetworkConnection::JsonProcessWeatherObject( WeatherData &data, QJsonObject &obj )
{
    if (obj.contains(QStringLiteral("weather"))) {
        QJsonValue val = obj.value(QStringLiteral("weather"));
        QJsonArray weatherArray = val.toArray();
        QJsonObject tempObject = weatherArray.at(0).toObject();

        data.setWeatherDescription(tempObject.value(QStringLiteral("description")).toString());
        data.setWeatherIcon(tempObject.value(QStringLiteral("icon")).toString());
    }
}

void WeatherNetworkConnection::JsonProcessMainInfoObject(WeatherData &data, QJsonObject &obj)
{
    if( obj.contains(QStringLiteral("main"))) {
        double t;
        QJsonValue val = obj.value(QStringLiteral("main"));
        QJsonObject mainObj = val.toObject();
        t = mainObj.value(QStringLiteral("temp")).toDouble();
        data.setTemperature(niceTemperatureString(t));
        data.setHumidity(mainObj.value(QStringLiteral("humidity")).toString());
        t = mainObj.value(QStringLiteral("temp_max")).toDouble();
        data.setTempMax(niceTemperatureString(t));
        t = mainObj.value(QStringLiteral("temp_min")).toDouble();
        data.setTempMin(niceTemperatureString(t));
    }   // end temp, humidity, etc.
}

void WeatherNetworkConnection::JsonProcessSysInfoObject(WeatherData &data, QJsonObject &obj)
{
    if( obj.contains(QStringLiteral("sys"))) {
        QJsonValue val = obj.value(QStringLiteral("sys"));
        QJsonObject sysObj = val.toObject();
        data.setSunRise(sysObj.value(QStringLiteral("sunrise")).toString());
        data.setSunSet(sysObj.value(QStringLiteral("sunset")).toString());
    }   // end sunrise and sunset
}

void WeatherNetworkConnection::JsonProcessDateTextObject(WeatherData &data, QJsonObject &obj)
{
    if( obj.contains(QStringLiteral("dt_txt"))) {
        data.setDayOfWeek(obj.value(QStringLiteral("dt_txt")).toString());
    }
}


QString WeatherNetworkConnection::niceTemperatureString(double t)
{
    int temp;

    if(tempPref == WeatherNetworkConnection::Fahrenheit)
        temp = (qRound(t-ZERO_KELVIN)*9/5)+32;
    else
        temp = qRound(t-ZERO_KELVIN);

    return QString::number(temp) + QChar(0xB0);
}
