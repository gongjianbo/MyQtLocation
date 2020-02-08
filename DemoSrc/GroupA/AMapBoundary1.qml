import QtQuick 2.12
import QtQuick.Controls 2.12

import QtLocation 5.12
import QtPositioning 5.12

//参考Qt示例：
//E:\Qt\Qt5.12.6\Examples\Qt-5.12.6\location\itemview_transitions
Item {
    id: control

    property int hoverId: -1
    //地图
    Map {
        id: the_map
        anchors.fill: parent

        minimumZoomLevel: 4
        maximumZoomLevel: 16
        zoomLevel: 10
        //成都
        center: QtPositioning.coordinate(30.67, 104.06)

        plugin: Plugin {
            name: "mymap" //"esri" "mapbox" "osm" "here"

            PluginParameter {
                name: "baseUrl"
                // 自行指定瓦片路径
                value: "file:///"+applicationDirPath+"/dianzi_gaode_ArcgisServerTiles/_alllayers"
            }
            PluginParameter {
                name: "format"
                value: "png"
            }
        }

        MapItemView{
            id: map_itemview
            model: ABoundaryModel{
                id: map_itemmodel
            }
            //MapPolygon的边框有Bug，所以还是用折线来画，但是务须让首尾相连
            delegate: MapItemGroup{
                MapPolygon{
                    id: item_polygon
                    path: map_itemmodel.geometries[itemName]
                    color: (control.hoverId===itemId)
                           ?Qt.rgba(1,0,0,0.5):Qt.rgba(0,1,0,0.5)
                    MouseArea{
                        anchors.fill: parent
                        onClicked: control.hoverId=itemId;

                        Text{
                            anchors.centerIn: parent
                            text: itemName
                            color: "green"
                            font{
                                pixelSize: 25
                            }
                        }
                    }
                }
                MapPolyline{
                    id: item_polyline
                    path: item_polygon.path
                    line.width: 2
                    line.color: "green"
                }
            }//end delegate
        }

    }
}
