import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Popup {
    id: _popup
    width: 500
    height: _text.contentHeight + 20
    padding: 0

    property string text

    signal copyToClipboard(var text)

    contentItem: Row {
        width: parent.width
        TextInput {
            id: _text
            padding: 10
            activeFocusOnPress: false
            width: parent.width-50
            selectByMouse: true
            selectionColor: "#3471CE"
            selectedTextColor: "#FFFFFF"
            font.pixelSize: 14
            wrapMode: Text.WordWrap
            text: _popup.text
        }
        MouseArea {
            width: 50
            height: parent.height
            hoverEnabled: true
            onClicked: _popup.copyToClipboard(_popup.text)
            Rectangle {
                width: parent.width
                height: parent.height
                color: parent.containsMouse ? (parent.containsPress ? "#F0C4C4C4" : "#80C4C4C4") : "#00000000"
            }
            Image {
                anchors.centerIn: parent
                width: 25
                height: 25
                source: "qrc:/icons/clipboard-black.svg"
            }
        }
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
