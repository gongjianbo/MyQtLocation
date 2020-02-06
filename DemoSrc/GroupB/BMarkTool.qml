import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

// 连续标记点
BAbstractTool{
    id: control

    property real itemZoomLevel: 0.0
    //mark的item可以设置
    property Component itemDelegate: Component{
        Rectangle {
            width: 14
            height: 14
            radius: 7
            color: "red"
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
            zoomLevel: control.itemZoomLevel
            sourceItem: Loader{
                sourceComponent: control.itemDelegate
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
            item_model.append({"latitudeval":coord.latitude,"longitudeval":coord.longitude});
        }
    }
    onDoubleClicked: {
        if(targetMap){
            control.finished(); //结束
        }
    }
}

