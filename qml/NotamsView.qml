import QtQuick 2.15
import QtQuick.Controls 2.15

import "./elements"

Page {
    id: _page

    property var model: []
    signal back()
    signal openFilter()
    signal openColor()
    signal goToMap(var lat, var lon)
    signal showNotam(var text, int y)
    signal save();

    function showNotamByIndex(index) {
        _notamsList.positionViewAtIndex(index, ListView.Center)
        _notamsList.currentIndex = index
        _notamsList.currentItem.blink()
    }

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
            image: "qrc:/icons/save-white.svg"
            onClicked: _page.save()
        }
        NRoundButtton {
            image: "qrc:/icons/filter-white.svg"
            onClicked: _page.openFilter()
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

        delegate: NotamsDelegate {
           notamsId: model.notamID
           startDate: model.startDate
           endDate: model.endDate
           createDate: model.createDate
           text: model.text
           flStart: model.flStart ?? 0
           flEnd: model.flEnd ?? 0
           points: model.points
           durationSeconds: model.durationSeconds
           durationHumon: model.durationHumon
           onClicked: _page.goToMap(x, y)
           onMore: _page.showNotam(text, y)
        }
    }
}
