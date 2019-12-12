import QtQuick 2.0
import QtQuick.Layouts 1.3

import "../components"
import "../"
Rectangle {
    id: delegate
    anchors.leftMargin: dp(2)
    anchors.rightMargin: dp(2)
    property int lrMar
    property bool isCheck

    property BaseProperty bp: BaseProperty{}
    
    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onReleased: delegate.state = (delegate.state === "hide") ? "show" : "hide"
    }
    
    Column{
        id: columnInformation
        anchors.fill: parent
        anchors.leftMargin: dp(15)
        anchors.rightMargin: dp(15)
        
        Item{
            anchors.left: parent.left
            anchors.right: parent.right
            height: bp.heightDelegate
            
            
            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height
                text: qsTr(modelData)
                verticalAlignment: Text.AlignVCenter
                color: "white"
                font.family: bp.fontLoader.name
                font.pixelSize: bp.h1
            }
            
            Item{
                anchors.right: parent.right
                height: parent.height
                width: height
                Image{
                    anchors.centerIn: parent
                    width: parent.height * 0.5
                    height: width
                    antialiasing: true
                    source: delegate.isCheck ? "../img/delegate_icons/128x128/favorite_uncheck.png"
                                             : "../img/delegate_icons/128x128/favorite_check.png"
                }
                
                MouseArea{
                    anchors.fill: parent
                    onPressed: delegate.isCheck = !delegate.isCheck
                }
            }
            
            
        }
        Rectangle{
            id: redSpacer
            height: 1
            width: parent.width
            color: bp.red_line_color
        }
        
        ColumnLayout{
            Layout.fillWidth: true
            
            RowLayout{
                Layout.fillWidth: true
                Item{
                    Layout.preferredWidth: columnInformation.width
                    Layout.preferredHeight: location.height
                    
                    InformationItem{
                        id: location
                        anchors.centerIn: parent
                        width: parent.width
                        
                        visible: redSpacer.visible
                        baseProperty: bp
                        type: "location"
                        textInformation: "Грушевсько 25"
                    }
                }
            }
            
            RowLayout{
                Layout.fillWidth: true
                
                InformationItem{
                    Layout.preferredWidth: columnInformation.width/2
                    Layout.preferredHeight: height
                    visible: redSpacer.visible
                    baseProperty: bp
                    type: "call"
                    textInformation: "+ 3 8 097 90 99 299"
                }
                
                InformationItem{
                    Layout.preferredWidth: columnInformation.width/2
                    Layout.preferredHeight: height
                    visible: redSpacer.visible
                    baseProperty: bp
                    type: "facebook"
                    textInformation: "+ 3 8 097 90 99 299"
                }
            }
            
            RowLayout{
                Layout.fillWidth: true
                
                InformationItem{
                    Layout.preferredWidth: columnInformation.width/2
                    Layout.preferredHeight: height
                    visible: redSpacer.visible
                    baseProperty: bp
                    type: "call"
                    textInformation: "+ 3 8 097 90 99 299"
                }
                
                InformationItem{
                    Layout.preferredWidth: columnInformation.width/2
                    Layout.preferredHeight: height
                    visible: redSpacer.visible
                    baseProperty: bp
                    type: "instagram"
                    textInformation: "insta"
                }
            }
            
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
}
