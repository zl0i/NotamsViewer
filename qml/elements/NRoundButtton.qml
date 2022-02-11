import QtQuick 2.15

Rectangle {
    id: _button
    width: 40
    height: 40
    radius: 20
    color: _mouseArea.containsPress ? "#1D4B8F" : "#3471CE"

    property alias image: _image.source
    property alias imageWidth: _image.width
    property alias imageHeight: _image.height
    signal clicked()

    Image {
        id: _image
        anchors.centerIn: parent
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
