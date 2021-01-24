// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtMultimedia 5.15

import VideoLib 1.0

import "../common"
import "../popups"

Flickable {
    id: flickable
    contentHeight: root.implicitHeight
    // StackView manages this, so please no anchors here
    // anchors.fill: parent
    property string name: "Home"

    Pane {
        id: root
        anchors.fill: parent
        ColumnLayout {
            anchors.right: parent.right
            anchors.left: parent.left
            LabelHeadline {
                leftPadding: 10
                bottomPadding: 16
                text: qsTr("The Home Page")
            }

            CameraFilter {
                id: cameraFilter
            }

            VideoRenderer {
                id: videoRenderer
            }

            Rectangle {
                color: "green"
//                implicitWidth: 640
                implicitHeight: 320
                Layout.fillWidth: true
                Layout.fillHeight: true
                VideoOutput {
                    anchors.fill: parent
                    fillMode: VideoOutput.PreserveAspectFit //Stretch //PreserveAspectCrop //PreserveAspectFit
                    source: videoRenderer
                }
            }

            Rectangle {
                color: "red"
//                implicitWidth: 640
                implicitHeight: 320
                Layout.fillWidth: true
                Layout.fillHeight: true
                VideoOutput {
                    id: cameraView
                    anchors.fill: parent
                    fillMode: VideoOutput.PreserveAspectFit //Stretch //PreserveAspectCrop //PreserveAspectFit
//                    orientation: 90
                    autoOrientation: true
                    filters: [cameraFilter]
                    source: camera
                    Camera {
                        id: camera
                        captureMode: Camera.CaptureVideo
                    }
                }
                Component.onCompleted: {

                }
            }

            RowLayout {
                IconInactive {
                    imageName: modelData.icon
                    imageSize: 48
                }
                LabelSubheading {
                    leftPadding: 10
                    rightPadding: 10
                    wrapMode: Text.WordWrap
                    text: qsTr("This Page is on a StackView - want to push another Page on top ?\nTap on the 'Qt' Logo")                }
                Item {
                    implicitWidth: 96
                    implicitHeight: 96
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
            }

            HorizontalDivider {}
            RowLayout {
                LabelSubheading {
                    topPadding: 6
                    leftPadding: 10
                    rightPadding: 10
                    wrapMode: Text.WordWrap
                    text: qsTr("Example APP demonstrating Qt Quick Controls 2\n\n")
                }
            }
            RowLayout {
                LabelSubheading {
                    topPadding: 6
                    leftPadding: 10
                    rightPadding: 10
                    wrapMode: Text.WordWrap
                    text: qsTr("Home Page is a StackView.\nNavigation Drawer can be opened swiping from left or tapping on Menu Button.\nHome Page is marked as Favority, so you can also navigate from Bottom (in Portrait Mode)\n")
                }
            }
            RowLayout {
                LabelBodySecondary {
                    topPadding: 6
                    leftPadding: 10
                    rightPadding: 10
                    wrapMode: Text.WordWrap
                    text: qsTr("Activation Policy: ")
                }
                LabelBody {
                    topPadding: 6
                    leftPadding: 10
                    rightPadding: 10
                    wrapMode: Text.WordWrap
                    text: qsTr("IMMEDIATELY")
                }
            }
            HorizontalDivider {}

            ButtonFlat {
                enabled: true
                radius: 30
//                Layout.fillWidth: true
//                implicitWidth: 300
//                implicitHeight: 40
                text: qsTr("Modal Popup Test")
                onClicked: {
                    camera.stop()
//                    popupTestModal.open()
                }
            }

            RowLayout {
                ButtonFlat {
                    enabled: true
//                    Layout.fillWidth: true
                    implicitWidth: 300
//                    implicitHeight: 80
                    text: qsTr("Modal Popup Test eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee")
                    onClicked: {
//                        popupTestModal.open()
//                        cameraFilter.setVideoSurface(cameraView.videoSurface)
                        cameraFilter.setVideoRenderer(videoRenderer)
//                        cameraFilter.setCamera(camera)
//                        camera.start()
//                        cameraView.source = camera
                    }
                }

            }

            HorizontalDivider {}
        } // col layout
    } // root
    ScrollIndicator.vertical: ScrollIndicator { }

    PopupTestModal {
        id: popupTestModal
        text: qsTr("While this modal Popup is open:\n\nDrawer should be blocked\nAndroid Back key should be blocked\n\nQt 5.8 problem: Drawer can be dragged below the modal Popup")
    }


    // emitting a Signal could be another option
    Component.onDestruction: {
        cleanup()
    }

    // called immediately after Loader.loaded
    function init() {
        console.log(qsTr("Init done from Home Page"))
    }
    // called from Component.destruction
    function cleanup() {
        console.log(qsTr("Cleanup done from Home Page"))
    }
} // flickable
