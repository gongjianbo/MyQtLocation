import QtQuick 2.12
import QtQuick.Controls 2.12
import QtLocation 5.12
import QtPositioning 5.12

import MyMap 1.0

Item {
    id: control

    property int hoverIndex: -1
    //地图
    Map {
        id: the_map
        anchors.fill: parent

        minimumZoomLevel: 4
        maximumZoomLevel: 16
        zoomLevel: 10
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
            //Cpp扩展的model，只有坐标点，还没写其他信息
            model: BoundaryModel{
                id: map_itemmodel
            }
            //MapPolygon的边框有Bug，所以还是用折线来画，但是务须让首尾相连
            delegate: MapItemGroup{
                MapPolygon{
                    id: item_polygon
                    function fromLatAndLong(latList, longList) {
                        let the_path=[];
                        if(latList.length!==longList.length)
                            return the_path;
                        for (let i=0; i<latList.length; i++) {
                            the_path.push( QtPositioning.coordinate(latList[i],longList[i]) );
                        }
                        return the_path;
                    }
                    //QList<coordxxx>不能直接和qml交互，so
                    path: fromLatAndLong(map_itemmodel.getLatitudes(index),
                                         map_itemmodel.getLongitudes(index))
                    //随机颜色，貌似飞地颜色也不一样了，待解决
                    color: Qt.hsla(Math.random(),0.9,0.3,1)
                    opacity: (control.hoverIndex===map_itemmodel.getId(index))?0.8:0.4
                    MouseArea{
                        anchors.fill: parent
                        onClicked: control.hoverIndex=map_itemmodel.getId(index);
                    }
                }
                MapPolyline{
                    id: item_polyline
                    path: item_polygon.path
                    line.width: 2
                    line.color: "black"
                }
            }//end delegate
        }

    }
}
