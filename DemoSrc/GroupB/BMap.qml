import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

//地图
Map {
    id: control

    property Component currentComp: null
    property BAbstractTool currentTool: null

    minimumZoomLevel: 3
    maximumZoomLevel: 16
    zoomLevel: 10
    center: QtPositioning.coordinate(30.67, 104.06)

    plugin: Plugin {
        name: "mymap" //"esri" "mapbox" "osm" "here"

        PluginParameter {
            name: "baseUrl"
            value: "file:///"+applicationDirPath+"/dianzi_gaode_ArcgisServerTiles/_alllayers"
        }
        PluginParameter {
            name: "format"
            value: "png"
        }
    }

    MouseArea{
        id: map_mousearea
        anchors.fill: parent
        enabled: control.currentComp!=null
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        //preventStealing为true则事件不会被偷取，默认false
        preventStealing: false

        onClicked: {
            //左键点击为功能，右键取消
            if(mouse.button===Qt.LeftButton){
                //release后才有click
                /*if(!control.currentTool&&control.currentComp)
                    control.createTool();*/
                if(control.currentTool)
                    control.currentTool.clicked(mouseX,mouseY);
            }else{
                control.destroyTool();
            }
        }
        onDoubleClicked: {
            if(mouse.button===Qt.LeftButton){
                if(control.currentTool)
                    control.currentTool.doubleClicked(mouseX,mouseY);
            }else{
                control.destroyTool();
            }
        }
        onPositionChanged: {
            if(control.currentTool)
                control.currentTool.positionChanged(mouseX,mouseY);
        }
        onPressed: {
            if(mouse.button===Qt.LeftButton){
                if(!control.currentTool&&control.currentComp)
                    control.createTool();
                if(control.currentTool)
                    control.currentTool.pressed(mouseX,mouseY);
            }else{
                control.destroyTool();
            }
        }
        onReleased: {
            if(control.currentTool)
                control.currentTool.released(mouseX,mouseY);
        }
    }

    //相当于切换操作类型/模式，null的话就是浏览地图没操作
    function switchComp(tool_comp){
        if(control.currentComp)
             control.destroyTool();
        control.currentComp=tool_comp;
        if(!control.currentComp)
            control.closeTool();
    }

    //相当于一次操作开始
    function createTool(){
        //console.log("create tool")
        if(control.currentTool)
            control.closeTool();
        let new_tool=control.currentComp.createObject(map);
        if(new_tool){
            control.currentTool=new_tool;
            control.currentTool.targetMap=map;
            //使用finished信号来确认操作结束
            control.currentTool.finished.connect(control.closeTool)
            //添加到map中显示
            map.addMapItemGroup(control.currentTool);
            //事件偷取
            map_mousearea.preventStealing=control.currentTool.preventStealing;
        }
    }

    //相当于一次操作结束
    function closeTool(){
        //console.log("close tool")
        control.currentTool=null;
        //事件偷取
        map_mousearea.preventStealing=false;
    }

    //相当于取消操作
    function destroyTool(){
        //console.log("destroy tool")
        if(control.currentTool){
            //为什么不销毁而是隐藏？销毁的操作后面再设计！
            control.currentTool.visible=false;
        }
        control.closeTool();
    }
}
