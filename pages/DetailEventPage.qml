import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick 2.13
import Felgo 3.0
import QtLocation 5.5
import QtPositioning 5.12
import QtQuick.Layouts 1.3
import "../components"

// FlickablePage already contains an AppFlickable and ScrollIndicator
FlickablePage {
    id: page
    visible: true
    // you can configure the internal flickable with the "flickable" property of the page
    flickable.contentWidth: parent.width
    flickable.contentHeight: column.height
    property real c1: 48.920541
    property real c2: 24.710238

    property var durationAnimation: [1000, 800]

    backgroundColor: bp.backgroundColor
    ColumnLayout{
        id: column
        anchors.fill: parent
        anchors.leftMargin: bp.margin
        anchors.rightMargin: bp.margin
        spacing: 0

        Text {
            id: name
            Layout.fillWidth: true
            Layout.preferredHeight: bp.heightDelegate
            text: qsTr("Name")
            verticalAlignment: Text.AlignVCenter
            color: bp.colorTextDelegate
        }

        Text {
            id: where
            Layout.fillWidth: true
            Layout.preferredHeight: bp.heightDelegate
            text: qsTr("Address")
            verticalAlignment: Text.AlignVCenter
            color: bp.colorTextDelegate
        }

        TextEdit{
            Layout.fillWidth: true
            text: "ikdc\ni\nem\ncie\nm\nc\ne\nc]n"
            color: bp.colorTextDelegate
        }

        AppMap {
            width: parent.width
            height: parent.width /2
            center: QtPositioning.coordinate(c1, c2)
            plugin: Plugin {
                name: "mapbox"
                // configure your own map_id and access_token here
                parameters: [
                    PluginParameter {
                        name: "mapbox.access_token"
                        value: "pk.eyJ1IjoiYW5kcmVlYTAwMDgiLCJhIjoiY2pyZmY2cGs3MHVwajQ0b2d1Zm1tOGlmaCJ9.L0LWSDFpT7nbpsHGIptERw"
                    },
                    PluginParameter {
                        name: "mapbox.mapping.highdpi_tiles"
                        value: true
                    },
                    PluginParameter {
                        name: "mapbox.mapping.map_id"
                        value: "mapbox.streets"
                    },
                    PluginParameter{
                        name: "mapboxgl.mapping.additional_style_urls";
                        value: "mapbox://styles/mapbox/dark-v10";
                    }
                ]
            }

            activeMapType: supportedMapTypes[3]

            Component.onCompleted: console.log(supportedMapTypes.length)
            zoomLevel: 16
            enabled: false

            ListModel
            {
                id: model
                ListElement{
                    latitude: 48.920541
                    longitude: 24.710238
                }
            }

            MapItemView {
                model: model

                delegate: MapQuickItem {
                    coordinate: QtPositioning.coordinate(latitude, longitude)

                    //                    anchorPoint.x: image.width * 0.5
                    //                    anchorPoint.y: image.height

                    sourceItem: MapPointer {
                    }
                }
            }
        }
    }
}
