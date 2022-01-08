import QtQuick 2.15
import QtLocation 5.15

MapItemView {

    delegate: NotamsMapDelegate {
        points: model.points
    }
}
