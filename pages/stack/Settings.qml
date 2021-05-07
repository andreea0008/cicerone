import QtQuick 2.12
import Felgo 3.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import com.cicerone.filterModel 1.0
import "../../"
import "../../components"
import QtPositioning 5.15

ColumnLayout {
    anchors.fill: parent
    visible: BaseProperty.visiblePage(4)

//    Settings{ id: ciceroneSettings }

    RowLayout {
        Layout.fillWidth: true
        Layout.preferredHeight: dp(BaseProperty.heightDelegate)
        Layout.maximumHeight: dp(BaseProperty.heightDelegate)

        Text {
            Layout.fillWidth: true
            Layout.fillHeight: true

            text: qsTr("City")
            font.family: BaseProperty.fontLoader.name
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: sp(BaseProperty.h1)
            color: BaseProperty.text_color
        }

        CiceroneComboBox {
            Layout.fillHeight: true
            Layout.preferredWidth: dp(90 + 20)
            model: ["IF", "LV"]
        }
    }

    Item{
        Layout.fillHeight: true
        Layout.fillWidth: true
    }

//    Column{
//        anchors.fill: parent
//        anchors.leftMargin: dp(15)
//        anchors.rightMargin: dp(15)

//        Item{
//            width: parent.width
//            height: BaseProperty.heightDelegate

//            Text{
//                id: sendData
//                height: parent.height
//                width: parent.width * 0.75
//                anchors.left: parent.left
//                text: qsTr("Always send data")
//                font.family: BaseProperty.fontLoader.name
//                verticalAlignment: Text.AlignVCenter
//                font.pixelSize: sp(BaseProperty.h1)
//                color: BaseProperty.text_color
//            }

//            CiceroneSwitch {
//                checked: Settings.isSendData
//                onCheckedChanged: Settings.setIsSendData(checked)
//            }
//        }
//        Item{
//            width: parent.width
//            height: BaseProperty.heightDelegate

//            Text{
//                id: loadData
//                height: parent.height
//                width: parent.width * 0.75
//                anchors.left: parent.left
//                text: qsTr("Always check update")
//                font.family: BaseProperty.fontLoader.name
//                verticalAlignment: Text.AlignVCenter
//                font.pixelSize: BaseProperty.h1
//                color: BaseProperty.text_color
//            }

//            CiceroneSwitch { }
//        }

//        Item{
//            width: parent.width
//            height: BaseProperty.heightDelegate

//            Text{
//                id: saveDataOnPhone
//                height: parent.height
//                width: parent.width * 0.75
//                anchors.left: parent.left
//                text: qsTr("Offline")
//                font.family: BaseProperty.fontLoader.name
//                verticalAlignment: Text.AlignVCenter
//                font.pixelSize: BaseProperty.h1
//                color: BaseProperty.text_color
//            }

//            CiceroneSwitch { }
//        }

//        Item{
//            width: parent.width
//            height: BaseProperty.heightDelegate

//            Text{
//                id: city
//                height: parent.height
//                width: parent.width * 0.75
//                anchors.left: parent.left
//                text: qsTr("City")
//                font.family: BaseProperty.fontLoader.name
//                verticalAlignment: Text.AlignVCenter
//                font.pixelSize: BaseProperty.h1
//                color: BaseProperty.text_color
//            }

//            CiceroneSwitch { }

//        }

//    }
}
