import QtQuick 2.15

Rectangle {
    id: _button
    width: 40
    height: 40
    radius: 20
    color: _mouseArea.containsPress ? "#1D4B8F" : "#3471CE"

    property alias image: _image.source
    signal clicked()

    Image {
        id: _image
        x: 7.5; y: 7.5
        width: 25
        height: 25
    }

    MouseArea {
        id: _mouseArea
        width: parent.width
        height: parent.height
        cursorShape: Qt.PointingHandCursor
        onClicked: _button.clicked()
    }
}
