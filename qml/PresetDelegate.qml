import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Item {
    id: _delegate
    width: ListView.view.width
    height: 65

    property string name
    property string icaos

    signal clicked(string name, var icaos)
    signal remove(string name)
    signal removeAll()

    Label {
        x: 10; y: 5
        font { pixelSize: 14; bold: true }
        text: model.name
    }

    Label {
        x: 10; y: 25
        width: parent.width-10
        height: 40
        font.pixelSize: 12
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
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            if(mouse.button == Qt.LeftButton) {
                _delegate.clicked(_delegate.name, _delegate.icaos.split(" "))
            } else if(mouse.button == Qt.RightButton) {
                _popup.x = mouseX
                _popup.y = mouseY
                _popup.open()
            }
        }
    }

    Popup {
        id: _popup
        width: 100
        height: 50
        padding: 0

        Column {
            width: parent.width
            Label {
                width: parent.width
                height: 24
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Удалить")
                background: Rectangle {
                    color: _mouseAreaLbl1.containsMouse ? "#80C4C4C4" : "#FFFFFF"
                }
                MouseArea {
                    id: _mouseAreaLbl1
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: { _delegate.remove(_delegate.name); _popup.close() }
                }
            }
            Rectangle {
                width: parent.width
                height: 1
                color: "#000000"
            }
            Label {
                width: parent.width
                height: 24
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Удалить все")
                background: Rectangle {
                    color: _mouseAreaLbl2.containsMouse ? "#80C4C4C4" : "#FFFFFF"
                }
                MouseArea {
                    id: _mouseAreaLbl2
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: { _delegate.removeAll(); _popup.close() }
                }
            }
        }

        background: Rectangle {
            radius: 5
            color: "#FFFFFF"
            layer.enabled: true
            layer.effect: DropShadow {
                samples: 16
                radius: 8
                color: "#80000000"
            }
        }
    }
}
