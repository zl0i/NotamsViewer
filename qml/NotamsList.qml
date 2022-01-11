import QtQuick 2.15
import QtQuick.Controls 2.15

ListView {
    id: _list
    clip: true
    spacing: 20

    signal toMap(var lat, var lon)

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
       onClicked: _list.toMap(x, y)
    }
}
