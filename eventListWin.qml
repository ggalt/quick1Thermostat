import QtQuick 1.1

Rectangle {
    id: eventListWin

    signal goBack

    width: 320
    height: 240
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#0dff6e"
        }

        GradientStop {
            position: 1
            color: "#62c288"
        }
    }

    Rectangle {
        id: dayToolBar
        height: 50
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        gradient: Gradient {
            id: dayToolBarGradient
            GradientStop {
                position: 0
                color: "#0dff6e"
            }

            GradientStop {
                position: 1
                color: "#62c288"
            }
        }

        Text {
            id: btnSunday
            width: 40
            height: 50
            text: qsTr("SU")
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12

            MouseArea {
                id: maBtnSunday
                anchors.fill: parent
            }
        }

        Text {
            id: btnMonday
            width: 40
            height: 50
            text: qsTr("MO")
            anchors.left: btnSunday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            MouseArea {
                id: maBtnMonday
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 12
        }

        Text {
            id: btnTuesday
            width: 40
            height: 50
            text: qsTr("TU")
            anchors.left: btnMonday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            MouseArea {
                id: maBtnTuesday
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 12
        }

        Text {
            id: btnWednesday
            width: 40
            height: 50
            text: qsTr("WE")
            anchors.left: btnTuesday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            MouseArea {
                id: maBtnWednesday
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 12
        }

        Text {
            id: btnThursday
            width: 40
            height: 50
            text: qsTr("TH")
            anchors.left: btnWednesday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            MouseArea {
                id: maBtnThursday
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 12
        }

        Text {
            id: btnFriday
            width: 40
            height: 50
            text: qsTr("FR")
            anchors.left: btnThursday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            MouseArea {
                id: maBtnFriday
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 12
        }

        Text {
            id: btnSaturday
            width: 40
            height: 50
            text: qsTr("SA")
            anchors.left: btnFriday.right
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            MouseArea {
                id: maBtnSaturday
                anchors.fill: parent
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 12
        }

        Image {
            id: backButton
            width: 40
            height: 50
            source: "backArrow.png"
            fillMode: Image.Stretch
            anchors.left: btnSaturday.right
            anchors.top: parent.top

            MouseArea {
                id: maBackButton
                anchors.fill: parent
                onClicked: eventListWin.goBack()
            }
        }
    }

    ListView {
        id: eventListView
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: dayToolBar.bottom
        model: ListModel {
            ListElement {
                name: "Grey"
                colorCode: "grey"
            }

            ListElement {
                name: "Red"
                colorCode: "red"
            }

            ListElement {
                name: "Blue"
                colorCode: "blue"
            }

            ListElement {
                name: "Green"
                colorCode: "green"
            }
        }
        delegate: Item {
            x: 5
            width: 80
            height: 40
            Row {
                id: row1
                Rectangle {
                    width: 40
                    height: 40
                    color: colorCode
                }

                Text {
                    text: name
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }
                spacing: 10
            }
        }
    }
}
