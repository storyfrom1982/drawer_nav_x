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

    Pane {
        id: root
        anchors.fill: parent
        anchors.topMargin: 0
        //        anchors.margins: {
        //            left:10
        //            right:10
        //            top:10
        //            bottom:10
        //        }

        Rectangle{
            anchors.fill: parent
            color: "red"
        }

        ColumnLayout {
            anchors.topMargin: 0
            anchors.fill: parent

            LabelHeadline {
                id: head
                //                Layout.alignment: Qt.AlignHCenter
                //                Layout.alignment: Qt.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Drive by Car")
                color: "blue"
                background: Rectangle {
                    anchors.fill: parent
                    color: "green"
                }
            }

            Rectangle{
                anchors.top: head.bottom
                //                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                color: "transparent"

                ListView {
                    id: lv
                    property int lineHeight: 20
                    property int lineWidth: height / lineHeight
                    property int wordSize: lineWidth * 0.80
                    property int wordSpacing: lineWidth * 0.20
                    layoutDirection: Qt.RightToLeft
                    orientation: ListView.Horizontal
                    anchors.fill: parent
                    clip: true
                    spacing: 10
                    model: 300
                    delegate: readerDelegate

                }

                Component {
                    id: readerDelegate

                    Row {
                        spacing: 10

                        VerticalDivider {}

                        Rectangle {
                            id: textDelegate
                            width: lv.lineWidth
                            implicitHeight: lv.height
                            color: "transparent"

                            property int line: index

                            Column {
                                anchors.fill: parent
                                spacing: lv.wordSpacing

                                Repeater {
                                    id: repeater
                                    model: lv.lineHeight

                                    WordButton {
                                        id: word_box
                                        width: lv.wordSize
                                        height: lv.wordSize
                                        text: lv.lineHeight * textDelegate.line + index
                                        pixelSize: lv.wordSize

                                        onClicked: {
                                            var pos_abs = flickable.mapFromItem (word_box.parent, word_box.x, word_box.y);
                                            pos_abs.x -= word_card.width
                                            pos_abs.y -= word_card.height + 20
                                            word_card.pos = pos_abs
                                            word_card.text = text
                                            word_card.pixelSize = pixelSize
                                            console.debug("listview index ======= " + pos_abs)
                                            word_card.open()
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


    Popup{
        id: word_card

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
