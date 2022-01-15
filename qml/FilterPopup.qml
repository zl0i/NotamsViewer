import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

import "./elements"

Popup {
    id: _popup
    width: 340
    height: 270
    padding: 0

    signal filter(var filter)
    signal reset()

    function preFilter() {
        _popup.filter(format())
    }

    function resetUI() {
        _idFiled.text = ""
        _flStartField.text = "-1"
        _flEndField.text = "-1"
        _regExpFiled.text = ""
        _durationField.text = "0"
        _isUNLBox.checked = false
        _isAreaBox.checked = false
    }

    function format() {
        return {
            id: _idFiled.text,
            flStart: Number(_flStartField.text),
            flEnd: Number(_flEndField.text),
            regExp: _regExpFiled.text,
            duration: Number(_durationField.text)*3600,
            compareDuration: _durationBox.currentText,
            isUNL: _isUNLBox.checked,
            isArea: _isAreaBox.checked
        }
    }

    function setFilter(filter) {
        _idFiled.text = filter.id
        _flStartField.text = filter.flStart
        _flEndField.text = filter.flEnd
        _regExpFiled.text = filter.regExp
        _durationField.text = filter.duration/3600
        _durationBox.currentIndex = Array.from(_durationBox.model).indexOf(filter.compareDuration)
        _isUNLBox.checked = filter.isUNL
        _isAreaBox.checked = filter.isArea
        preFilter()
    }

    Column {
        x: 15; y: 15
        spacing: 7
        NInputField {
            id: _idFiled
            label: "id:"
            onTextEdited: preFilter()
        }
        Row {
            height: 35
            spacing: 10
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
            Label {
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: "isUNL:"
            }
            NCheckBox {
                id: _isUNLBox
                height: parent.height
                onCheckedChanged: preFilter()
            }
        }
        Row {
            height: 35
            spacing: 10
            Label {
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                text: "isArea:"
            }
            NCheckBox {
                id: _isAreaBox
                height: parent.height
                onCheckedChanged: preFilter()
            }
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
           _popup.resetUI()
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
