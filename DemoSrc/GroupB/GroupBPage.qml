import QtQuick 2.12
import QtQuick.Controls 2.12
import QtLocation 5.12
import QtPositioning 5.12

//一个简略的地图页面，包含工具栏，地图等
Item {
    id: control

    Row{
        id:tab_bar
        width: parent.width
        RadioButton {
            checked: true
            text: qsTr("View")
            onClicked: map.switchComp(null);
        }
        RadioButton {
            text: qsTr("Ruler")
            Component{
                id: ruler_comp
                BRulerTool{
                    lineColor: "green"
                    lineWidth: 3
                }
            }
            onClicked: map.switchComp(ruler_comp);
        }
        RadioButton {
            text: qsTr("Area")
            Component{
                id: area_comp
                BAreaTool{
                }
            }
            onClicked: map.switchComp(area_comp);
        }
        RadioButton {
            text: qsTr("Polygon")
            Component{
                id: polygon_comp
                BPolygonTool{
                }
            }
            onClicked: map.switchComp(polygon_comp);
        }
        RadioButton {
            text: qsTr("Rectangle")
            Component{
                id: rectangle_comp
                BRectangleTool{
                }
            }
            onClicked: map.switchComp(rectangle_comp);
        }
        RadioButton {
            text: qsTr("Circle")
            Component{
                id: circle_comp
                BCircleTool{
                }
            }
            onClicked: map.switchComp(circle_comp);
        }
    }

    BMap{
        id: map
        anchors.fill: parent
        anchors.topMargin: tab_bar.height
    }
}
