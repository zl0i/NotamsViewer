import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import Qt.labs.platform 1.1 as Labs

import "./elements"

Dialog {
    id: _dialog
    parent: Overlay.overlay
    x: parent.width/2 - width/2
    y: parent.height/2 - height/2
    width: 410
    height: 170
    padding: 20
    modal: true
    dim: true

    signal saveToRecent()
    signal saveToFile(string path, bool filtered)

    Overlay.modal: Rectangle {
        color: "#80000000"
    }

    Column {
        width: parent.width
        spacing: 20
        Row {
            spacing: 10
            NTextField {
                id: _pathField
                width: 260
                height: 30
            }
            NButton {
                text: qsTr("Обзор")
                onClicked: _fileDialog.open()
            }
        }
        NCheckBox {
            text: qsTr("Сохранить только отфильстрованный результат")
        }
        Row {
            spacing: 10
            NButton {
                text: qsTr("Сохранить как пресет")
                onClicked: _dialog.saveToRecent()
            }
            NButton {
                text: qsTr("Сохранить в файл")
            }
        }
    }

    background: Rectangle {
        radius: 5
        layer.enabled: true
        layer.effect: DropShadow {
            samples: 16
            radius: 8
            color: "#80000000"
        }
    }

    Labs.FileDialog {
        id: _fileDialog
        fileMode: Labs.FileDialog.SaveFile
        nameFilters: ["Text files (*.txt)"]
        onAccepted: _pathField.text = String(currentFile).slice(8)
    }
}
