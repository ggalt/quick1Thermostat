#include "weathernetworkconnection.h"

#include <QDebug>
#include <QDateTime>
#include <QTimeZone>
#include <QListIterator>

#define REFRESH_RATE 10*60*1000     // refresh weather every 10 minutes
#define BETHESDA "4348599"
#define ZERO_KELVIN 273.15


WeatherNetworkConnection::WeatherNetworkConnection(QObject *parent) :
    QObject(parent)
{
    m_forecastURL = QUrl("http://api.openweathermap.org/data/2.5/forecast");
    m_weatherURL = QUrl("http://api.openweathermap.org/data/2.5/weather");
    m_apiKey = "f3f0986ce37ed779a9eab754fa0e1d86";

    m_forecast = new forecastListModel(this);

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

//QDeclarativeListProperty<WeatherData> WeatherNetworkConnection::forecast() const
//{
//    return *fcProp;
//}

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
                m_forecast->clearList();
//                m_forecast->clear();

                if (obj.contains(QStringLiteral("list"))) {
                    QJsonValue val = obj.value(QStringLiteral("list"));
                    QJsonArray listArray = val.toArray();
                    foreach(const QJsonValue &value, listArray) {
                        QJsonObject tempObj = value.toObject();
                        WeatherData *data = new WeatherData();
                        JsonProcessWeatherObject(*data, tempObj);
                        JsonProcessMainInfoObject(*data,tempObj);
                        JsonProcessDateTextObject(*data,tempObj);
                        m_forecast->addForecastData(data);
//                        m_forecast.append(data);
                    }   // end for loop
                }   // end list
                qState = WeatherNetworkConnection::Weather;
            }   // end state forecast
        }   // end if document
    }   // end if network
//    qDebug() << m_now.temperature();
////    qDebug() << m_forecast.at(0)->temperature();
//    qDebug() << m_forecast->at(0)->temperature();
//    qDebug() << m_now.weatherIcon() << m_now.weatherDescription() << m_now.sunRise() << m_now.sunSet()
//             << m_now.tempMax() << m_now.tempMin();

//    for( int c = 0; c < m_forecast->rowCount(QModelIndex()); c++ ){
//        WeatherData *d = m_forecast->at(c);
//        qDebug() << "day of the week is:" << d->dayOfWeek();
//        QDateTime dt = QDateTime::fromString(d->dayOfWeek(),"yyyy-MM-dd hh:mm:ss");
//        qDebug() << "day of week is:" << dt.toString("ddd") << dt.toString("MMMM")
//                 << dt.toString("d") << "at" << dt.toString("h:mm");
//        qDebug() << "this day is" << dt.daysTo(QDateTime::currentDateTime()) << "from today";
//        qDebug() << "Min:" << d->tempMin() << "Max:" << d->tempMax();

//        qDebug() << getWeatherForDay(2)->dayOfWeek() << getWeatherForDay(2)->tempMax() << getWeatherForDay(2)->tempMin();
    }
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
        data.setSunRise(niceTime(sysObj.value(QStringLiteral("sunrise")).toDouble()*1000));
        data.setSunSet(niceTime(sysObj.value(QStringLiteral("sunset")).toDouble()*1000));
    }   // end sunrise and sunset
}

void WeatherNetworkConnection::JsonProcessDateTextObject(WeatherData &data, QJsonObject &obj)
{
    if( obj.contains(QStringLiteral("dt_txt"))) {
        data.setDayOfWeek(obj.value(QStringLiteral("dt_txt")).toString());
    }
}


WeatherData *WeatherNetworkConnection::getWeatherForDay(int daysFromToday )
{
    // return weather at noon "daysFromToday" in the future
    quint64 targetDay = 0 - daysFromToday;
    for( int c = 0; c < m_forecast->rowCount(QModelIndex()); c++ ) {
        WeatherData *d = m_forecast->at(c);
        QDateTime dt = QDateTime::fromString(d->dayOfWeek(),"yyyy-MM-dd hh:mm:ss");
        if( dt.daysTo(QDateTime::currentDateTime()) == targetDay && dt.time().hour() == 12 )
            return d;
    }
}

QString WeatherNetworkConnection::niceTemperatureString(double t, bool displayDegree)
{
    int temp;

    if(tempPref == WeatherNetworkConnection::Fahrenheit)
        temp = (qRound(t-ZERO_KELVIN)*9/5)+32;
    else
        temp = qRound(t-ZERO_KELVIN);

    if(displayDegree)
        return QString::number(temp) + QChar(0xB0);
    else
        return QString::number(temp);
}

QString WeatherNetworkConnection::niceTime(double t)
{
    // return just the time from a Unix epoch
    QTimeZone z(QTimeZone::systemTimeZoneId());
    QDateTime dt(QDateTime::fromMSecsSinceEpoch(t,z));
    return dt.time().toString("h:mm AP");
}

QString WeatherNetworkConnection::niceDayOfWeek(double t)
{
    QTimeZone z(QTimeZone::systemTimeZoneId());
    QDateTime dt(QDateTime::fromMSecsSinceEpoch(t,z));
    return dt.toString("ddd");
}

QString WeatherNetworkConnection::niceDate( double t )
{
    QTimeZone z(QTimeZone::systemTimeZoneId());
    QDateTime dt(QDateTime::fromMSecsSinceEpoch(t,z));
    return dt.toString("MMM d yy");
}

QDateTime WeatherNetworkConnection::niceDateTime( double t )
{
    QTimeZone z(QTimeZone::systemTimeZoneId());
    QDateTime dt(QDateTime::fromMSecsSinceEpoch(t,z));
    return dt;
}
