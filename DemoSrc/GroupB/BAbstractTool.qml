import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

//MapTool目前全部派生自MapItemGroup
MapItemGroup {
    id:control

    //用于MouseArea，如果为true，则事件不会被偷取
    property bool preventStealing: false
    //用于计算
    property Map targetMap: null

    //对应MouseArea的信号，传递给派生类
    signal clicked(int x,int y);
    signal doubleClicked(int x,int y);
    signal positionChanged(int x,int y);
    signal pressed(int x,int y);
    signal released(int x,int y);

    //传递给外部，用来指定操作结束
    signal finished();
}
