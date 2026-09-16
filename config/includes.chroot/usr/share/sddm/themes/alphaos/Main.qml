import QtQuick 2.15
import QtQuick.Controls 2.15
import SddmComponents 2.0

Rectangle {
    id: root
    width: 1920
    height: 1080

    Image {
        anchors.fill: parent
        source: "wallpaper.png"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: true
    }

    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.30
    }

    Column {
        anchors.centerIn: parent
        spacing: 16
        width: 360

        Image {
            width: 120
            height: 120
            anchors.horizontalCenter: parent.horizontalCenter
            source: "alpha-logo.png"
            fillMode: Image.PreserveAspectFit
            smooth: true
            asynchronous: true
        }

        Label {
            width: parent.width
            text: "AlphaOS"
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 42
            font.bold: true
            color: "white"
        }

        TextField {
            id: username
            width: parent.width
            placeholderText: "Username"
            color: "white"
        }

        TextField {
            id: password
            width: parent.width
            placeholderText: "Password"
            echoMode: TextInput.Password
            color: "white"

            Keys.onReturnPressed: loginButton.clicked()
        }

        Button {
            id: loginButton
            width: parent.width
            text: "Login"

            onClicked: {
                sddm.login(
                    username.text,
                    password.text,
                    session.currentIndex
                )
            }
        }
    }

    Connections {
        target: sddm

        function onLoginFailed() {
            password.text = ""
        }
    }
}
