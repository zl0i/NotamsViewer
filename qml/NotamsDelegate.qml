import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15


Item {
    id: _delegate
    width: ListView.view.width
    height: 80
    clip: true

    property string notamsId
    property string startDate
    property string endDate
    property string createDate
    property string text
    property int flStart
    property int flEnd
    property var points
    property int durationSeconds
    property string durationHumon

    signal more(int index, int y)
    signal clicked(var x, var y)

    function blink() {
        _animation.start()
    }

    SequentialAnimation {
        id: _animation
        PropertyAnimation {
            target: _background
            property: "visible"
            to: true
        }
        PauseAnimation {
            duration: 250
        }
        PropertyAnimation {
            target: _background
            property: "visible"
            to: false
        }
    }

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

    MouseArea {
        x: parent.width - 30
        width: 30
        height: parent.height
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            const point = mapToItem(null, mouseX, mouseY)
            _delegate.more(_delegate.index, point.y)
        }
        Image {
            x: 6; y: parent.height/2 - height/2
            width: 24
            height: 24
            source: "qrc:/icons/arrow-black.svg"
            layer.enabled: parent.containsMouse
            layer.effect: ColorOverlay {
                color: "#1D4B8F"
            }
        }
    }

    Rectangle {
        id: _background
        width: parent.width
        height: parent.height
        visible: _mouseArea.containsMouse
        color: _mouseArea.containsPress ? "#A0C4C4C4" : "#80C4C4C4"
    }

    MouseArea {
        id: _mouseArea
        width: parent.width-30
        height: parent.height
        hoverEnabled: true
        onClicked: {
            if(_delegate.points.length > 0)   {
                _delegate.clicked( _delegate.points[0][0].x, _delegate.points[0][0].y)
            }
        }
    }
}
