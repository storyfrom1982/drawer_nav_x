// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

// Flat Button
Button {
    id: button
    // default: flatButtonTextColor
    property real radius: 2
    property alias textColor: buttonText.color
    focusPolicy: Qt.NoFocus
    // Layout.fillWidth: true
    // Layout.preferredWidth : 1
    // leftPadding: 10
    // rightPadding: 10
    padding: 15
    contentItem: Text {
        id: buttonText
        text: button.text
        opacity: enabled ? 1.0 : 0.3
        color: flatButtonTextColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        font.capitalization: Font.AllUppercase
        font.weight: Font.Medium
    }
    background:
        Rectangle {
        id: buttonBackground
        color: button.pressed ? buttonText.color : "transparent"
        border.color: buttonText.color
        radius: button.radius
        opacity: button.pressed ? 0.32 : button.hovered ? 0.12 : 0.22
    } // background
} // button
