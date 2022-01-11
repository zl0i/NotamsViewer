import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

import "./elements"

Popup {
    width: 250
    height: 270
    padding: 0


    Column {
        x: 15; y: 15
        spacing: 7
        NInputField {
            label: "id:"
        }
        NInputField {
            label: "flStart:"
        }
        NInputField {
            label: "flEnd:"
        }
        NInputField {
            widthField: 80
            label: "regExp:"
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
