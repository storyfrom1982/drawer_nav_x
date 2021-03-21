// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import QtQuick.Controls.Styles 1.4

import "../common"

Flickable {
    id: flickable
    //    contentHeight: root.implicitHeight
    // StackView manages this, so please no anchors here
    anchors.fill: parent
    //    property string name: "FileView"

    Pane {
        id: root
        anchors.fill: parent

        Column {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom


            Rectangle {
                width: parent.width
                height: parent.height * 0.95 / 2
                color: "red"

                GridView {
                    id: gv1
                    property int marginSize: 0
                    property int lineCount: 4
                    property int lineWidth: (parent.width - marginSize * 2) / lineCount

                    anchors.fill: parent
                    anchors.margins: marginSize
                    clip: true
                    model: 100

                    cellWidth: lineWidth
                    cellHeight: lineWidth
                    delegate: numberDelegate
                }

                Component {
                    id: numberDelegate
                    Rectangle {
                        width: gv1.lineWidth
                        height: gv1.lineWidth
//                        color: "blue"
                        Column {
                            anchors.fill: parent
                            spacing: 2
                            Item {
                                anchors.horizontalCenter: parent.horizontalCenter
                                implicitWidth: parent.width / 2
                                implicitHeight: parent.height / 2
                                Image {
                                    // scale: Image.PreserveAspectFit
                                    anchors.fill: parent
                                    // anchors.verticalCenterOffset: -50
                                    fillMode: Image.PreserveAspectFit
                                    source: "qrc:/images/extra/qt-logo.png"
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        navPane.pushQtPage()
                                    }
                                } // mouse
                            }
                            Text {
                                id: doc1
                                width: parent.width - 20
                                height: parent.height / 2
                                wrapMode: Text.WrapAnywhere
                                clip :true
                                elide: Text.ElideRight
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: qsTr("text anchors horizontalCenter parent horizontalCenter")
                            }
                        }
                    }
                }
            }


            Rectangle {
                id: cotl
                width: parent.width
                height: parent.height / 10
                border.color: "green"

                Column {
                    anchors.fill: parent

                    Rectangle {
                        width: parent.width
                        height: parent.height / 2

                        Row {

                            anchors.fill: parent

                            RadioButton{
                                checked: true
                                indicator.width: 15
                                indicator.height: 15
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("拷贝")
                                font.pixelSize: 10
                            }
                            RadioButton{
                                indicator.width: 15
                                indicator.height: 15
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("移动")
                                font.pixelSize: 10
                            }

//                            Rectangle {
//                                Layout.fillWidth: true
//                            }

                            Item {
                                anchors.verticalCenter: parent.verticalCenter
//                                anchors.horizontalCenter: parent.horizontalCenter
                                implicitWidth: parent.height
                                implicitHeight: parent.height
                                Image {
                                    // scale: Image.PreserveAspectFit
                                    anchors.fill: parent
                                    // anchors.verticalCenterOffset: -50
        //                            fillMode: Image.PreserveAspectFit
                                    source: "qrc:/images/extra/qt-logo.png"
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        navPane.pushQtPage()
                                    }
                                } // mouse
                            }

                            CheckBox {
                                indicator.width: 15
                                indicator.height: 15
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("多选")
                                font.pixelSize: 10
                            }

                            CheckBox {
                                indicator.width: 15
                                indicator.height: 15
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("全选")
                                font.pixelSize: 10
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: parent.height / 2
                        ComboBox{
                            id: control
                            implicitWidth: parent.width
                            implicitHeight: parent.height
                            anchors.verticalCenter: parent.verticalCenter

                            delegate: ItemDelegate {
                                width: control.width
                                height: control.height
                                text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
                                font: control.font
                            }
                            popup.y: control.height
                            font.pixelSize: 10
                            model: [qsTr("华为"), qsTr("小米")]
                        }
                    }
                }

            }


            Rectangle {
                width: parent.width
                height: parent.height * 0.95 / 2

                GridView {
                    id: gv2
                    property int lineCount: 4
                    property int lineWidth: parent.width / lineCount


                    anchors.fill: parent
                    anchors.margins: 0
//                    anchors.topMargin: 10
//                    anchors.leftMargin: 10
                    clip: true
                    model: 100
                    cellWidth: lineWidth
                    cellHeight: lineWidth
                    delegate: numberDelegate1
                }

                Component {
                    id: numberDelegate1

                    Column {
                        width: gv2.lineWidth
                        height: gv2.lineWidth
                        spacing: 1
                        Item {
                            anchors.horizontalCenter: parent.horizontalCenter
                            implicitWidth: parent.width / 2
                            implicitHeight: parent.height / 2
                            Image {
                                // scale: Image.PreserveAspectFit
                                anchors.fill: parent
                                // anchors.verticalCenterOffset: -50
                                fillMode: Image.PreserveAspectFit
                                source: "qrc:/images/extra/qt-logo.png"
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    navPane.pushQtPage()
                                }
                            } // mouse
                        }
                        Text {
                            id: doc2
                            width: parent.width - 20
                            height: parent.height / 2
                            wrapMode: Text.WordWrap
                            clip :true
                            elide: Text.ElideRight
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: qsTr("text anchors horizontalCenter parent horizontalCenter")
                        }
                    }
                }
            }
        }

    } // root

    ScrollIndicator.vertical: ScrollIndicator { }

    // emitting a Signal could be another option
    Component.onDestruction: {
        cleanup()
    }

    // called immediately after Loader.loaded
    function init() {
        console.log(qsTr("Init done from QtPage"))
    }
    // called from Component.destruction
    function cleanup() {
        console.log(qsTr("Cleanup done from Qt Page"))
    }
} // flickable
