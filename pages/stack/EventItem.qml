import QtQuick 2.12
import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.13

import "../../components"
import "../../delegates"
import "../../pages/stack"
import "../../"

Item
{
    visible: BaseProperty.visiblePage(1)
    anchors.topMargin: dp(4)

    onVisibleChanged: if(!visible) stackEvents.pop()

    property alias depthStack: stackEvents.depth
    property alias eventsStack: stackEvents
    //events
    StackView{
        id: stackEvents
        width: parent.width
        height: parent.height
        visible: true
        focus: true
        initialItem: Rectangle{
            id: eventRoot
            width: parent.width
            height: parent.height
            color: BaseProperty.backgroundColor

            property var allEvents: []

            ListModel{
                id: listModelDate
                
                Component.onCompleted:{
                    var now = new Date()
                    var getDateArray = function(start) {
                        var arr = new Array;
                        var dt = new Date(start);
                        for(var i = 0; i < 7; i++) {
                            arr.push(new Date(dt));
                            dt.setDate(dt.getDate() + 1);
                        }
                        return arr;
                    }
                    
                    var weekday = new Array(7);
                    weekday[0] = qsTr("Sun");
                    weekday[1] = qsTr("Mon");
                    weekday[2] = qsTr("Tue");
                    weekday[3] = qsTr("Wed");
                    weekday[4] = qsTr("Thu");
                    weekday[5] = qsTr("Fri");
                    weekday[6] = qsTr("Sat");
                    
                    var dateArr = getDateArray(now);
                    for (var item in dateArr){
                        append( { date:      dateArr[item].getDate(),
                                  day:       weekday[dateArr[item].getDay()],
                                  month:     ("0" + (dateArr[item].getMonth() +1)).slice(-2),
                                  year:      (dateArr[item].getYear() -100),
                                  date:      ("0" + dateArr[item].getDate()).slice(-2),
                                  full_year: ((dateArr[item].getYear() -100) + 2000)
                               } )
                    }
                }
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.leftMargin: dp(5)
                anchors.rightMargin: dp(5)

                Rectangle {
                    id: filterRect
                    Layout.fillWidth: true
                    Layout.preferredHeight: filterColumn.implicitHeight //visible ? filterColumn.height : 0
                    color: BaseProperty.backgroundDelegateColor

                    ColumnLayout {
                        id: filterColumn
                        anchors.fill: parent

                        ListView{
                            id: listDates
                            Layout.fillWidth: true
                            Layout.preferredHeight: ((listDates.width - 6*(dp(4))) / 7) * 1.75
                            orientation: ListView.Horizontal
                            interactive: false
                            model: listModelDate
                            property string formatDate: ""
                            spacing: dp(4)
                            currentIndex: -1
                            delegate: Item{
                                width: (listDates.width - 6*(dp(4))) / 7
                                height: width * 1.75
                                DropShadow {
                                    anchors.fill: rect
                                    horizontalOffset: 1
                                    verticalOffset: 2
                                    radius: 8.0
                                    samples: 17
                                    color: BaseProperty.red_line_color
                                    visible: listDates.currentIndex === index
                                    source: rect
                                }

                                Rectangle{
                                    id: rect
                                    anchors.fill: parent
                                    color: BaseProperty.backgroundDelegateColor
                                    radius: width /4
                                    border.color: index === listDates.currentIndex ? BaseProperty.red_line_color
                                                                                   : BaseProperty.color_button_shadow

                                    border.width: index === listDates.currentIndex ? dp(2) : dp(1)

                                    Column{
                                        anchors.fill: parent
                                        Text{
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            height: parent.height /2
                                            text: day
                                            font.family: BaseProperty.fontLoader.name
                                            font.pixelSize: app.sp(BaseProperty.h1)
                                            color: BaseProperty.text_color
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }

                                        Text{
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            height: parent.height /2
                                            text: qsTr("%1/%2").arg(date).arg(month)
                                            font.family: BaseProperty.fontLoader.name
                                            font.pixelSize: app.sp(BaseProperty.h1)
                                            color: BaseProperty.red_line_color
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }

                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:
                                    {
                                        if(listDates.currentIndex === index) {
                                           listDates.currentIndex = -1
                                           listDates.formatDate = ""
                                           return
                                        }
                                        //2021-04-23T16:00:00
                                        listDates.formatDate = qsTr("start_data_event=%1-%2-%3T00:00:00Z").arg(full_year).arg(month).arg(date)
                                        console.log(listDates.formatDate)
                                        listDates.currentIndex = index
                                    }
                                }

                            }

                            function widthDelegateItem(){
                                return (listDates.width + (6 * dp(2))) / 7
                            }
                        }

                        Finder{
                            id: finder;
                            Layout.fillWidth: true
//                            Layout.preferredHeight: dp(20)
                        }

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        AppButton {
                            text: qsTr("Filter")
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredWidth: dp(50)
                            Layout.preferredHeight: dp(20)
                            flat: true

                            onClicked: {
                                console.log("pressed apply", filterColumn.height, filterColumn.implicitHeight)
                                eventRoot.updateModelData()
                            }
                        }
                    }


                    Behavior on Layout.preferredHeight { NumberAnimation { duration: 400; easing.type: Easing.InOutQuad; } }
                }

                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth:  true

                    Image {
                        id: updateIcon
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "qrc:/img/svg/rotate.svg"
                        width: dp(20)
                        height: width
                        opacity: Math.abs(listEvents.contentY)/BaseProperty.minContentYForStartUpdatePositive
                        antialiasing: true
                        mirror: true
                        visible: listEvents.contentY < 0
                        NumberAnimation on rotation {
                            id: rotationAnimation
                            from: 0;
                            to: 360;
                            duration: 2000;
                            loops: Animation.Infinite;
                            running: updateIcon.opacity >= 0.8
                        }
                    }

                    ListView{
                        id: listEvents
                        anchors.fill: parent
                        clip: true
                        spacing: dp(1)
                        model: eventRoot.allEvents

                        property bool isPressed: false

                        onContentYChanged: {
                            if(contentY>=0)
                                rotationAnimation.stop()
                        }

                        Timer {
                            id: updateTimer
                            repeat: false
                            running: parent.contentY < BaseProperty.minContentYForStartUpdate
                            interval: 500
                            onTriggered: {
                                console.log("triggered")
                                eventRoot.updateModelData()
                                stop()
                            }
                        }

                        delegate: Rectangle {
                            width: parent.width
                            height: BaseProperty.heightEventDelegate
                            color:  BaseProperty.backgroundDelegateColor

                            property var eventObject: modelData

                            //                    signal relesed()

                            ColumnLayout {
                                id: cl
                                anchors.fill: parent
                                anchors.topMargin: dp(5)
                                anchors.leftMargin: dp(15)
                                anchors.rightMargin: dp(15)
                                spacing: 0

                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true

                                    color: "black"
                                    radius: dp(5)
                                    antialiasing: true
                                    layer.enabled: true
                                    layer.effect: DropShadow {
                                        transparentBorder: true
                                        horizontalOffset: 0
                                        verticalOffset: 0
                                        spread: 0
                                        radius: 6
                                        color: BaseProperty.colorDropShadow
                                    }

                                    Image {
                                        anchors.fill: parent
                                        source: "qrc:/img/close_icon.png"
                                    }
                                }

                                RowLayout {
                                    Layout.maximumHeight: BaseProperty.heightDelegate *0.75
                                    Layout.fillWidth: true
                                    Text {
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        text: eventObject.title_event
                                        verticalAlignment: Text.AlignVCenter
                                        color: BaseProperty.text_color
                                        font.family: BaseProperty.fontLoader.name
                                        font.pixelSize: BaseProperty.h2
                                    }

                                    Text {
                                        Layout.minimumWidth: 30
                                        Layout.fillHeight: true
                                        text: Qt.formatDateTime(eventObject.start_data_event, BaseProperty.formatDateTimeEvent)
                                        verticalAlignment: Text.AlignVCenter
                                        color: BaseProperty.red_text_color
                                        font.family: BaseProperty.fontLoader.name
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: BaseProperty.h2
                                    }
                                }

                                RowLayout {
                                    Layout.maximumHeight: BaseProperty.heightDelegate *0.75
                                    Layout.fillWidth: true
                                    Text {
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        text: eventObject.location_address
                                        verticalAlignment: Text.AlignVCenter
                                        color: BaseProperty.text_color
                                        font.family: BaseProperty.fontLoader.name
                                        font.pixelSize: BaseProperty.h2
                                    }

                                    Text {
                                        Layout.minimumWidth: 30
                                        Layout.fillHeight: true
                                        text: qsTr("%1 %2").arg(eventObject.cost_event).arg(eventObject.name_currency)
                                        verticalAlignment: Text.AlignVCenter
                                        color: BaseProperty.red_text_color
                                        font.family: BaseProperty.fontLoader.name
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: BaseProperty.h2
                                    }
                                }
                            }


                            //                    MouseArea{
                            //                        anchors.fill: parent
                            //                        hoverEnabled: true
                            //                        onPressed: parent.color = BaseProperty.pressed_color
                            //                        onCanceled: parent.color = BaseProperty.backgroundDelegateColor
                            //                        onExited: parent.color = BaseProperty.backgroundDelegateColor
                            //                        onReleased: {
                            //                            parent.color = BaseProperty.backgroundDelegateColor
                            //                            relesed()
                            //                        }
                            //                    }
                        }
                    }

                }
            }

            Component.onCompleted: {
                updateModelData()
            }

            function updateModelData() {
                let mainUrl = "https://dev-cicerone.herokuapp.com/api/v1/catalog/event/?"
                if(finder.text.length !== 0) {
                    mainUrl += qsTr("search=%1").arg(finder.text)
                }

                if(listDates.formatDate.length != 0) {
                    mainUrl += finder.text.length ? "&" : ""
                    mainUrl += listDates.formatDate
                }

                console.log(mainUrl)

                request(mainUrl, function(response)
                {
                    console.log("response: ", response.responseText)
                    if(response.status === 200) {
                        console.log("Response: ", response.responseText)
                        allEvents = JSON.parse(response.responseText)
                        console.log("Print: ", allEvents)
                    }
                }
                )
            }

            function request(url, callback) {
                var request = new XMLHttpRequest();
                request.onreadystatechange = (function(response) {
                    return function() {
                        if(response.readyState === 4) {
                            callback(response)
                        }
                    }
                })(request)
                request.open("GET", url)
                request.setRequestHeader("Authorization", "Basic " + Qt.btoa("admin:admin"));
                request.setRequestHeader('Content-Type', 'application/json');
                request.send()
            }
        }
    }

    Connections {
        target: topHead
        onFilterPressed: {
            console.log("filterPressed")

            filterRect.visible = !filterRect.visible
            console.log(filterRect.visible)

        }
    }
}
