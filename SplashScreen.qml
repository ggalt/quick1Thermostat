import QtQuick 1.1

Rectangle {
    id: splashScreen
    width: 320
    height: 240

    opacity: 1

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

    Text {
        id: text1
        x: 163
        y: 113
        color: "#5c5a5a"
        text: qsTr("qThermostat")
        font.underline: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        style: Text.Raised
        font.bold: true
        font.italic: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 38
    }
}
