import QtQuick 2.12
import QtQuick.Controls 2.12
import QtLocation 5.12
import QtPositioning 5.12

//一个简略的地图页面，包含工具栏，地图等
Item {
    id: control

    property Component currentComp: null
    property BAbstractTool currentTool: null

    Row{
        id:tab_bar
        width: parent.width
        RadioButton {
            checked: true
            text: qsTr("View")
            onClicked: control.switchComp(null);
        }
        RadioButton {
            text: qsTr("Ruler")
            Component{
                id: ruler_comp
                BRulerTool{}
            }
            onClicked: control.switchComp(ruler_comp);
        }
        /*RadioButton {
                text: qsTr("Area")
            }*/
    }

    BMap{
        id: map
        anchors.fill: parent
        anchors.topMargin: tab_bar.height

        MouseArea{
            id: map_mousearea
            anchors.fill: parent
            enabled: control.currentComp!=null
            hoverEnabled: true

            onClicked: {
                if(!control.currentTool&&control.currentComp)
                    control.createTool();
                if(control.currentTool)
                    control.currentTool.clicked(mouseX,mouseY);
            }
            onDoubleClicked: {
                if(control.currentTool)
                    control.currentTool.doubleClicked(mouseX,mouseY);
                control.closeTool();
            }
            onPositionChanged: {
                if(control.currentTool)
                    control.currentTool.positionChanged(mouseX,mouseY);
            }
        }
    }

    //相当于切换操作类型/模式，null的话就是浏览地图没操作
    function switchComp(tool_comp){
        //console.log("switch comp")
        control.currentComp=tool_comp;
        if(!control.currentComp)
            closeTool();
    }

    //相当于一次操作开始
    function createTool(){
        //console.log("create tool")
        if(control.currentTool)
            closeTool();
        let new_tool=control.currentComp.createObject(map);
        if(new_tool){
            control.currentTool=new_tool;
            control.currentTool.targetMap=map;
            map.addMapItemGroup(control.currentTool);
        }
    }

    //相当于一次操作结束
    function closeTool(){
        //console.log("close tool")
        control.currentTool=null;
    }
}
