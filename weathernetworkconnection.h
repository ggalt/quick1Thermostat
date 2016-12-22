#ifndef WEATHERNETWORKCONNECTION_H
#define WEATHERNETWORKCONNECTION_H

#include <QObject>
#include <QString>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QNetworkConfigurationManager>
#include <QtNetwork/QNetworkSession>

#include <QSignalMapper>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QStringList>
#include <QUrl>
#include <QUrlQuery>
#include <QTimer>

#include <QDeclarativeListProperty>

#include "weatherdata.h"
#include "forecastlistmodel.h"

class WeatherNetworkConnection : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool ready
               READ ready
               NOTIFY readyChanged)
    Q_PROPERTY(QString city
               READ city WRITE setCity
               NOTIFY cityChanged)
    Q_PROPERTY(WeatherData *weather
               READ weather
               NOTIFY weatherChanged)
    Q_PROPERTY(forecastListModel* forecast
               READ forecast
               NOTIFY forecastChanged)
//    Q_PROPERTY(QDeclarativeListProperty<WeatherData> forecast
//               READ forecast
//               NOTIFY weatherChanged)

public:
    explicit WeatherNetworkConnection(QObject *parent = 0);
    ~WeatherNetworkConnection();

    bool ready() const { return m_ready; }
    QString city() const { return m_city; }
    forecastListModel *forecast() const { return m_forecast; }

    WeatherData *getWeatherForDay(int daysFromToday );
    QString niceTemperatureString(double t, bool displayDegree = true);
    QString niceTime(double t);
    QString niceDayOfWeek(double t);
    QString niceDate( double t );
    QDateTime niceDateTime( double t );

    void setCity(const QString &value);
    WeatherData *weather();
//    QDeclarativeListProperty<WeatherData> forecast() const;

public:
    enum queryState { Weather, Forecast };
    enum temperaturePreference { Celsius, Fahrenheit };
    Q_ENUMS(queryState)
    Q_ENUMS(temperaturePreference)

public slots:
    void refreshWeather(void);

//! [2]
private slots:
    void constructURLs(void);
    void processWeather(QNetworkReply *networkReply);

//! [3]
signals:
    void readyChanged();
    void cityChanged();
    void weatherChanged();
    void forecastChanged();

private:
    void JsonProcessWeatherObject(WeatherData &data, QJsonObject &obj);
    void JsonProcessMainInfoObject(WeatherData &data, QJsonObject &obj);
    void JsonProcessSysInfoObject(WeatherData &data, QJsonObject &obj);
    void JsonProcessDateTextObject(WeatherData &data, QJsonObject &obj);
    void ProcessHiLowTemps(void);
    void setTempScalePreference(QString scale);

private:
    QString m_city;
    bool m_ready;
    WeatherData m_now;
//    QList<WeatherData*> m_forecast;
    forecastListModel *m_forecast;
//    QDeclarativeListProperty<WeatherData> *fcProp;

    QUrl m_weatherURL;
    QUrl m_forecastURL;
    QString m_apiKey;
    QNetworkAccessManager *m_netManager;
    QNetworkSession *m_session;
    QTimer tick;

    queryState qState;
    temperaturePreference tempPref;
};

#endif // WEATHERNETWORKCONNECTION_H
