import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

ListModel {
    id: list_model

    property var geometries: {
        "A区":[
                    QtPositioning.coordinate(30.773889148239068, 104.07235961913943),
                    QtPositioning.coordinate(30.836404695997977, 103.91168457030699),
                    QtPositioning.coordinate(30.638102489849622, 103.77160888672023),
                    QtPositioning.coordinate(30.489108430341894, 103.92816406249955),
                    QtPositioning.coordinate(30.483191250167938, 104.14377075195387),
                    QtPositioning.coordinate(30.654643253330736, 104.01330810546443),
                    QtPositioning.coordinate(30.773889148239068, 104.07235961913943)
                ],
        "B区":[
                    QtPositioning.coordinate(30.863521425780851, 104.17672973631898),
                    QtPositioning.coordinate(30.821074458508345, 104.34427124022659),
                    QtPositioning.coordinate(30.646373225245725, 104.30993896485052),
                    QtPositioning.coordinate(30.483191250167938, 104.14377075195387),
                    QtPositioning.coordinate(30.654643253330736, 104.01330810546443),
                    QtPositioning.coordinate(30.773889148239068, 104.07235961913943),
                    QtPositioning.coordinate(30.863521425780851, 104.17672973631898)
                ]
    }

    ListElement {
        itemName: "A区"
        itemId: 1
    }
    ListElement {
        itemName: "B区"
        itemId: 2
    }
}
