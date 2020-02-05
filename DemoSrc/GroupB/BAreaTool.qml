import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

// 计算地图连线围成面积
BAbstractTool{
    id: control

    property bool _pathClose: false
    property double _areaValue: 0
    //标签样式暂时没管
    property color areaColor: Qt.rgba(0,1,0,0.4)
    property color borderColor: "red"
    property int borderWidth: 1
    property color pointColor: borderColor
    property int pointWidth: borderWidth
    property int pointSize: 14

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
                border.width: control.borderWidth
                border.color: control.borderColor
                //Component.onDestruction: console.log("destory item");

                Loader{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.margins: 5
                    sourceComponent: (_pathClose&&index==(item_model.count-1))?area_comp:null_comp
                }
            }
            //通过listmodel来设置数据
            coordinate{
                latitude: latitudeval
                longitude: longitudeval
            }
            anchorPoint: Qt.point(sourceItem.width/2, sourceItem.height/2)
        }
    }

    Component{
        id: null_comp
        Item{}
    }
    Component{
        id: area_comp
        Rectangle{
            width: area_text.width+5+5+14+5
            height: area_text.height+10
            border.color: "gray"
            Text {
                id: area_text
                x: 5
                anchors.verticalCenter: parent.verticalCenter
                text: control._areaValue+" m^2"
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
                        clearPath();
                    }
                }
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
        item_model.append({"latitudeval":coord.latitude,"longitudeval":coord.longitude});
        item_line.addCoordinate(coord);
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
        if(item_line.pathLength()<3){
            clearPath();
            return;
        }
        control._areaValue=getPolygonArea(item_line.path);
        item_line.addCoordinate(item_line.path[0]);
    }

    function clearPath(){
        item_line.path=[];
        item_model.clear();
    }

    //计算方式1：https://www.cnblogs.com/c-w20140301/p/10308431.html
    //根据py代码换砖而来
    //转换为弧度
    function convertToRadian(num){
        return num*Math.PI/180;
    }
    //计算地图区域面积
    function calculatePolygonArea(path){
        let area_count=0;
        let path_len=path.length;
        if(path_len<3)
            return area_count;
        let data_list=[];
        for(let i=0;i<path_len;i++){
            area_count+=convertToRadian(path[(i+1)%path_len].longitude-path[(i)%path_len].longitude)*
                    (2+Math.sin(convertToRadian(path[(i)%path_len].latitude))+
                     Math.sin(convertToRadian(path[(i+1)%path_len].latitude)));
        }
        area_count*=6378137.0 * 6378137.0 / 2.0;
        return Math.abs(area_count);
    }

    //计算方式2：https://blog.csdn.net/zdb1314/article/details/80661602
    //应该是提取的高德api里的函数，命名应该是混淆加密之后的
    function getPolygonArea(path){
        let area_count=0;
        let path_len=path.length;
        if(path_len<3)
            return area_count;
        let data_list=[];
        //WGS84地球半径
        let sJ = 6378137;
        //Math.PI/180
        let Hq = 0.017453292519943295;
        let c = sJ *Hq;
        for(let i=0;i<path_len-1;i++){
            let h=path[i];
            let k=path[i+1];
            let u=h.longitude*c*Math.cos(h.latitude*Hq);
            let hhh=h.latitude*c;
            let v=k.longitude*c*Math.cos(k.latitude*Hq);
            area_count+=(u*k.latitude*c-v*hhh);
        }
        let eee=path[path_len-1].longitude*c*Math.cos(path[path_len-1].latitude*Hq);
        let g2=path[path_len-1].latitude*c;
        let k=path[0].longitude*c*Math.cos(path[0].latitude*Hq);
        area_count+=eee*path[0].latitude*c-k*g2;

        return Math.round(Math.abs(area_count)/2);
    }
}
