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
        onLoaded: item.fadeIn()
    }

    Loader {
        id: eventListWindowLoader
        onLoaded: item.fadeIn()
    }

    Loader {
        id: weatherWindowLoader
        onLoaded: item.fadeIn()
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
