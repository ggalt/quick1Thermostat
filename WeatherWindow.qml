import QtQuick 1.1

Rectangle {
    id: weatherWindow
    width: 320
    height: 240

    property int day1High: 70
    property int day1Low: 50
    property int day2High: 70
    property int day2Low: 50
    property int day3High: 70
    property int day3Low: 50

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

    function setCurrentWeatherIcon() {
        day1Image.source = setWeatherIcon(mainRectangle.todayIcon)
        day2Image.source = setWeatherIcon(mainRectangle.tomorrowIcon)
        day3Image.source = setWeatherIcon(mainRectangle.nextDayIcon)
        console.log("updating weather icons")
    }

    Image {
        id: day1Image
        width: 100
        height: 100
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.top: parent.top
        anchors.topMargin: 4
        source: "Sun-120.png"
    }

    Image {
        id: day2Image
        x: 114
        width: 100
        height: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 4
        source: "Sun-120.png"
    }

    Image {
        id: day3Image
        x: 220
        width: 100
        height: 100
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.top: parent.top
        anchors.topMargin: 4
        source: "Sun-120.png"
    }


    Text {
        id: day1Label
        x: 42
        y: 165
        text: mainRectangle.todayName
        font.pixelSize: 12
    }

    Text {
        id: day2Label
        x: 148
        y: 165
        text: mainRectangle.tomorrowName
        font.pixelSize: 12
    }

    Text {
        id: day3Label
        x: 254
        y: 165
        text: mainRectangle.nextDayName
        font.pixelSize: 12
    }

    Rectangle {
        id: backButton
        y: 192
        height: 40
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ffffff"
            }

            GradientStop {
                position: 1
                color: "#50c68b"
            }
        }
        anchors.rightMargin: 4
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8

        Text {
            id: text1
            x: 134
            y: 13
            text: qsTr("Back")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }

        MouseArea {
            id: maBackButton
            x: 0
            anchors.fill: parent
            onClicked: mainRectangle.showMainWindow()
        }
    }

    Rectangle {
        id: day1Rect
        x: 4
        y: 113
        width: 3*day1Image.width/4
        height: 34
        color: "#00000000"
        anchors.horizontalCenter: day1Image.horizontalCenter
        Text {
            id: day1HighTemp
            x: 86
            text: mainRectangle.todayHiTemp
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.top: parent.top
            font.pixelSize: 12
        }

        Text {
            id: day1LowTemp
            x: 86
            y: 133
            text: mainRectangle.todayLoTemp
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 0
            font.pixelSize: 12
        }

        Text {
            id: day1LowLabel
            x: 0
            y: 133
            text: qsTr("LOW:")
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 0
            font.pixelSize: 12
        }

        Text {
            id: day1HighLabel
            x: 86
            y: 0
            text: "HIGH:"
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            font.pixelSize: 12
        }
    }

    Rectangle {
        id: day2Rect
        x: 110
        y: 113
        width: 3*day2Image.width/4
        height: 34
        color: "#00000000"
        anchors.horizontalCenter: day2Image.horizontalCenter
        Text {
            id: day2LowTemp
            x: 86
            y: 133
            text: mainRectangle.tomorrowLoTemp
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 0
            font.pixelSize: 12
        }

        Text {
            id: day2LowLabel
                x: 0
                y: 133
                text: "LOW:"
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
        }

        Text {
            id: day2HighTemp
            x: 86
            y: 0
            text: mainRectangle.tomorrowHiTemp
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            font.pixelSize: 12
        }

        Text {
            id: day2HighLabel
            text: "HIGH:"
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
        }

    }

    Rectangle {
        id: day3Rect
        x: 216
        y: 113
        width: 3*day3Image.width/4
        height: 34
        color: "#00000000"
        anchors.horizontalCenter: day3Image.horizontalCenter
        Text {
            id: day3LowTemp
            x: 82
            y: 133
            text: mainRectangle.nextDayLoTemp
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 0
            font.pixelSize: 12
        }

        Text {
            id: day3LowLabel
                x: 0
                y: 133
                text: "LOW:"
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
        }

        Text {
            id: day3HighTemp
            x: 82
            y: 0
            text: mainRectangle.nextDayHiTemp
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            font.pixelSize: 12
        }

        Text {
            id: day3HighLabel
            x: 0
                y: 0
                text: "HIGH:"
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                font.pixelSize: 12
        }

    }
}
