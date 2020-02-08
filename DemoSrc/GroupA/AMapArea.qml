import QtQuick 2.12
import QtQuick.Controls 2.12
import QtLocation 5.12
import QtPositioning 5.12

//地图自定义
Item{
    id: control
    //地图的模式
    // 0:普通浏览
    // 1:测距
    // 2:截图
    // 3:面积
    property int mapMode: 0
    property AAreaTool currentArea: null

    property alias map: the_map
    clip: true

    onMapModeChanged: {
        console.log("map mode",mapMode);
        if(control.mapMode!=3&&currentArea){
            currentArea.closePath();
            currentArea=null;
        }
    }

    //缩放等级，维度，精度
    function viewPoint(zoomLevel,latitude,longitude){
        the_map.zoomLevel=zoomLevel;
        the_map.center=QtPositioning.coordinate(latitude, longitude);
    }


    Row{
        RadioButton{
            text: "Normal"
            checked: true
            onCheckedChanged: if(checked)control.mapMode=0;
        }
        RadioButton{
            text: "Area"
            onCheckedChanged: if(checked)control.mapMode=3;
        }
    }

    Map {
        id: the_map
        anchors.fill: parent
        anchors.topMargin: 40
        minimumZoomLevel: 4
        maximumZoomLevel: 16
        zoomLevel: 10
        center: QtPositioning.coordinate(30.6562, 104.0657)

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

        //显示缩放等级与center
        Rectangle{
            anchors{
                left: the_map.left
                bottom: the_map.bottom
                margins: 5
            }

            width: content.width+20
            height: content.height+10
            Text {
                id: content
                x: 10
                y: 5
                font.pixelSize: 14
                text: "Zoom Level "+Math.floor(the_map.zoomLevel)+" Center:"+the_map.center.latitude+"  "+the_map.center.longitude

            }
        }

        MouseArea{
            id: map_mouse
            anchors.fill: parent
            enabled: control.mapMode!=0

            //画了一个点后跟随鼠标，除非双击
            hoverEnabled: true
            onClicked: {
                // 3 面积
                if(control.mapMode===3){
                    if(!currentArea){
                        currentArea=area_comp.createObject(the_map);
                        if(currentArea)
                            the_map.addMapItemGroup(currentArea);
                    }
                    if(currentArea){
                        var coord=the_map.toCoordinate(Qt.point(mouseX,mouseY),false);
                        currentArea.appendPoint(coord);
                    }
                }
            }
            onDoubleClicked: {
                // 3 面积
                if(control.mapMode===3){
                    if(currentArea){
                        currentArea.closePath();
                        currentArea=null;
                    }
                }
            }
            onPositionChanged: {
                // 3 面积
                if(control.mapMode===3){
                    if(currentArea){
                        var coord=the_map.toCoordinate(Qt.point(mouseX,mouseY),false);
                        currentArea.followMouse(coord);
                    }
                }
            }
        }
    }

    Component{
        id: area_comp
        AAreaTool{

        }
    }
}
