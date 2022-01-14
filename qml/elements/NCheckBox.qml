import QtQuick 2.15
import QtQuick.Controls 2.15

CheckBox {
    id: _box
    height: 30

    indicator: Rectangle {
        implicitWidth: 26
        implicitHeight: 26
        x: _box.leftPadding
        y: parent.height / 2 - height / 2
        radius: 5
        border.color: _box.checked ? "#3471CE" : "#B0C4C4C4"

        Rectangle {
            x: 6; y: 6
            width: 14
            height: 14
            radius: 5
            color: "#3471CE"
            visible: _box.checked
        }
    }

}
