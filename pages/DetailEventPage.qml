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
    property string name_event: "name_event"
    property string address_event: "where_event_will_be"
    property string cost_event: "how_much"
    property string descriptio_event: "description_event"
    property var coordinates: [48.920541, 24.710238]

    property var durationAnimation: [1000, 800]

    backgroundColor: bp.backgroundColor
    ColumnLayout{
        id: column
        anchors.fill: parent
        anchors.leftMargin: bp.margin
        anchors.rightMargin: bp.margin
        spacing: 4
        EventElementInfo {
            Layout.fillWidth: true
            Layout.preferredHeight: bp.heightDelegate
            text_information: name_event
            sourceFile: "qrc:/img/event_red.png"
        }

        EventElementInfo {
            Layout.fillWidth: true
            Layout.preferredHeight: bp.heightDelegate
            text_information: address_event
            sourceFile: "qrc:/img/delegate_icons/location.png"
        }

        EventElementInfo {
            Layout.fillWidth: true
            Layout.preferredHeight: bp.heightDelegate
            text_information: cost_event
            sourceFile: "qrc:/img/delegate_icons/money.png"
        }

        TextEdit{
            Layout.fillWidth: true
            text: descriptio_event
            color: bp.colorTextDelegate
        }

        Item{
            id: spacer
            Layout.fillWidth: true
            Layout.preferredHeight: dp(6)
        }

        AppMap {
            id: map
            width: parent.width
            height: parent.width /2
            center: QtPositioning.coordinate(coordinates[0], coordinates[1])
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

            zoomLevel: 16
            enabled: false

            MapQuickItem{
                coordinate: map.center
                sourceItem: MapPointer {}
            }
        }
    }
}
