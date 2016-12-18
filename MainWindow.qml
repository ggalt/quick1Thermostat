import QtQuick 1.1

Rectangle {
    id: rectangle1
    width: 320
    height: 240

    opacity: 0

    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#ffffff"
        }

        GradientStop {
            position: 1
            color: "#62c288"
        }
    }

    NumberAnimation on opacity {
        id: fadeInAnimation
        duration: 300
        easing.type: Easing.InCubic
        to: 1.0
    }

    function fadeIn() {
        fadeInAnimation.start()
    }
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
    function setWeatherIcon() {
        switch(weatherIcon) {
        case "01d":
        case "01n":
            imgCurrentWeather.source = "icons/weather-sunny.png"
            break;
        case "02d":
        case "02n":
            imgCurrentWeather.source = "icons/weather-sunny-very-few-clouds.png"
            break;
        case "03d":
        case "03n":
            imgCurrentWeather.source = "icons/weather-few-clouds.png"
            break;
        case "04d":
        case "04n":
            imgCurrentWeather.source = "icons/weather-overcast.png"
            break;
        case "09d":
        case "09n":
            imgCurrentWeather.source = "icons/weather-showers.png"
            break;
        case "10d":
        case "10n":
            imgCurrentWeather.source = "icons/weather-showers.png"
            break;
        case "11d":
        case "11n":
            imgCurrentWeather.source = "icons/weather-thundershower.png"
            break;
        case "13d":
        case "13n":
            imgCurrentWeather.source = "icons/weather-snow.png"
            break;
        case "50d":
        case "50n":
            imgCurrentWeather.source = "icons/weather-fog.png"
            break;
        default:
            imgCurrentWeather.source = "icons/weather-sunny-very-few-clouds.png"
            break;
        }
        if(weatherIconTimer.interval===6000)
            weatherIconTimer.interval=60*1000*5
    }

    Timer {
        id: weatherIconTimer
        interval: 6000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: setWeatherIcon()
    }


    signal loadWindow(string newWinName)
    signal showEventWindow

    Text {
        id: txtCurrentTemp
        x: 101
        y: 73
        text: curTemp
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 90

        MouseArea {
            id: maCurrentTemp
            anchors.fill: parent
            onClicked: mainRectangle.showEventListWindow()
        }
    }

    Text {
        id: txtTargetTemp
        x: 294
        text: targetTemp.toString()
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignTop
        horizontalAlignment: Text.AlignRight
        anchors.right: parent.right
        anchors.rightMargin: 2
        font.pixelSize: 40

        MouseArea {
            id: maTargetTemp
            anchors.fill: parent
            onClicked: mainRectangle.showEventListWindow()
        }
    }

    Image {
        id: upButton
        x: 140
        y: 32
        width: 40
        height: 40
        anchors.bottomMargin: 5
        anchors.bottom: txtTargetTemp.top
        anchors.horizontalCenter: txtTargetTemp.horizontalCenter
        source: "icons/uparrow.png"

        MouseArea {
            id: maUpButton
            anchors.fill: parent
            onClicked: {
                targetTemp += 1
                if(targetTemp > 99)
                    targetTemp = 99
            }
        }
    }

    Image {
        id: downButton
        x: 140
        width: 40
        height: 40
        anchors.top: txtTargetTemp.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: txtTargetTemp.horizontalCenter
        source: "icons/downarrow.png"

        MouseArea {
            id: maDownButton
            anchors.fill: parent
            onClicked: {
                targetTemp -= 1
                if(targetTemp < 40)
                    targetTemp = 40
            }
        }
    }

    Text {
        id: tempLabel
        x: 236
        y: 18
        text: qsTr("Target:")
        anchors.verticalCenter: txtTargetTemp.verticalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        anchors.right: txtTargetTemp.left
        font.pixelSize: 12
    }

    Text {
        id: txtDate
        y: 204
        text: mainRectangle.curDate
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        font.pixelSize: 24
    }

    Text {
        id: txtTime
        x: 286
        y: 218
        text: mainRectangle.curTime
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8
        font.pixelSize: 24
    }

    Image {
        id: imgCurrentWeather
        width: 80
        height: 80
        fillMode: Image.PreserveAspectFit
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 2
        source: "icons/weather-sunny-very-few-clouds.png"

        MouseArea {
            id: maWeather
            z: 1
            anchors.fill: parent
            onClicked: mainRectangle.showWeatherWindow()
        }

        Text {
            id: outsideTemp
            x: 86
            y: 26
            text: outsideCurrentTemp
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            font.pixelSize: 22
        }
    }

    Text {
        id: txtRelHum
        x: 292
        text: curHumidity+"%"
        anchors.top: parent.top
        anchors.topMargin: 2
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.right: parent.right
        anchors.rightMargin: 2
        font.pixelSize: 20
    }

    Image {
        id: imgCoolingState
        y: 138
        width: 60
        height: 60
        fillMode: Image.PreserveAspectFit
        opacity: 1
        anchors.leftMargin: 2
        anchors.left: parent.left
        anchors.bottom: txtTime.top
        anchors.bottomMargin: 6
        source: "icons/heating.png"
    }

    Text {
        id: lblRelHum
        x: 105
        y: 12
        text: qsTr("Humidity:")
        anchors.right: txtRelHum.left
        anchors.verticalCenter: txtRelHum.verticalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
    }
}
