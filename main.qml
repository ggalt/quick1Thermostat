import QtQuick 1.1

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
//        onSourceChanged: mainWinAnimation.running = true

//        NumberAnimation {
//            id: mainWinAnimation
//            target: mainWindowLoader.item
//            property: "opacity"
//            from: 0
//            to: 1
//            duration: 300
//            easing.type: Easing.InExpo
//        }
    }



    Loader {
        id: eventListWindowLoader
//        onSourceChanged: eventWinAnimation.running = true

//        NumberAnimation {
//            id: eventWinAnimation
//            target: eventListWindowLoader.item
//            property: "opacity"
//            from: 0
//            to: 1
//            duration: 300
//            easing.type: Easing.InExpo
//        }
    }

    Connections {
        target: mainWindowLoader.item
        onShowEventWindow: showEventListWindow()
    }

//    property string sourceComponent

//    function loadWindow(winName) {
//        console.log(winName)
//        if(winName === "MainWindow") {
//            loadComponent("MainWindow.qml")
////            mainRectangle.state = "MainWindowState"
//        } else if(winName ==="EventListWin") {
//            loadComponent("EventListWin.qml")
//        }
//    }

//    function loadComponent(component){
//        fadeIn.stop(); fadeOut.start();
//        sourceComponent = component;
//        fadeIn.start()
//    }

//    Loader {
//        id: mainWindowLoader
//        onLoaded: {fadeOut.complete(); fadeIn.start() }
//    }

//    Connections {
//        target: mainWindowLoader
//        onLoadWindow: loadWindow(newWinName)
//    }

//    NumberAnimation on opacity {
//        id: fadeOut
//        duration: 300
//        easing.type: Easing.OutCubic
//        to: 0.0
//        onCompleted: { mainWindowLoader.source = sourceComponent; }
//    }
//    NumberAnimation on opacity {
//        id: fadeIn
//        duration: 300
//        easing.type: Easing.InCubic
//        to: 1.0
//    }

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

//    Rectangle {
//        id: rectEventWin
//        gradient: mainGradient
//        anchors.fill: parent
//    }

//    Rectangle {
//        id: rectMainWin
//        gradient: mainGradient
//        anchors.fill: parent
//    }


//    MainWindow {
//        visible: true
//    }

//    EventListWin {
//        visible: false
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
        },
        State {
            name: "WeatherWindowState"
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
