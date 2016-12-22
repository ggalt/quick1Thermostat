import QtQuick 1.1
import Qt.labs.gestures 1.0

Item {
    id: mainRectangle
    width: 320
    height: 240
    objectName: "mainRectangle"

//    gradient: Gradient {
//        id: mainGradient
//        GradientStop {
//            position: 0
//            color: "#ffffff"
//        }

//        GradientStop {
//            position: 1
//            color: "#62c288"
//        }
//    }

    property string curTemp: ""
    property string targetTemp: ""
    property string curHumidity: ""
    property string curDate: ""
    property string curTime: ""
    property bool showColon: true
    property string outsideCurrentTemp: ""
    property string weatherIcon: "01d"
    property int fanState: 0
    property int coolingState: 0

    property string todayHiTemp: ""
    property string todayLoTemp: ""
    property string tomorrowHiTemp: ""
    property string tomorrowLoTemp: ""
    property string nextDayHiTemp: ""
    property string nextDayLoTemp: ""
    property string todayName: ""
    property string tomorrowName: ""
    property string nextDayName: ""
    property string todayIcon: ""
    property string tomorrowIcon: ""
    property string nextDayIcon: ""

    function showMainWindow() {
        mainRectangle.state = "MainWindowState";
    }

    function showEventListWindow() {
        mainRectangle.state ="EventWindowState";
    }

    function showWeatherWindow() {
        mainRectangle.state = "WeatherWindowState"
    }

//    Timer {
//        id: introTimer
//        interval: 700
//        repeat: false
//        running: true
//        triggeredOnStart: true
//        onTriggered: state="MainWindowState"
//    }

    /*
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
//        function setWeatherIcon() {
//            switch(weatherIcon) {
//            case "01d":
//            case "01n":
//                imgCurrentWeather.source = "icons/weather-sunny.png"
//                break;
//            case "02d":
//            case "02n":
//                imgCurrentWeather.source = "icons/weather-sunny-very-few-clouds.png"
//                break;
//            case "03d":
//            case "03n":
//                imgCurrentWeather.source = "icons/weather-few-clouds.png"
//                break;
//            case "04d":
//            case "04n":
//                imgCurrentWeather.source = "icons/weather-overcast.png"
//                break;
//            case "09d":
//            case "09n":
//                imgCurrentWeather.source = "icons/weather-showers.png"
//                break;
//            case "10d":
//            case "10n":
//                imgCurrentWeather.source = "icons/weather-showers.png"
//                break;
//            case "11d":
//            case "11n":
//                imgCurrentWeather.source = "icons/weather-thundershower.png"
//                break;
//            case "13d":
//            case "13n":
//                imgCurrentWeather.source = "icons/weather-snow.png"
//                break;
//            case "50d":
//            case "50n":
//                imgCurrentWeather.source = "icons/weather-fog.png"
//                break;
//            default:
//                imgCurrentWeather.source = "icons/weather-sunny-very-few-clouds.png"
//                break;
//            }
//            if(weatherIconTimer.interval===6000)
//                weatherIconTimer.interval=60*1000*5
//        }

    function setWeatherIcon(weatherIcon) {
        if(weatherIconTimer.interval===6000)
            weatherIconTimer.interval=60*1000*5

        switch(weatherIcon) {
        case "01d":
        case "01n":
            return "icons/weather-sunny.png"
        case "02d":
        case "02n":
            return "icons/weather-sunny-very-few-clouds.png"
        case "03d":
        case "03n":
            return "icons/weather-few-clouds.png"
        case "04d":
        case "04n":
            return "icons/weather-overcast.png"
        case "09d":
        case "09n":
            return "icons/weather-showers.png"
        case "10d":
        case "10n":
            return "icons/weather-showers.png"
        case "11d":
        case "11n":
            return "icons/weather-thundershower.png"
        case "13d":
        case "13n":
            return "icons/weather-snow.png"
        case "50d":
        case "50n":
            return "icons/weather-fog.png"
        default:
            return "icons/weather-sunny-very-few-clouds.png"
        }
    }

    Timer {
            id: weatherIconTimer
            interval: 6000
            repeat: true
            running: true
            triggeredOnStart: true
//            onTriggered:
        }

    Timer {
        id: textTimer
        interval: 500
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: getTime()
    }

    Loader {
        id: spashScreenLoader
        onLoaded: item.fadeIn()
    }

    Loader {
        id: mainWindowLoader
        onLoaded: {
            item.fadeIn()
            weatherIconTimer.triggered.connect(item.setCurrentWeatherIcon)
        }
    }

    Loader {
        id: eventListWindowLoader
        onLoaded: item.fadeIn()
    }

    Loader {
        id: weatherWindowLoader
        onLoaded: {
            item.fadeIn()
            item.setCurrentWeatherIcon()
            weatherIconTimer.triggered.connect(item.setCurrentWeatherIcon)
        }
    }


    states: [
        State {
            name: "MainWindowState"
            PropertyChanges {
                target: mainWindowLoader;
                source: "MainWindow.qml"
            }
            PropertyChanges {
                target: eventListWindowLoader
                source: ""
            }
            PropertyChanges {
                target: weatherWindowLoader
                source: ""
            }
            PropertyChanges {
                target: spashScreenLoader
                source: ""
            }
        },
        State {
            name: "EventWindowState"
            PropertyChanges {
                target: mainWindowLoader;
                source: ""
            }
            PropertyChanges {
                target: eventListWindowLoader
                source: "EventListWin.qml"
            }
            PropertyChanges {
                target: weatherWindowLoader
                source: ""
            }
            PropertyChanges {
                target: spashScreenLoader
                source: ""
            }
        },
        State {
            name: "WeatherWindowState"
            PropertyChanges {
                target: mainWindowLoader;
                source: ""
            }
            PropertyChanges {
                target: eventListWindowLoader
                source: ""
            }
            PropertyChanges {
                target: weatherWindowLoader
                source: "WeatherWindow.qml"
            }
            PropertyChanges {
                target: spashScreenLoader
                source: ""
            }
        },
        State {
            name: "AddEventState"
        },
        State {
            name: "SpashScreenState"
            PropertyChanges {
                target: mainWindowLoader;
                source: ""
            }
            PropertyChanges {
                target: eventListWindowLoader
                source: ""
            }
            PropertyChanges {
                target: weatherWindowLoader
                source: ""
            }
            PropertyChanges {
                target: spashScreenLoader
                source: "SplashScreen.qml"
            }
        }
    ]

    function getTime() {
        curDate = Qt.formatDate(new Date(),"MMM dd, yyyy");
        if(showColon) {
            curTime = Qt.formatTime(new Date(), "hh:mm AP")
        } else {
            curTime = Qt.formatTime(new Date(), "hh mm AP")
        }
        showColon = !showColon;
    }

    state: "SpashScreenState"

}
