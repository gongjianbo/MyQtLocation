import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

// 一次测距里包含多个标记点以及连线
BAbstractTool{
    id: control

    //标签样式暂时没管
    property color lineColor: "red"
    property int lineWidth: 2
    property color pointColor: lineColor
    property int pointWidth: lineWidth
    property int pointSize: 14

    //点的连线
    MapPolyline {
        id: item_line
        line.color: control.lineColor
        line.width: control.lineWidth
        //平滑后放大有点卡
        //layer.enabled: true
        //layer.smooth: true
        //layer.samples: 8
        function getDistanceCount(){
            let distance_count=0;
            for(let i=1;i<pathLength();i++){
                distance_count+=item_line.coordinateAt(i).distanceTo(item_line.coordinateAt(i-1));
            }
            return Math.round(distance_count);
        }
    }

    //每个点的标签
    MapItemView{
        id: item_view
        add: Transition {}
        remove: Transition {}
        model: ListModel{
            id: item_model
        }
        delegate: MapQuickItem{
            id: ietm_delegate
            sourceItem: Rectangle {
                width: control.pointSize
                height: control.pointSize
                radius: control.pointSize/2
                color: "white"
                border.width: control.pointWidth
                border.color: control.pointColor
                Rectangle{
                    anchors.left: parent.right
                    anchors.top: parent.bottom
                    width: item_text.width+5+5+14+5
                    height: item_text.height+10
                    border.color: "gray"
                    Text {
                        id: item_text
                        x: 5
                        anchors.verticalCenter: parent.verticalCenter
                        text: index<=0
                              ? "起点"
                              : (index==item_model.count-1)
                                ? ("总长 "+item_line.getDistanceCount()/1000+" km")
                                :(Math.round(ietm_delegate.coordinate.distanceTo(item_line.coordinateAt(index-1)))/1000+" km")
                    }
                    Rectangle{
                        width: 14
                        height: 14
                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        anchors.verticalCenter: parent.verticalCenter
                        border.color: "red"
                        Text {
                            color: "red"
                            anchors.centerIn: parent
                            text: "+"
                            rotation: 45
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                //最后一个全部删除,否则一个一个的删除
                                //为0的时候发送信号给group请求删除
                                if(index==item_model.count-1){
                                    clearPath();
                                }else{
                                    item_line.removeCoordinate(index);
                                    item_model.remove(index);
                                }
                            }
                        }
                    }
                }

                //Component.onDestruction: console.log("destory item");
            }
            //通过listmodel来设置数据
            coordinate{
                latitude: latitudeval
                longitude: longitudeval
            }
            anchorPoint: Qt.point(sourceItem.width/2, sourceItem.height/2)
        }
    }

    //抽象类中转发信号
    onClicked: {
        if(targetMap){
            let coord=targetMap.toCoordinate(Qt.point(x,y),false);
            control.appendPoint(coord);
        }
    }
    onDoubleClicked: {
        if(targetMap){
            control.closePath();
            control.finished(); //结束
        }
    }
    onPositionChanged: {
        if(targetMap){
            let coord=targetMap.toCoordinate(Qt.point(x,y),false);
            control.followMouse(coord);
        }
    }

    function appendPoint(coord){
        //let coord=the_map.toCoordinate(Qt.point(mouseX,mouseY),false);
        //console.log("area",coord.latitude,coord.longitude);
        item_model.append({"latitudeval":coord.latitude,"longitudeval":coord.longitude});
        item_line.addCoordinate(coord);
        //mouse_area._closePath=false;
        //console.log("ruler append",item_model.count,item_line.pathLength())
    }

    function followMouse(coord){
        if(item_line.pathLength()<=0)
            return;
        if(item_line.pathLength()===item_model.count){
            item_line.addCoordinate(coord);
        }else{
            item_line.replaceCoordinate(item_line.pathLength()-1,coord);
        }
    }

    function closePath(){
        while(item_line.pathLength()>item_model.count){
            item_line.removeCoordinate(item_line.pathLength()-1);
        }
    }

    function clearPath(){
        item_line.path=[];
        item_model.clear();
    }
}

