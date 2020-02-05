import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

// 计算地图连线围成多边形区域，参照Area面积工具
BAbstractTool{
    id: control

    property bool _pathClose: false
    property int _clickCount: 0
    //标签样式暂时没管
    property color areaColor: Qt.rgba(1,1,0,0.4)
    property color borderColor: "red"
    property int borderWidth: 1

    //MapPolygon很多方法没有，所以拿MapPolyline来记录坐标点
    //优化的话自定义cpp类型
    MapPolygon{
        id: item_polygon
        color: control.areaColor
        border.width: 0
        path: item_line.path
    }
    MapPolyline{
        id: item_line
        line.width: control.borderWidth
        line.color: control.borderColor
    }
    MapQuickItem{
        id: item_closebtn
        visible: control._pathClose&&control._clickCount>2
        anchorPoint: Qt.point(sourceItem.width/2, sourceItem.height/2)
        sourceItem: Rectangle{
            width: 14
            height: 14
            border.color: "red"
            Text {
                color: "red"
                anchors.centerIn: parent
                text: "+"
                rotation: 45
            }
            MouseArea{
                anchors.fill: parent
                onClicked: clearPath();
            }
        }
    }

    //抽象类中转发信号
    onClicked: {
        if(targetMap){
            var coord=targetMap.toCoordinate(Qt.point(x,y),false);
            control.appendPoint(coord);
        }
    }
    onDoubleClicked: {
        if(targetMap){
            control.closePath();
        }
    }
    onPositionChanged: {
        if(targetMap){
            var coord=targetMap.toCoordinate(Qt.point(x,y),false);
            control.followMouse(coord);
        }
    }

    function appendPoint(coord){
        item_line.addCoordinate(coord);
        _clickCount+=1;
    }

    function followMouse(coord){
        if(item_line.pathLength()<=0)
            return;
        if(item_line.pathLength()===_clickCount){
            item_line.addCoordinate(coord);
        }else{
            item_line.replaceCoordinate(item_line.pathLength()-1,coord);
        }
    }

    function closePath(){
        control._pathClose=true;
        while(item_line.pathLength()>_clickCount){
            item_line.removeCoordinate(item_line.pathLength()-1);
        }
        if(item_line.pathLength()<3){
            clearPath();
            return;
        }
        item_closebtn.coordinate=item_line.path[item_line.pathLength()-1];
        item_line.addCoordinate(item_line.path[0]);
    }

    function clearPath(){
        item_line.path=[];
        _clickCount=0;
    }
}
