import QtQuick 2.15
import QtLocation 5.15

MapItemView {


    delegate: MapItemView {
        model: points
        delegate: MapPolygon {
            color: '#808FAA20'
            border { width: 1; color: "red" }
            path: model.modelData.map(p => {
                                return { latitude: p.x, longitude: p.y }
                            })

        }
    }
}
