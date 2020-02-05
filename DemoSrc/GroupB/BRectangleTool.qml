import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

// 计算地图连线围成多边形区域，参照Area面积工具
BAbstractTool{
    id: control

    preventStealing: true //因为要保持拖动，所以事件不能被窃取
    property bool _pathClose: false
    //标签样式暂时没管
    property color areaColor: Qt.rgba(0,1,0,0.4)
    property color borderColor: "red"
    property int borderWidth: 1

    MapRectangle{
        id: item_rect
        border.width: control.borderWidth
        border.color: control.borderColor
        color: control.areaColor
    }

    MapQuickItem{
        id: item_closebtn
        visible: control._pathClose
        //上加下减，左加右减，原点左上角
        coordinate: QtPositioning.coordinate(
                        item_rect.topLeft.latitude,
                        item_rect.bottomRight.longitude
                        )
        anchorPoint: Qt.point(-2,sourceItem.height+2)
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
    onPressed: {
        if(targetMap){
            if(!control._pathClose){
                let coord=targetMap.toCoordinate(Qt.point(x,y),false);
                item_rect.topLeft=coord;
            }
        }
    }
    onReleased: {
        if(targetMap){
            if(!control._pathClose){
                let coord=targetMap.toCoordinate(Qt.point(x,y),false);
                item_rect.bottomRight=coord;
                control._pathClose=true;
                control.finished(); //结束
            }
        }
    }
    onPositionChanged: {
        if(targetMap){
            if(!control._pathClose){
                let coord=targetMap.toCoordinate(Qt.point(x,y),false);
                item_rect.bottomRight=coord;
            }
        }
    }
}
