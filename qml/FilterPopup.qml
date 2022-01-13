import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

import "./elements"

Popup {
    id: _popup
    width: 250
    height: 270
    padding: 0

    signal filter(string id, int flStart, int flEnd, string regExp, int duration, string compare)
    signal reset()



    function preFilter() {
        _popup.filter(_idFiled.text,
                      _flStartField.text,
                      _flEndField.text,
                      _regExpFiled.text,
                      Number(_durationField.text)*3600,
                      _durationBox.currentText
                      )
    }

    function format() {
        return {
            id: _idFiled.text,
            flStart: _flStartField.text,
            flEnd: _flEndField.text,
            regExp: _regExpFiled.text,
            duration: Number(_durationField.text)*3600,
            compareDuration: _durationBox.currentText
        }
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
            NComboBox {
                id: _durationBox
                width: 75
                height: parent.height
                model: ["=", ">", "<", ">=", "<="]
                onCurrentTextChanged: {
                    if(Number(_durationField.text) > 0)
                        _popup.preFilter()
                }
            }
            NTextField {
                id: _durationField
                width: 45
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: "0"
                onTextEdited: _popup.preFilter()
            }
            Label {
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: "h"
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
            _durationField.text = "0"
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
