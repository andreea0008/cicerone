import QtQuick 2.12
import QtQuick.Layouts 1.3
import Felgo 3.0
import QtGraphicalEffects 1.13

import "../components"
import "../"

Item {
    id: delegateEvent
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

            RowLayout {
                Layout.preferredHeight: dp(BaseProperty.heightDelegate *0.75)
                Layout.fillWidth: true
                Layout.leftMargin: dp(5)
                Layout.rightMargin: dp(5)
                spacing: dp(0)

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                AppButton {
                    Layout.fillHeight: true
                    text: qsTr("Buy")
                    iconLeft: IconType.ticket
                    backgroundColor: BaseProperty.backgroundColor
                    borderColor: textColor
                    borderColorPressed: BaseProperty.white
                    flat: false
                    textColor: BaseProperty.red
                    textColorPressed: BaseProperty.white

                    onClicked: {
                        console.log("open url buy ticket")
                    }
                }

                AppButton {
                    Layout.fillHeight: true
                    text: qsTr("More")
                    iconRight: IconType.angledoubleright
                    backgroundColor: BaseProperty.backgroundColor
                    borderColor: textColor
                    borderColorPressed: BaseProperty.white
                    flat: false
                    textColor: BaseProperty.red
                    textColorPressed: BaseProperty.white

                    onClicked: {
                        console.log("show more detail")
                    }
                }
            }
        }
    }
}
