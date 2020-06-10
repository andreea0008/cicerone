import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.12
import "../../"
import "../../components"

Item {
    anchors.fill: parent
    visible: BaseProperty.visiblePage(4)

    Column{
        anchors.fill: parent
        anchors.leftMargin: dp(15)
        anchors.rightMargin: dp(15)

        Item{
            width: parent.width
            height: BaseProperty.heightDelegate

            Text{
                id: sendData
                height: parent.height
                width: parent.width * 0.75
                anchors.left: parent.left
                text: qsTr("Always send data")
                font.family: BaseProperty.fontLoader.name
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: BaseProperty.h1
                color: BaseProperty.text_color
            }

            CiceroneSwitch {
                checked: CiceroneSettings.isSendData
                onCheckedChanged: CiceroneSettings.setIsSendData(checked)
            }
        }
        Item{
            width: parent.width
            height: BaseProperty.heightDelegate

            Text{
                id: loadData
                height: parent.height
                width: parent.width * 0.75
                anchors.left: parent.left
                text: qsTr("Always check update")
                font.family: BaseProperty.fontLoader.name
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: BaseProperty.h1
                color: BaseProperty.text_color
            }

            CiceroneSwitch { }
        }

        Item{
            width: parent.width
            height: BaseProperty.heightDelegate

            Text{
                id: saveDataOnPhone
                height: parent.height
                width: parent.width * 0.75
                anchors.left: parent.left
                text: qsTr("Offline")
                font.family: BaseProperty.fontLoader.name
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: BaseProperty.h1
                color: BaseProperty.text_color
            }

            CiceroneSwitch { }
        }

        Item{
            width: parent.width
            height: BaseProperty.heightDelegate

            Text{
                id: city
                height: parent.height
                width: parent.width * 0.75
                anchors.left: parent.left
                text: qsTr("City")
                font.family: BaseProperty.fontLoader.name
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: BaseProperty.h1
                color: BaseProperty.text_color
            }

            CiceroneSwitch { }

        }

    }
}
