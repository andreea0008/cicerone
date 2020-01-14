import QtQuick.Controls 2.2
import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.13

import "../../components"
import "../../delegates"
import "../../pages/stack"

Item
{
    visible: bp.visiblePage(1)
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
            width: parent.width
            height: parent.height
            color: bp.backgroundColor
            
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
                    weekday[0] = "Sun";
                    weekday[1] = "Mon";
                    weekday[2] = "Tue";
                    weekday[3] = "Wed";
                    weekday[4] = "Thu";
                    weekday[5] = "Fri";
                    weekday[6] = "Sat";
                    
                    var dateArr = getDateArray(now);
                    for (var item in dateArr){
                        console.log(dateArr[item].getDay())
                        append( { date: dateArr[item].getDate(), day: weekday[dateArr[item].getDay()] })
                    }
                }
            }
            
            ListView{
                id: listDates
                width: parent.width
                height: dp(72)
                orientation: ListView.Horizontal
                interactive: false
                model: listModelDate
                
                signal newDate(var date)
                
                delegate: Item{
                    width: dp(56)
                    height: dp(70)
                    DropShadow {
                        anchors.fill: rect
                        horizontalOffset: 1
                        verticalOffset: 2
                        radius: 8.0
                        samples: 17
                        color: bp.red_line_color
                        visible: listDates.currentIndex === index
                        source: rect
                    }
                    
                    Rectangle{
                        id: rect
                        anchors.fill: parent
                        anchors.leftMargin: dp(4)
                        anchors.rightMargin: dp(4)
                        color: bp.backgroundDelegateColor
                        radius: width /4
                        border.color: bp.red_line_color
                        border.width: index === listDates.currentIndex ? dp(1) : dp(0)
                        
                        Column{
                            anchors.fill: parent
                            Text{
                                anchors.left: parent.left
                                anchors.right: parent.right
                                height: parent.height /2
                                text: day
                                font.family: bp.fontLoader.name
                                font.pixelSize: bp.h1
                                color: bp.text_color
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            Text{
                                anchors.left: parent.left
                                anchors.right: parent.right
                                height: parent.height /2
                                text: date
                                font.family: bp.fontLoader.name
                                font.pixelSize: bp.h1
                                
                                color: bp.red_line_color
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                        
                    }
                    
                    MouseArea{
                        anchors.fill: parent
                        onClicked: listDates.currentIndex = index
                    }
                    
                }
                
                function widthDelegateItem(){
                    return (listDates.width + (6 * dp(2))) / 7
                }
            }
            
            ListView{
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: listDates.bottom
                anchors.bottom: parent.bottom
                clip: true
                spacing: dp(1)
                model: ['Кафе', 'Ресторани', 'Кафе', 'Ресторани', 'Кафе', 'Ресторани']
                delegate: DelegateCompany {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: dp(1)
                    anchors.rightMargin: dp(1)
                    text: modelData
                    onRelesed: stackEvents.push("../EventsPage.qml")
                }
            }
        }
    }
}
