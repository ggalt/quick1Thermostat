import QtQuick 1.1
import Qt.labs.gestures 1.0

Rectangle {
    id: mainRectangle
    width: 320
    height: 240

    gradient: Gradient {
        id: mainGradient
        GradientStop {
            position: 0
            color: "#ffffff"
        }

        GradientStop {
            position: 1
            color: "#62c288"
        }
    }

    property string degreeMark: String.fromCharCode(176)
    property int curTemp: 70
    property int targetTemp: 70
    property int curHumidity: 20
    property string curDate: ""
    property string curTime: ""
    property bool showColon: true


    function showMainWindow() {
        mainRectangle.state = "MainWindowState";
    }

    function showEventListWindow() {
        mainRectangle.state ="EventWindowState";
    }

    function showWeatherWindow() {
        mainRectangle.state = "WeatherWindowState"
    }

    Timer {
        id: introTimer
        interval: 700
        repeat: false
        running: true
        triggeredOnStart: true
        onTriggered: state="MainWindowState"
//        onTriggered: loadWindow("MainWindow")
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

//    Connections {
//        target: mainWindowLoader.item
//        onShowEventWindow: showEventListWindow()
//    }

    GestureArea {
        anchors.fill: parent
        onSwipe: console.log(Gesture.gestureType.toString(), Gesture.gestureType.valueOf())
    }



//    Text {
//        id: titleText
//        x: 119
//        y: 104
//        color: "#d12525"
//        text: qsTr("qThermostat")
//        visible: false
//        font.bold: true
//        font.italic: true
//        horizontalAlignment: Text.AlignHCenter
//        verticalAlignment: Text.AlignVCenter
//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.verticalCenter: parent.verticalCenter
//        font.pixelSize: 40
//    }

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
        },
        State {
            name: "AddEventState"
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
}
