import QtQuick 2.15
import QtQuick.Controls 2.15

import "./elements"

Page {
    id: _page
    width: parent.width
    height: parent.height
    focusPolicy: Qt.ClickFocus

    signal load(var icaos)

    Column {
        x: 15; y: 20
        width: parent.width
        spacing: 15
        Label {
            font { pixelSize: 18; bold: true }
            text: "ICAO:"
        }
        NTextField {
            id: _icaosField
            width: parent.width - 30
            height: 80
            placeholderText: qsTr("Введите icao-точки через пробел")
            text: "KZAK"
        }
        NButton {
            text: qsTr("Получить")
            onClicked: {
                 const icaos = _icaosField.text.split(" ")
                _page.load(icaos)
            }
        }
    }

}
