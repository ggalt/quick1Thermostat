import QtQuick 1.1

Rectangle {
    width: 320
    height: 240

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

    signal loadWindow(string newWinName)

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
        font.pixelSize: 72
    }

    Text {
        id: txtTargetTemp
        x: 294
        text: targetTemp.toString()
        anchors.topMargin: 2
        verticalAlignment: Text.AlignTop
        horizontalAlignment: Text.AlignRight
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.top: parent.top
        font.pixelSize: 40

        MouseArea {
            id: maTargetTemp
            anchors.fill: parent
            onClicked: loadWindow("EventListWin")
//            onClicked: showEventWindow()
        }
    }

    Image {
        id: upButton
        x: 140
        y: 32
        width: 40
        height: 40
        source: "uparrow.png"

        MouseArea {
            id: maUpButton
            anchors.fill: parent
        }
    }

    Image {
        id: downButton
        x: 140
        y: 168
        width: 40
        height: 40
        source: "downarrow.png"

        MouseArea {
            id: maDownButton
            anchors.fill: parent
        }
    }

    Text {
        id: tempLabel
        x: 236
        y: 18
        text: qsTr("Target:")
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
        id: currentWeather
        width: 80
        height: 80
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 2
        source: "qrc:/qtquickplugin/images/template_image.png"

        MouseArea {
            id: maWeather
            anchors.fill: parent
        }
    }

    Text {
        id: txtRelHum
        x: 292
        text: curHumidity+"%"
        anchors.top: txtTargetTemp.bottom
        anchors.topMargin: 10
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.right: parent.right
        anchors.rightMargin: 2
        font.pixelSize: 20
    }

    Text {
        id: outsideTemp
        y: 35
        text: qsTr("70")
        anchors.left: currentWeather.right
        anchors.leftMargin: 6
        anchors.verticalCenter: currentWeather.verticalCenter
        font.pixelSize: 22
    }

    Image {
        id: imgCoolingState
        x: 258
        y: 138
        width: 60
        height: 60
        anchors.bottom: txtTime.top
        anchors.bottomMargin: 6
        anchors.right: parent.right
        anchors.rightMargin: 2
        source: "qrc:/qtquickplugin/images/template_image.png"
    }
}
