import QtQuick 2.12
import QtQuick.Controls 2.12
import QtLocation 5.12
import QtPositioning 5.12

// 一次测距里包含多个标记点以及连线
MapItemGroup{
    id: control

    property bool _pathClose: false

    MapPolyline {
        id: item_line
        line.color: "red"
        line.width: 2
        //平滑后放大有点卡
        //layer.enabled: true
        //layer.smooth: true
        //layer.samples: 8
        function getDistanceCount(){
            var distance_count=0;
            for(var i=1;i<pathLength();i++){
                distance_count+=item_line.coordinateAt(i).distanceTo(item_line.coordinateAt(i-1));
            }
            return Math.round(distance_count);
        }
    }

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
                width: 14
                height: 14
                radius: 7
                color: "white"
                border.width: 2
                border.color: "red"
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

    function appendPoint(coord){
        //var coord=the_map.toCoordinate(Qt.point(mouseX,mouseY),false);
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
        control._pathClose=true;
        while(item_line.pathLength()>item_model.count){
            item_line.removeCoordinate(item_line.pathLength()-1);
        }
    }

    function clearPath(){
        item_line.path=[];
        item_model.clear();
    }
}

