import QtQuick 2.15
import QtLocation 5.15

MapItemView {
    delegate: MapPolygon {

        property var points: model

        color: '#808FAA20'
        border { width: 1; color: "red" }
        path: points.map(p => {
                             return { latitude: p.x, longitude: p.y }
                         })

    }
}


