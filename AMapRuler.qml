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
    property int mapMode: 0
    property MapRuler currentRuler: null

    property alias map: the_map
    clip: true

    onMapModeChanged: {
        console.log("map mode",mapMode);
        if(control.mapMode!=1&&currentRuler){
            currentRuler.closePath();
            currentRuler=null;
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
            text: "Ruler"
            onCheckedChanged: if(checked)control.mapMode=1;
        }
        RadioButton{
            text: "Shot"
            onCheckedChanged: if(checked)control.mapMode=2;
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
                // 1 测距
                if(control.mapMode===1){
                    if(!currentRuler){
                        currentRuler=ruler_comp.createObject(the_map);
                        if(currentRuler)
                            the_map.addMapItemGroup(currentRuler);
                    }
                    if(currentRuler){
                        var coord=the_map.toCoordinate(Qt.point(mouseX,mouseY),false);
                        currentRuler.appendPoint(coord);
                    }
                }
            }
            onDoubleClicked: {
                // 1 测距
                if(control.mapMode===1){
                    if(currentRuler){
                        currentRuler.closePath();
                        currentRuler=null;
                    }
                }
            }
            onPositionChanged: {
                // 1 测距
                if(control.mapMode===1){
                    if(currentRuler){
                        var coord=the_map.toCoordinate(Qt.point(mouseX,mouseY),false);
                        currentRuler.followMouse(coord);
                    }
                }
            }
        }
    }

    QuickItemShot {
        id: shot_area
        shotTarget: the_map
        anchors.fill: the_map
        anchors.margins: 1
        visible: control.mapMode==2
    }

    Component{
        id: ruler_comp
        MapRuler{

        }
    }
}
