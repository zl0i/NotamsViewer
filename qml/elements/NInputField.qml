import QtQuick 2.15
import QtQuick.Controls 2.15

Row {
    id: _field
    height: 35
    spacing: 10

    property string label: ""
    property alias text: _text.text
    property int widthField: 55

    Label {
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        text: _field.label
    }
    NTextField {
        id: _text
        width: _field.widthField
        height: parent.height
        verticalAlignment: Text.AlignVCenter
    }
}
