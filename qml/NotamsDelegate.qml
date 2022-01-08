import QtQuick 2.15
import QtQuick.Controls 2.15


Item {
    id: _delegate
    width: ListView.view.width
    height: 80
    clip: true

    property string notamsId: "1"
    property string startDate
    property string endDate
    property string createDate
    property string text
    property int flStart
    property int flEnd
    property var points
    property int durationSeconds
    property string durationHumon

    signal clicked()

    Column {
        width: parent.width
        spacing: 7
        Label {
            text: qsTr("id: %1").arg(_delegate.notamsId)
        }
        Row {
            spacing: 15
            Label {
                text: qsTr("fl: %1 - %2").arg(_delegate.flStart).arg(_delegate.flEnd)
            }
            Label {
                text: qsTr("duration: %1").arg(_delegate.durationHumon)
            }
        }
        Label {
            width: parent.width
            height: 40
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
            text: _delegate.text
        }
    }

//    Label {
//        text: new Date(_delegate.createDate).toLocaleString(Qt.locale(), "dd-MM-yyyy")
//    }

    Rectangle {
        width: parent.width
        height: parent.height
        visible: _mouseArea.containsMouse
        color: _mouseArea.containsPress ? "#A0C4C4C4" : "#80C4C4C4"
    }

    MouseArea {
        id: _mouseArea
        width: parent.width
        height: parent.height
        hoverEnabled: true
        onClicked: _delegate.clicked()
    }
}
