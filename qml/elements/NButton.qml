import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: _button
    width: _label.contentWidth + 50 < 100 ? 100 : _label.contentWidth + 50
    height: 30
    radius: 5
    color: _mouseArea.containsPress ? "#1D4B8F" : "#1D4B8F"

    property alias text: _label.text
    signal clicked()

    Label {
        id: _label
        width: parent.width
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 14
        color: "#FFFFFF"
    }

    MouseArea {
        id: _mouseArea
        width: parent.width
        height: parent.height
        cursorShape: Qt.PointingHandCursor
        onClicked: _button.clicked()
    }
}
