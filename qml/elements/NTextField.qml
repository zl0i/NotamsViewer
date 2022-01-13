import QtQuick 2.15
import QtQuick.Controls 2.12

TextField {
    id: _field

    verticalAlignment: Text.AlignTop
    horizontalAlignment: Text.AlignLeft
    color: "#000000"
    placeholderTextColor: "#C0C4C4C4"
    selectByMouse: true
    selectionColor: "#3471CE"
    selectedTextColor: "#FFFFFF"
    wrapMode: Text.WordWrap

    background: Rectangle {
        width: parent.width
        height: parent.height
        radius: 5
        border {
            width: 1
            color: _field.activeFocus ? "#3471CE" : "#80C4C4C4"
        }
    }
}
