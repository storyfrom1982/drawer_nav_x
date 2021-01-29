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
                    delegate: numberDelegate

                }

                Component {
                    id: numberDelegate

                    Row {

                        VerticalDivider {}

                        Rectangle {
                            width: 40
                            implicitHeight: lv.height
                            color: "transparent"

                            Column {
                                anchors.fill: parent

                                Repeater {

                                    model: lv.height > 40 ? (lv.height - 40) / 40 : 0
                                    delegate: Rectangle {
                                        width: parent.width
                                        height: 40
                                        color: "transparent"
                                        Text {
                                            anchors.centerIn: parent
                                            font.pixelSize: fontSizeHeadline
                                            text: index
//                                            text: qsTr("文")
                                        }
                                    }
                                }
                            }

                            Component.onCompleted: {
//                                console.debug("index ======= " + index)
                            }
                        }

                        Component.onCompleted: {
                            console.debug("index ======= " + index)
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
