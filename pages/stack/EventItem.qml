import QtQuick 2.12
import QtQuick.Controls 2.2
import Felgo 3.0
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

    //list model dates
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

            ColumnLayout {
                anchors.fill: parent
                anchors.leftMargin: dp(5)
                anchors.rightMargin: dp(5)

                Rectangle {
                    id: filterRect
                    Layout.fillWidth: true
                    Layout.preferredHeight: filterColumn.implicitHeight //visible ? filterColumn.height : 0
                    color: BaseProperty.backgroundDelegateColor
                    visible: false

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
                                //                                console.log("pressed apply", filterColumn.height, filterColumn.implicitHeight)
                                eventRoot .runUpdatePromiseData()
                            }
                        }
                    }

                    Behavior on Layout.preferredHeight { NumberAnimation { duration: 400; easing.type: Easing.InOutQuad; } }
                }

                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth:  true

                    AppActivityIndicator {
                        id: updateActivityindicator
                        animating: visible
                        visible: listEvents.contentY < dp(20)
                        color: BaseProperty.red
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    ListView{
                        id: listEvents
                        anchors.fill: parent
                        clip: true
                        spacing: dp(1)
                        model: eventRoot.allEvents

                        property bool isPressed: false

                        onContentYChanged: {
                            contentY < -dp(100)
                                    ? updateActivityindicator.startAnimating()
                                    : updateActivityindicator.stopAnimating()
                        }

                        Timer {
                            id: updateTimer
                            repeat: false
                            running: parent.contentY < BaseProperty.minContentYForStartUpdate
                            interval: 500
                            onTriggered: {
                                eventRoot.runUpdatePromiseData()
                                stop()
                            }
                        }

                        delegate: Item {
                            id: delegateEvent
                            width: parent.width
//                            height: cl.implicitHeight + dp(20)

                            property var eventObject: modelData

                            AppPaper {
                                anchors.fill: parent
                                anchors.margins: dp(10)
                                background.color: BaseProperty.backgroundColor
                                background.radius: dp(5)
                                elevated: true
                                shadowColor: BaseProperty.red

                                ColumnLayout {
                                    id: cl
                                    y: dp(5)
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    spacing: dp(5)

                                    onHeightChanged: delegateEvent.height = implicitHeight + dp(20)

                                    Rectangle {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: (width / 16) * 10
                                        color: "black"
                                        radius: dp(5)
                                        antialiasing: true

                                        Image {
                                            anchors.fill: parent
                                            source: "https://dev-cicerone.s3.eu-central-1.amazonaws.com/poster%231.jpg"
                                        }
                                    }

                                    RowLayout {
                                        Layout.preferredHeight: dp(BaseProperty.heightDelegate *0.75)
                                        Layout.fillWidth: true
                                        Layout.leftMargin: dp(5)
                                        Layout.rightMargin: dp(5)

                                        Icon {
                                            icon: IconType.calendar
                                            color: BaseProperty.white
                                        }

                                        Text {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            text: eventObject.title_event
                                            verticalAlignment: Text.AlignVCenter
                                            color: BaseProperty.text_color
                                            font.family: BaseProperty.fontLoader.name
                                            font.pixelSize: app.sp(BaseProperty.h2)
                                        }

                                        Icon {
                                            icon: IconType.clocko
                                            color: BaseProperty.red
                                        }

                                        Text {
                                            Layout.minimumWidth: 30
                                            Layout.fillHeight: true
                                            text: Qt.formatDateTime(eventObject.start_data_event, BaseProperty.formatDateTimeEvent)
                                            verticalAlignment: Text.AlignVCenter
                                            color: BaseProperty.red_text_color
                                            font.family: BaseProperty.fontLoader.name
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: app.sp(BaseProperty.h2)
                                        }
                                    }

                                    RowLayout {
                                        Layout.preferredHeight: dp(BaseProperty.heightDelegate *0.75)
                                        Layout.fillWidth: true
                                        Layout.leftMargin: dp(5)
                                        Layout.rightMargin: dp(5)

                                        Icon {
                                            icon: IconType.mapmarker
                                            color: BaseProperty.white
                                        }

                                        Text {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            text: eventObject.location_address
                                            verticalAlignment: Text.AlignVCenter
                                            color: BaseProperty.text_color
                                            font.family: BaseProperty.fontLoader.name
                                            font.pixelSize: app.sp(BaseProperty.h2)
                                        }

                                        Text {
                                            Layout.minimumWidth: 30
                                            Layout.fillHeight: true
                                            text: qsTr("%1 %2").arg(eventObject.cost_event).arg(eventObject.name_currency)
                                            verticalAlignment: Text.AlignVCenter
                                            color: BaseProperty.red_text_color
                                            font.family: BaseProperty.fontLoader.name
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: app.sp(BaseProperty.h2)
                                        }
                                    }

                                }
                            }
                        }
                    }

                }
            }

            Component.onCompleted: {
                runUpdatePromiseData()
            }

            function runUpdatePromiseData() {
                let mainUrl = "https://dev-cicerone.herokuapp.com/api/v1/catalog/event/?ordering=-rating&"
                if(finder.text.length !== 0) {
                    mainUrl += qsTr("search=%1").arg(finder.text)
                }

                if(listDates.formatDate.length != 0) {
                    mainUrl += finder.text.length ? "&" : ""
                    mainUrl += listDates.formatDate
                }

                console.log(mainUrl)

                var p = Promise.create(function(resolve, reject) {
                    // handle asynchronous code here
                    // e.g. with asynchronous HttpRequest
                    HttpRequest
                    .get(mainUrl)
                    .timeout(5000)
                    .end(function (err, res) {
                        if(res.ok)
                            resolve(res.body)
                        else
                            reject(err.message)
                    })
                });

                // execute promise and handle result
                p.then(function(value) {
                    // success
                    console.log("Value: "+JSON.stringify(value))
                    allEvents = value
                }).catch(function(reason) {
                    // failure
                    console.log("Error: "+reason)
                });
            }
        }

    }
    Connections {
        target: topHead
        onFilterPressed: {
            console.log("filterPressed")
            filterRect.visible = !filterRect.visible
        }
    }
}
