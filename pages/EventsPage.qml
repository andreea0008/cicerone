import QtQuick 2.12
import QtQuick.Layouts 1.3
import "../delegates"
import "../components"
import "../"

Item{
    id: eventPage
    Finder{ id: finder }

    ListView{
        id: list
        width: parent.width
        anchors.top: finder.bottom
        anchors.bottom: parent.bottom
        spacing: dp(1)
        clip: true
        model: Events
        antialiasing: true
        delegate: DelegateEvent {
            id: delegate
            anchors.left: parent.left
            anchors.right: parent.right
            color: BaseProperty.backgroundDelegateColor
            height: BaseProperty.heightDelegate
            state: "hide"
            eventTitle: title
            descriptionEvent: description
        }
    }
}
