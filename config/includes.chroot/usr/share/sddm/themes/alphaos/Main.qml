import QtQuick 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0

Item {
    id: root

    width: 1920
    height: 1080

    property string currentUser: ""
    property bool loginFailed: false
    property bool powerMenuVisible: false

    Image {
        anchors.fill: parent
        source: "wallpaper.png"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: true
    }

    Rectangle {
        anchors.fill: parent
        color: "#050914"
        opacity: 0.60
    }

    Row {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 48
        anchors.topMargin: 38
        spacing: 14

        Image {
            width: 48
            height: 48
            source: "alpha-logo.png"
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            Text {
                text: "AlphaOS"
                color: "#ffffff"
                font.pixelSize: 25
                font.bold: true
            }

            Text {
                text: "Simple. Fast. Yours."
                color: "#8fa3c7"
                font.pixelSize: 12
            }
        }
    }

    Column {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 48
        anchors.topMargin: 38
        spacing: 2

        Text {
            id: clockText
            anchors.right: parent.right
            color: "#ffffff"
            font.pixelSize: 25
            font.bold: true

            function update() {
                text = Qt.formatTime(new Date(), "hh:mm")
            }

            Component.onCompleted: update()
        }

        Text {
            id: dateText
            anchors.right: parent.right
            color: "#8fa3c7"
            font.pixelSize: 12

            function update() {
                text = Qt.formatDate(
                    new Date(),
                    "dddd, dd MMMM yyyy"
                )
            }

            Component.onCompleted: update()
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            clockText.update()
            dateText.update()
        }
    }

    Rectangle {
        id: loginCard

        width: 410
        height: 350

        anchors.centerIn: parent

        radius: 18
        color: "#111722"

        border.width: 1
        border.color: "#303b50"

        Image {
            anchors.centerIn: parent

            width: 180
            height: 180

            source: "alpha-logo.png"
            opacity: 0.035

            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        Column {
            anchors.fill: parent
            anchors.margins: 28

            spacing: 14

            Text {
                width: parent.width

                text: "Welcome to AlphaOS"

                color: "#ffffff"

                font.pixelSize: 23
                font.bold: true

                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                width: parent.width

                text: "Sign in to continue"

                color: "#8190a8"

                font.pixelSize: 12

                horizontalAlignment: Text.AlignHCenter
            }

            // USER
            ListView {
                id: userList

                width: parent.width
                height: 52

                model: userModel

                currentIndex: userModel.lastIndex >= 0
                              ? userModel.lastIndex
                              : 0

                clip: true
                interactive: false

                delegate: Rectangle {
                    width: userList.width
                    height: 52

                    radius: 9

                    color: "#181f2b"

                    border.width: 1
                    border.color: "#303b4e"

                    property string username: model.name

                    Row {
                        anchors.fill: parent

                        anchors.leftMargin: 14
                        anchors.rightMargin: 14

                        spacing: 12

                        Image {
                            width: 34
                            height: 34

                            anchors.verticalCenter: parent.verticalCenter

                            source: model.icon !== ""
                                    ? model.icon
                                    : "alpha-logo.png"

                            fillMode: Image.PreserveAspectCrop

                            smooth: true

                            sourceSize.width: 64
                            sourceSize.height: 64
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter

                            spacing: 1

                            Text {
                                text: model.realName !== ""
                                      ? model.realName
                                      : model.name

                                color: "#e8edf5"

                                font.pixelSize: 14
                                font.bold: true
                            }

                            Text {
                                text: model.name

                                color: "#71819b"

                                font.pixelSize: 11
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            userList.currentIndex = index
                            root.currentUser = model.name
                            passwordField.forceActiveFocus()
                        }
                    }

                    Component.onCompleted: {
                        if (index === userList.currentIndex)
                            root.currentUser = model.name
                    }
                }

                Component.onCompleted: {
                    if (count > 0) {
                        if (userModel.lastIndex >= 0)
                            currentIndex = userModel.lastIndex
                        else
                            currentIndex = 0

                        if (userModel.lastUser !== "")
                            root.currentUser = userModel.lastUser
                    }
                }
            }

            // PASSWORD
            Rectangle {
                width: parent.width
                height: 46

                radius: 9

                color: "#181f2b"

                border.width: 1

                border.color: passwordInput.activeFocus
                               ? "#4776d0"
                               : "#303b4e"

                TextInput {
                    id: passwordInput

                    anchors.fill: parent

                    anchors.leftMargin: 14
                    anchors.rightMargin: 14

                    verticalAlignment: TextInput.AlignVCenter

                    color: "#e8edf5"

                    font.pixelSize: 13

                    echoMode: TextInput.Password

                    selectByMouse: true

                    clip: true

                    Text {
                        anchors.fill: parent

                        visible: passwordInput.text.length === 0

                        text: "Password"

                        color: "#71819b"

                        font.pixelSize: 13

                        verticalAlignment: Text.AlignVCenter

                        enabled: false
                    }

                    Keys.onReturnPressed: root.login()
                    Keys.onEnterPressed: root.login()
                }
            }

            // LOGIN
            Rectangle {
                id: loginButton

                width: parent.width
                height: 46

                radius: 9

                property bool enabled:
                    root.currentUser !== "" &&
                    passwordInput.text.length > 0

                color: enabled
                       ? "#315fba"
                       : "#252c38"

                border.width: 1

                border.color: enabled
                               ? "#4776d0"
                               : "#303746"

                Text {
                    anchors.fill: parent

                    text: "Log In"

                    color: loginButton.enabled
                           ? "#ffffff"
                           : "#66738a"

                    font.pixelSize: 13
                    font.bold: true

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    anchors.fill: parent

                    enabled: loginButton.enabled

                    cursorShape: Qt.PointingHandCursor

                    onClicked: root.login()
                }
            }

            Text {
                width: parent.width

                visible: root.loginFailed

                text: "Login failed. Please check your password."

                color: "#ef7d7d"

                font.pixelSize: 11

                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    function login() {
        if (root.currentUser === "")
            return

        if (passwordInput.text === "")
            return

        var sessionIndex = sessionModel.lastIndex

        if (sessionIndex < 0)
            sessionIndex = 0

        root.loginFailed = false

        sddm.login(
            root.currentUser,
            passwordInput.text,
            sessionIndex
        )
    }

    Connections {
        target: sddm

        function onLoginFailed() {
            root.loginFailed = true

            passwordInput.selectAll()
            passwordInput.forceActiveFocus()
        }
    }

    Connections {
        target: userModel

        function onLastIndexChanged() {
            if (userModel.lastIndex >= 0) {
                userList.currentIndex = userModel.lastIndex

                if (userModel.lastUser !== "")
                    root.currentUser = userModel.lastUser
            }
        }
    }

    // POWER BUTTON
    Rectangle {
        id: powerButton

        width: 48
        height: 48

        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.rightMargin: 48
        anchors.bottomMargin: 38

        radius: 24

        color: "#151d29"

        border.width: 1
        border.color: "#344158"

        Text {
            anchors.fill: parent

            text: "⏻"

            color: "#ffffff"

            font.pixelSize: 23

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            anchors.fill: parent

            cursorShape: Qt.PointingHandCursor

            onClicked: {
                root.powerMenuVisible = !root.powerMenuVisible
            }
        }
    }

    // POWER MENU
    Rectangle {
        id: powerMenu

        width: 150
        height: 96

        visible: root.powerMenuVisible

        anchors.right: powerButton.left
        anchors.bottom: powerButton.top

        anchors.rightMargin: 10
        anchors.bottomMargin: 10

        radius: 10

        color: "#151d29"

        border.width: 1
        border.color: "#344158"

        Column {
            anchors.fill: parent
            anchors.margins: 6

            Rectangle {
                width: parent.width
                height: 40

                radius: 7

                color: restartMouse.containsMouse
                       ? "#26354d"
                       : "transparent"

                Text {
                    anchors.fill: parent

                    text: "Restart"

                    color: "#ffffff"

                    font.pixelSize: 13

                    leftPadding: 14

                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    id: restartMouse

                    anchors.fill: parent

                    hoverEnabled: true

                    onClicked: {
                        root.powerMenuVisible = false

                        if (sddm.canReboot)
                            sddm.reboot()
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 40

                radius: 7

                color: shutdownMouse.containsMouse
                       ? "#26354d"
                       : "transparent"

                Text {
                    anchors.fill: parent

                    text: "Shut Down"

                    color: "#ffffff"

                    font.pixelSize: 13

                    leftPadding: 14

                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    id: shutdownMouse

                    anchors.fill: parent

                    hoverEnabled: true

                    onClicked: {
                        root.powerMenuVisible = false

                        if (sddm.canPowerOff)
                            sddm.powerOff()
                    }
                }
            }
        }
    }

    Text {
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        anchors.leftMargin: 48
        anchors.bottomMargin: 42

        text: "Built for performance. Designed for everyone."

        color: "#71819b"

        font.pixelSize: 11
    }

    Component.onCompleted: {
        if (userModel.lastUser !== "")
            root.currentUser = userModel.lastUser

        passwordInput.forceActiveFocus()
    }
}