import QtQuick 2.15
import QtLocation 5.15

MapPolygon {

    property var points: []

    color: '#808FAA20'
    border { width: 1; color: "red" }
    path: points.map(p => {
                         return { latitude: p.x, longitude: p.y }
                     })
    //    path: [
    //        { latitude: 40.66, longitude: -127.16 },
    //        { latitude: 40.66, longitude: -132 },
    //        { latitude: 37.5, longitude: -132 },
    //        { latitude: 37.5, longitude: -127.16 }
    //    ]
}
