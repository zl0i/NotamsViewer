import QtQuick 2.15
import QtQuick.Controls 2.15

ListView {
    clip: true
    spacing: 20

    delegate: NotamsDelegate {
       startDate: model.startDate
       endDate: model.endDate
       createDate: model.createDate
       text: model.text
       flStart: model.flStart ?? 0
       flEnd: model.flEnd ?? 0
       points: model.points
       durationSeconds: model.durationSeconds
       durationHumon: model.durationHumon
    }
}
