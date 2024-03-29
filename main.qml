import QtQuick 2.15
import QtQuick.Controls 2.12
import QtLocation 5.12
import QtPositioning 5.12
import Qt.labs.platform 1.1 as Labs

import "./qml"
import "./qml/elements"

ApplicationWindow {
    id: _app
    width: 1240
    height: 640
    visible: true
    title: qsTr("Notams Viewer")

    font.pixelSize: 14

    Connections {
        target: core
        function onFinished() {
            _busyPage.visible = false
            _stack.push(_notamView)
        }
    }

    StackView {
        id: _stack
        width: parent.width/3
        height: parent.height
        initialItem: _welcome
    }

    NotamsWelcome {
        id: _welcome
        visible: false
        recent: core.recents
        onLoad: {
            _filterPopup.resetUI()
            core.notams.resetFilter()
            _saveDialog.presetName = ""
            core.loadNotams(icaos)
            _busyPage.visible = true
        }
        onLoadRecent: {
            core.loadNotams(icaos)
            _busyPage.visible = true
            _filterPopup.setFilter(filter)
            _saveDialog.presetName = name
        }
        onRemove: core.recents.remove(name)
        onRemoveAll: core.recents.removeAll()
    }

    BusyPage {
        id: _busyPage
        anchors.fill: _welcome
        visible: false
    }

    NotamsView {
        id: _notamView
        visible: false
        model: core.notams
        onBack: _stack.pop(_welcome)
        onOpenFilter: _filterPopup.open()
        onGoToMap: {
            _map.zoomLevel = 10
            _map.center = QtPositioning.coordinate(lat, lon)
        }
        onShowNotam: {
            _notamPopup.text = text
            _notamPopup.y = y
            if(y + _notamPopup.height > _app.height) {
                _notamPopup.y = _app.height - _notamPopup.height - 20
            }
            _notamPopup.open()
        }
        onSave: _saveDialog.open()
    }

    FilterPopup {
        id: _filterPopup
        x: parent.width/3 + 20
        y: 10
        onFilter: core.notams.setFilter(filter)
        onReset: core.notams.resetFilter()
    }
    NotamPopup {
        id: _notamPopup
        x: parent.width/3 + 20
        y: 10
        onCopyToClipboard: core.copyToClipboard(text);
    }

    SaveDialog {
        id: _saveDialog
        onSaveToRecent: {
            core.recents.save(name, _welcome.icaos, _filterPopup.format())
            close()
        }
        onSaveToFile: {
            core.saveToFile(path, filtered)
            close()
        }
    }

    Component {
        id: _fileDialogComponent
        Labs.FileDialog {
            id: _saveGrabDialog
            fileMode: Labs.FileDialog.SaveFile
            nameFilters: ["Image files (*.png)"]
        }
    }



    Map {
        id: _map
        x: parent.width/3
        width: parent.width-x
        height: parent.height
        center: QtPositioning.coordinate(44.34, -94.30)
        zoomLevel: 3.5
        plugin: Plugin { name: "osm" }

        NRoundButtton {
            id: _grabButton
            x: parent.width - width - 20
            y: 20
            image: "qrc:/icons/image-white.svg"
            imageWidth: 21
            imageHeight: 18
            onClicked: {
                const dialog = _fileDialogComponent.createObject()
                dialog.fileMode = Labs.FileDialog.SaveFile
                dialog.open()
                dialog.accepted.connect(function() {
                    _grabButton.visible = false
                    _map.grabToImage(function (result) {
                        _grabButton.visible = true
                        result.saveToFile(String(dialog.file).slice(8))
                        dialog.close()
                        dialog.destroy()
                    })
                })
            }
        }

        NotamsMapView {
            model: core.notams
            onClicked: _notamView.showNotamByIndex(index)
        }

        Row {
            x: parent.width - width
            y: parent.height - 15
            spacing: 10
            Label {
                text: Number(_map.center.latitude).toFixed(4)
            }
            Label {
                text: Number(_map.center.longitude).toFixed(4)
            }
        }
    }
}
