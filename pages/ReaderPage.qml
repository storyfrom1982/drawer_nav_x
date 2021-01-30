import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import "../common"

Flickable {

    id: flickable

//    implicitWidth: root.implicitWidth
//    contentHeight: root.implicitHeight
    // index to get access to Loader (Destination)
    property int myIndex: index
    // StackView manages this, so please no anchors here
    // anchors.fill: parent
    property string name: "PageThree"

    Popup{
        id: popText

        property var pos
        property alias text: name.text
        property alias pixelSize: name.font.pixelSize

        x: pos.x
        y: pos.y
        z: 3

        width: 256
        height: 256

//        modal: true

        Rectangle {

            Text {
                id: name
                text: qsTr("text")
            }
        }
    }


    Pane {
        id: root
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent

            LabelHeadline {
                id: head
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Drive by Car")
                color: "blue"
            }

            Rectangle{
                anchors.top: head.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                color: "transparent"

                ListView {
                    id: lv
                    layoutDirection: Qt.RightToLeft
                    orientation: ListView.Horizontal
                    anchors.fill: parent
                    clip: true
                    spacing: 1
                    model: 1000
                    delegate: readerDelegate

                }

                Component {
                    id: readerDelegate

                    Row {
                        VerticalDivider {}

                        Rectangle {
                            id: textDelegate
                            width: 40
                            implicitHeight: lv.height
                            color: "transparent"

                            property int line: index

                            Column {
                                anchors.fill: parent

                                Repeater {
                                    id: repeater
                                    property int count: lv.height > 40 ? (lv.height - 40) / 40 : 0
                                    model: count

                                    WordButton {
                                        id: word
                                        width: parent.width
                                        height: 40
                                        text: repeater.count * textDelegate.line + index
                                        pixelSize: fontSizeHeadline

                                        onClicked: {
                                            var pos_abs = flickable.mapFromItem (word.parent, word.x, word.y);
                                            pos_abs.x -= popText.width
                                            pos_abs.y -= popText.height + 20
                                            popText.pos = pos_abs
                                            popText.text = text
                                            popText.pixelSize = pixelSize
                                            console.debug("listview index ======= " + pos_abs)
                                            popText.open()
                                        }
                                    }
                                }
                            }

                            Component.onCompleted: {
//                                console.debug("listview index ======= " + myIndex)
                            }
                        }

                    }
                }
            }
        }

    }


    ScrollIndicator.vertical: ScrollIndicator { }

    // emitting a Signal could be another option
    Component.onDestruction: {
        cleanup()
    }

    // called immediately after Loader.loaded
    function init() {
        console.log(qsTr("Init done from Reader"))
    }
    // called from Component.destruction
    function cleanup() {
        console.log(qsTr("Cleanup done from Reader"))
    }
}
