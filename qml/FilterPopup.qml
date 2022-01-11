import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

import "./elements"

Popup {
    id: _popup
    width: 250
    height: 270
    padding: 0

    signal filter(string id, int flStart, int flEnd, string regExp)
    signal reset()



    function preFilter() {
        _popup.filter(_idFiled.text,
                      _flStartField.text,
                      _flEndField.text,
                      _regExpFiled.text)
    }

    Column {
        x: 15; y: 15
        spacing: 7
        NInputField {
            id: _idFiled
            label: "id:"
            onTextEdited: preFilter()
        }
        NInputField {
            id: _flStartField
            label: "flStart:"
            text: "-1"
            onTextEdited: preFilter()
        }
        NInputField {
            id: _flEndField
            label: "flEnd:"
            text: "-1"
            onTextEdited: preFilter()
        }
        NInputField {
            id: _regExpFiled
            widthField: 80
            label: "regExp:"
            onTextEdited: preFilter()
        }
        Row {
            height: 35
            spacing: 8

            Label {
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: "Duration:"
            }
            NTextField {
                width: 45
                height: parent.height
                verticalAlignment: Text.AlignVCenter
            }
            Label {
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: "h"
            }
            NTextField {
                width: 45
                height: parent.height
                verticalAlignment: Text.AlignVCenter
            }
            Label {
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: "m"
            }
        }
    }

    NButton {
        x: parent.width - width - 10
        y: parent.height - height - 10
        text: qsTr("Сбросить")
        onClicked: {
            _idFiled.text = ""
            _flStartField.text = "-1"
            _flEndField.text = "-1"
            _regExpFiled.text = ""
            _popup.reset()
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
