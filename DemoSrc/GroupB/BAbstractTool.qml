import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

//MapTool目前全部派生自MapItemGroup
MapItemGroup {
    id:control

    property Map targetMap: null

    //对应MouseArea的信号
    signal clicked(int x,int y);
    signal doubleClicked(int x,int y);
    signal positionChanged(int x,int y);
}
