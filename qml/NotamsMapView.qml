import QtQuick 2.15
import QtLocation 5.15

MapItemView {
    id: _view
    signal clicked(var index)

    delegate: MapItemGroup {
        id: _delegate

        property var index: model.index
        property var notamsId: model.notamID

        MapItemView {
            model: points
            delegate: MapPolygon {
                id: _polygon
                color: "#F04A4A"
                opacity: 0.6
                border { width: 1; color: "#000000" }
                clip: true
                path: model.modelData.map(p => {
                                              return { latitude: p.x, longitude: p.y }
                                          })
                MouseArea {
                    id: _mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        _delegate.z = 10000
                        _polygon.opacity = 1
                        _polygon.border.width = 2
                    }
                    onExited: {
                        _delegate.z = 0
                         _polygon.border.width = 1
                         _polygon.opacity = 0.6
                    }
                    onClicked: _view.clicked(_delegate.index)
                }

            }
        }
    }


}
