import QtQuick 2.15
import QtQuick.Controls 2.15

import "./elements"

Page {
    id: _page

    property var model: []
    signal back()

    Row {
        x: 15; y: 20
        spacing: 10
        Image {
            width: 15
            height: 15
            source: "qrc:/icons/back-black.svg"
            MouseArea {
                x: -10; y: -10
                width: parent.width+20
                height: parent.height+20
                cursorShape: Qt.PointingHandCursor
                onClicked: _page.back()
            }
        }
        Label {
            height: 15
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
            text: qsTr("Назад")
        }
    }

    Row {
        x: parent.width - width - 15
        y: 10
        spacing: 15
        NRoundButtton {
            image: "qrc:/icons/filter-white.svg"
        }
        NRoundButtton {
            image: "qrc:/icons/color-white.svg"
        }
    }

    NotamsList {
        id: _notamsList
        x: 15; y: 60
        width: parent.width-30
        height: parent.height-60
        bottomMargin: 20
        model: _page.model
    }
}
