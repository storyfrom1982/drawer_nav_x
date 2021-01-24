import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import "../common"

Flickable {

    id: flickable

    contentHeight: root.implicitHeight
    // index to get access to Loader (Destination)
    property int myIndex: index
    // StackView manages this, so please no anchors here
    // anchors.fill: parent
    property string name: "PageThree"


    Pane {
        id: root
        anchors.fill: parent



        ColumnLayout {
            anchors.right: parent.right
            anchors.left: parent.left

            LabelHeadline {
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Drive by Car")
                color: "blue"
            }

            Rectangle{
//                Layout.preferredHeight: 600
                implicitHeight: 600
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "green"
                ListView {
                    id: lv
                    layoutDirection: Qt.RightToLeft
                    orientation: ListView.Horizontal
                    anchors.fill: parent
                    clip: true
                    spacing: 20
                    model: 100000
                    delegate: numberDelegate

                }

                Component {
                    id: numberDelegate

                    Rectangle {
                        width: 80
                        height: lv.height
                        color: "red"

                        ColumnLayout {
                            Text {
                                text: "index " + index
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
