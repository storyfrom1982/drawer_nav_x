import QtQuick 2.0

Item {
    id: btn
    width: word.width
    height: word.height

    signal clicked

    property alias text: word.text
    property alias color: word.color
    property alias pixelSize: word.font.pixelSize

    Text {
        id: word
        anchors.centerIn: parent
        opacity: enabled ? 1.0 : 0.3
        color: flatButtonTextColor
        elide: Text.ElideRight
        font.weight: Font.Medium
        font.capitalization: Font.AllUppercase
    }

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        color: button.pressed ? word.color : "transparent"
        radius: 2
        opacity: button.pressed ? 0.12 : 1.0
        MouseArea {
            id: button
            anchors.fill: parent
            onClicked: btn.clicked()
        }
    }
}
