import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Popup {
    id: _popup
    width: 500
    height: _text.contentHeight+20

    property string text

    TextInput {
        id: _text
        activeFocusOnPress: false
        width: parent.width
        selectByMouse: true
        selectionColor: "#3471CE"
        selectedTextColor: "#FFFFFF"
        font.pixelSize: 14
        wrapMode: Text.WordWrap
        text: _popup.text
    }

    background: Rectangle {
        radius: 5
        color: "#FFFFFF"
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 8
            samples: 16
            color: "#80000000"
        }
    }
}
