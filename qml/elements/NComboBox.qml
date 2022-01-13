import QtQuick 2.15
import QtQuick.Controls 2.15

ComboBox {
    id: _box

    background: Rectangle {
        width: parent.width
        height: parent.height
        radius: 5
        border {
            width: 1
            color: _box.activeFocus ? "#3471CE" : "#80C4C4C4"
        }
    }
}
