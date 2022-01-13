import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Popup {
    id: _popup
    width: 500
    height: _text.contentHeight+20

    property string text

    Label {
        id: _text
        width: parent.width
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
