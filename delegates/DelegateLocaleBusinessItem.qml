import QtQuick 2.12
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

    property bool locateInFavoriteCategory: false

    signal addToFavoriteList()
    signal removeFromFavoriteList()

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

    ColumnLayout{
        id: columnInformation
        anchors.fill: parent
        anchors.leftMargin: dp(15)
        anchors.rightMargin: dp(15)
        spacing: 0

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: dp(BaseProperty.heightDelegate)
            Layout.maximumHeight: dp(BaseProperty.heightDelegate)

            Text {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                font.family: BaseProperty.fontLoader.name
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: sp(BaseProperty.h1)
                text: companyName
            }

            IconButton {
                icon: locateInFavoriteCategory ? IconType.trasho
                                               : delegate.isFavorite ? IconType.star : IconType.staro
                size: dp(BaseProperty.whIcon)
                color: BaseProperty.red
                onPressed: {
//                    delegate.isFavorite = !delegate.isFavorite
                    locateInFavoriteCategory ? removeFromFavoriteList()
                                             : !delegate.isFavorite ? addToFavoriteList()
                                                                   : removeFromFavoriteList()
                }
            }
        }

        Rectangle{
            id: redSpacer
            Layout.preferredHeight: dp(1)
            Layout.fillWidth: true
            color: BaseProperty.red_line_color
        }

        SwipeView {
            id: swipeViewAddressesAndPhones
            Layout.fillWidth: true
            Layout.preferredHeight: dp(BaseProperty.doubleHeightDelegate)
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
                            height: dp(BaseProperty.heightDelegate)

                            InformationItem{
                                id: location
                                Layout.preferredWidth: columnInformation.width/2
                                Layout.fillHeight: true

                                visible: redSpacer.visible
                                type: "location"
                                latPosition: lat
                                lngPosition: lng
                                textInformation: address_location
                            }

                            ScheduleInformationItem{
                                id: schedule
                                Layout.preferredWidth: columnInformation.width/2
                                Layout.fillHeight: true

                                visible: redSpacer.visible
                                isBreakHourNow: true
                                textInformation: scheduleByCurrentDate
                            }
                        }

                        ListView {
                            id: listPhonesByLocation
                            anchors.left: parent.left
                            anchors.right: parent.right
                            height: dp(BaseProperty.heightDelegate)
                            interactive: false
                            clip: true
                            model: proxyPhoneDataModel
                            spacing: dp(2)
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
            Layout.fillWidth: true
            Layout.preferredHeight: dp(BaseProperty.heightDelegate)

            ListModel { id: socialInformationModel }

            ListView {
                anchors.verticalCenter: parent.verticalCenter
                anchors.fill: parent
                model: socialInformationModel
                interactive: false
                orientation: ListView.Horizontal
                layoutDirection: ListView.RightToLeft
                clip: true
                spacing: dp(BaseProperty.heightDelegate * 0.125)

                delegate: IconButton{
                    size: dp(BaseProperty.whMouseAreaSocial)
                    icon: socialInformationModel.get(index)["icon"]
                    color: BaseProperty.red
                    onPressed: {
                        console.log(link)
                        Qt.openUrlExternally(link)
                    }
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "red"
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
            width: dp(BaseProperty.heigthIndicator)
            height: dp(width)
            radius: dp(width /2)
            color: BaseProperty.red_line_color
            opacity: swipeViewAddressesAndPhones.currentIndex === index ? BaseProperty.opacityActive
                                                                        : BaseProperty.opacityInactive
        }
    }

    states: [
        State {
            name: "hide"
            PropertyChanges { target: delegate; height: dp(BaseProperty.heightDelegate);
                              color: BaseProperty.backgroundDelegateColor }
            
            PropertyChanges { target: redSpacer; visible: false; width: 0 }

            PropertyChanges { target: socialItem; visible: false }

            PropertyChanges { target:  swipeViewAddressesAndPhones; visible: false }

        },
        State {
            name: "show"
            PropertyChanges { target: delegate; height: columnInformation.implicitHeight;
                              color: BaseProperty.pressed_color }
            
            PropertyChanges { target: redSpacer; visible: true; width: columnInformation.width }

            PropertyChanges { target: socialItem; visible: true }

            PropertyChanges { target:  swipeViewAddressesAndPhones; visible: true }
        }
    ]

//    transitions: [
//        Transition {
//            from: "hide"
//            to: "show"
//            NumberAnimation { target: redSpacer; properties: "width" }
//        },
//        Transition {
//            from: "show"
//            to: "hide"
//            NumberAnimation { target: redSpacer; properties: "width" }
//        }
//    ]

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
                                              "icon": IconType.facebooksquare,
                                              "link": facebook
                                          })
        if(instagram.length !== 0)
            socialInformationModel.append({
                                              "name": "social_info",
                                              "icon": IconType.instagram,
                                              "link": instagram
                                          })
        if(www.length !== 0)
            socialInformationModel.append({
                                              "name": "social_info",
                                              "icon": IconType.globe,
                                              "link": www
                                          })
        if(mail.length !== 0)
            socialInformationModel.append({
                                              "name": "social_info",
                                              "icon": IconType.envelopesquare,
                                              "link": mail
                                          })
    }
}
