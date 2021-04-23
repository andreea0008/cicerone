import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Felgo 3.0
import com.cicerone.filterModel 1.0
import "../components"
import "../"

Rectangle {
    id: delegate
    anchors.leftMargin: dp(2)
    anchors.rightMargin: dp(2)
    property int lrMar
    property bool isFavorite
    property string companyName
    property var address
    property string facebook
    property string instagram
    property string www
    property string mail

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onReleased: delegate.state = (delegate.state === "hide") ? "show" : "hide"
    }

    Component.onCompleted: {
        parseLocationData()
        fillInSocial()
    }

    signal pressedFavorite()
    state: "hide"

    ListModel { id: locationData }

    ListModel { id: phonesData }

    ListModel { id: weekSchedule }

    SortFilterProxyModel{
        id: proxyPhoneDataModel
        sourceModel: phonesData
        filters: [
            ValueFilter {
            roleName: "start_index"
            value: swipeViewAddressesAndPhones.currentIndex
            enabled: swipeViewAddressesAndPhones.currentIndex > 0
        }
        ]
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
            height: BaseProperty.heightDelegate


            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                color: "white"
                font.family: BaseProperty.fontLoader.name
                font.pixelSize: BaseProperty.h1
                text: companyName
            }

            MouseArea{
                anchors.right: parent.right
                height: parent.height
                width: height
                onPressed: {
                    delegate.isFavorite = !delegate.isFavorite
                    pressedFavorite()
                }
                Image{
                    anchors.centerIn: parent
                    width: BaseProperty.whIcon
                    height: BaseProperty.whIcon
                    antialiasing: true
                    source: delegate.isFavorite ? "../img/delegate_icons/128x128/favorite_check.png"
                                                : "../img/delegate_icons/128x128/favorite_uncheck.png"
                }
            }

            MouseArea{
                anchors.right: parent.right
                anchors.rightMargin: 40
                height: parent.height
                width: height
                onPressed: {
                    showEvent()
                }
                Image{
                    anchors.centerIn: parent
                    width: BaseProperty.whIcon
                    height: BaseProperty.whIcon
                    antialiasing: true
                    source: "../img/delegate_icons/128x128/favorite_check.png"
                }
            }
        }

        Rectangle{
            id: redSpacer
            height: 1
            width: parent.width
            color: BaseProperty.red_line_color
        }

        SwipeView {
            id: swipeViewAddressesAndPhones
            width: parent.width
            height: 2 * BaseProperty.heightDelegate
            clip: true

            Repeater{
                model: locationData
                Loader {
                    id: loader
                    active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                    sourceComponent: Column{
                        id: locationColumnComponent
                        width: delegate.width
                        height: swipeViewAddressesAndPhones.height

                        RowLayout{
                            anchors.left: parent.left
                            anchors.right: parent.right
                            height: BaseProperty.heightDelegate

                            InformationItem{
                                id: location
                                Layout.preferredWidth: columnInformation.width/2
                                Layout.preferredHeight: height

                                visible: redSpacer.visible
                                type: "location"
                                latPosition: lat
                                lngPosition: lng
                                textInformation: address_location
                            }

                            ScheduleInformationItem{
                                id: schedule
                                Layout.preferredWidth: columnInformation.width/2
                                Layout.preferredHeight: height

                                visible: redSpacer.visible
                                isBreakHourNow: true
                                textInformation: scheduleByCurrentDate
                            }
                        }

                        ListView {
                            id: listPhonesByLocation
                            anchors.left: parent.left
                            anchors.right: parent.right
                            height: BaseProperty.heightDelegate
                            interactive: false
                            clip: true
                            model: proxyPhoneDataModel
                            spacing: 2
                            orientation: ListView.Horizontal
                            delegate: InformationItem{
                                width: columnInformation.width /2
                                height: BaseProperty.heightDelegate
                                type: "call"
                                textInformation: phone
                            }
                        }
                    }
                }
            }
        }

        Item{
            id: socialItem
            anchors.left: parent.left
            anchors.right: parent.right
            height: BaseProperty.heightDelegate

            ListModel { id: socialInformationModel }

            ListView {
                anchors.verticalCenter: parent.verticalCenter
                anchors.topMargin: BaseProperty.heightDelegate * 0.125
                width: parent.width
                height: BaseProperty.heightDelegate * 0.75
                model: socialInformationModel
                interactive: false
                orientation: ListView.Horizontal
                layoutDirection: ListView.RightToLeft
                clip: true
                spacing: BaseProperty.heightDelegate * 0.125

                delegate: MouseArea{
                    height: BaseProperty.whMouseAreaSocial
                    width: BaseProperty.whMouseAreaSocial

                    Image{
                        width: BaseProperty.whIcon
                        height: BaseProperty.whIcon
                        source: icon
                        antialiasing: true
                    }

                    onPressed: {
                        console.log(link)
                            Qt.openUrlExternally(link)
                    }
                }
            }
        }
    }

    PageIndicator {
        id: indicator

        count: swipeViewAddressesAndPhones.count
        currentIndex: swipeViewAddressesAndPhones.currentIndex
        visible: count > 1
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        delegate: Rectangle{
            width: BaseProperty.heigthIndicator
            height: width
            radius: width /2
            color: BaseProperty.red_line_color
            opacity: swipeViewAddressesAndPhones.currentIndex === index ? BaseProperty.opacityActive
                                                                        : BaseProperty.opacityInactive
        }
    }

    states: [
        State {
            name: "hide"
            PropertyChanges { target: delegate; height: BaseProperty.heightDelegate;
                              color: BaseProperty.backgroundDelegateColor }
            
            PropertyChanges { target: redSpacer; visible: false; width: 0 }

            PropertyChanges { target: socialItem; visible: false }

            PropertyChanges { target:  swipeViewAddressesAndPhones; visible: false }

        },
        State {
            name: "show"
            PropertyChanges { target: delegate; height: BaseProperty.heightDelegate * 4.2;
                              color: BaseProperty.pressed_color }
            
            PropertyChanges { target: redSpacer; visible: true; width: columnInformation.width }

            PropertyChanges { target: socialItem; visible: true }

            PropertyChanges { target:  swipeViewAddressesAndPhones; visible: true }
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
        let startIndex = 0

        for (var prop in address)
        {
            var lat = address[prop]["lat"]
            var lng = address[prop]["lng"]
            var phones = address[prop]["phone"]
            var locationAddress = address[prop]["address"]
            var schedule_cy_current_date = address[prop]["schedule_cy_current_date"]
            var isNowBreakHour = address[prop]["schedule_is_now_break"]
            locationData.append(
                        {
                            "lat": lat,
                            "lng": lng,
                            "address_location": locationAddress,
                            "phones": phones,
                            "scheduleByCurrentDate": schedule_cy_current_date,
                            "isNowBreakHour": isNowBreakHour
                        }
                        )
            for( var phone in phones)
            {
                var data = {"phone" : phones[phone], "start_index": startIndex}
                phonesData.append( data )
            }

            startIndex++
        }
    }

    function fillInSocial(){
        if(facebook.length !== 0)
            socialInformationModel.append({
                                              "name": "social_info",
                                              "icon": "qrc:/img/delegate_icons/facebook.png",
                                              "link": facebook
                                          })
        if(instagram.length !== 0)
            socialInformationModel.append({
                                              "name": "social_info",
                                              "icon": "qrc:/img/delegate_icons/instagram.png",
                                              "link": instagram
                                          })
        if(www.length !== 0)
            socialInformationModel.append({
                                              "name": "social_info",
                                              "icon": "qrc:/img/delegate_icons/www.png",
                                              "link": www
                                          })
        if(mail.length !== 0)
            socialInformationModel.append({
                                              "name": "social_info",
                                              "icon": "qrc:/img/delegate_icons/mail.png",
                                              "link": mail
                                          })
    }
}
