import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Felgo 3.0
import "../components"
import "../"
import com.cicerone.filterModel 1.0

Rectangle {
    id: delegate
    anchors.leftMargin: dp(2)
    anchors.rightMargin: dp(2)
    property int lrMar
    property bool isFavorite
    property string companyName
    property var address
    property string scheduleByCurrentDate
    property string facebook: ""
    property string instagramm: ""

    state: "hide"
    property BaseProperty bp: BaseProperty{}

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onReleased: delegate.state = (delegate.state === "hide") ? "show" : "hide"
    }

    Component.onCompleted: parseLocationData()

    ListModel { id: locationData }
    ListModel { id: phonesData }

    SortFilterProxyModel{
        id: proxyPhoneDataModel
        sourceModel: phonesData
        filters: ValueFilter {
            id: valuefilter
            roleName: "index"
            value: swipeViewAddressesAndPhones.currentIndex
        }
    }

    Column{
        id: columnInformation
        anchors.fill: parent
        anchors.leftMargin: dp(15)
        anchors.rightMargin: dp(15)
        visible: true

        Item{
            anchors.left: parent.left
            anchors.right: parent.right
            height: bp.heightDelegate


            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                color: "white"
                font.family: bp.fontLoader.name
                font.pixelSize: bp.h1
                text: companyName
            }

            MouseArea{
                anchors.right: parent.right
                height: parent.height
                width: height
                onPressed: {
                    delegate.isFavorite = !delegate.isFavorite
                }
                Image{
                    anchors.centerIn: parent
                    width: parent.height * 0.5
                    height: width
                    antialiasing: true
                    source: delegate.isFavorite ? "../img/delegate_icons/128x128/favorite_check.png"
                                                : "../img/delegate_icons/128x128/favorite_uncheck.png"
                }
            }
        }

        Rectangle{
            id: redSpacer
            height: 1
            width: parent.width
            color: bp.red_line_color
        }

        SwipeView {
            id: swipeViewAddressesAndPhones
            width: parent.width

            height: (locationData.count +1) * bp.heightDelegate
            clip: true

            Repeater{
                model: locationData
                Loader {
                    active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                    sourceComponent: Column{
                        id: locationColumnComponent
                        width: delegate.width
                        height: delegate.height * 2

                        RowLayout{
                            Layout.fillWidth: true

                            InformationItem{
                                id: location
                                Layout.preferredWidth: columnInformation.width/2
                                Layout.preferredHeight: height

                                visible: redSpacer.visible
                                baseProperty: bp
                                type: "location"
                                textInformation: address_location
                            }

                            InformationItem{
                                id: schedule
                                Layout.preferredWidth: columnInformation.width/2
                                Layout.preferredHeight: height

                                visible: redSpacer.visible
                                baseProperty: bp
                                type: "schedule"
                                textInformation: scheduleByCurrentDate
                            }
                        }

                        ListView {
                            id: listPhonesByLocation
                            anchors.left: parent.left
                            anchors.right: parent.right
                            height: model.count * bp.heightDelegate
                            visible: redSpacer.visible
                            interactive: false
                            clip: true
                            model: proxyPhoneDataModel
                            orientation: ListView.Horizontal
                            delegate: InformationItem{
                                width: columnInformation.width /2
                                height: bp.heightDelegate
                                baseProperty: bp
                                type: "call"
                                textInformation: phone
                            }
                        }
                    }
                }
            }
        }
    }

    PageIndicator {
        id: indicator

        count: swipeViewAddressesAndPhones.count
        currentIndex: swipeViewAddressesAndPhones.currentIndex
        //        visible: count > 1
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        delegate: Rectangle{
            width: bp.heightDelegate /8
            height: width
            radius: width /2
            color: bp.red_line_color
            opacity: swipeViewAddressesAndPhones.currentIndex === index ? 1.0 : 0.4
        }
    }

    states: [
        State {
            name: "hide"
            PropertyChanges {
                target: delegate
                height: bp.heightDelegate
                color: bp.backgroundDelegateColor
            }
            
            PropertyChanges {
                target: redSpacer
                visible: false
                width: 0
            }
        },
        State {
            name: "show"
            PropertyChanges {
                target: delegate
                height: bp.heightDelegate *4.2
                color: bp.pressed_color
            }
            
            PropertyChanges {
                target: redSpacer
                visible: true
                width: columnInformation.width
            }
        }
    ]

    transitions: [
        Transition {
            from: "hide"
            to: "show"
            NumberAnimation { target: redSpacer; properties: "width" }
        },
        Transition {
            from: "show"
            to: "hide"
            NumberAnimation { target: redSpacer; properties: "width" }
        }
    ]

    function parseLocationData(){
        var startIndex = 0
        for (var prop in address)
        {
            var lat = address[prop]["lat"]
            var lng = address[prop]["lng"]
            var phones = address[prop]["phone"]
            var locationAddress = address[prop]["address"]
            locationData.append(
                        {
                            "lat": lat,
                            "lng": lng,
                            "address_location": locationAddress,
                            "phones": phones
                        }
                        )
            for( var phone in phones)
            {
                phonesData.append( {"phone" : phones[phone], "index": startIndex} )
            }
            startIndex++
        }
    }
}
