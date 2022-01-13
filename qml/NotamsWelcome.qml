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
            spacing: 20
            clip: true
            model: _page.recent
            delegate: Item {
                width: parent.width
                height: 45
                Label {
                    width: parent.width
                    height: 45
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                    text: model.icaos
                }

                Rectangle {
                    width: parent.width
                    height: parent.height
                    visible: _mouseArea.containsMouse
                    color: _mouseArea.containsPress ? "#A0C4C4C4" : "#80C4C4C4"
                }

                MouseArea {
                    id: _mouseArea
                    width: parent.width-30
                    height: parent.height
                    hoverEnabled: true
                    onClicked: _page.load(model.icaos.split(" "))
                }
            }
        }
    }

}
