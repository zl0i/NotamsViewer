import QtQuick 2.15
import QtQuick.Controls 2.15

import "./elements"

Page {
    id: _page
    width: parent.width
    height: parent.height
    focusPolicy: Qt.ClickFocus

    property var recent: []
    property alias icaos: _icaosField.text

    signal load(var icaos)
    signal loadRecent(string name, var icaos, var filter)
    signal remove(string name)
    signal removeAll()

    Column {
        x: 15; y: 20
        width: parent.width-30
        height: parent.height
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
        Label {
            font { pixelSize: 18; bold: true }
            text: qsTr("Сохраненные поиски:")
        }
        ListView {
            width: parent.width
            height: parent.height - y
            bottomMargin: 20
            spacing: 10
            clip: true
            model: _page.recent
            delegate: PresetDelegate {
                name: model.name
                icaos: model.icaos
                onClicked:  _page.loadRecent(model.name, model.icaos.split(" "), model.filter)
                onRemove: _page.remove(name)
                onRemoveAll: _page.removeAll()
            }
        }
    }
}

