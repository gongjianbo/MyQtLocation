import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id: root_window
    visible: true
    width: 640
    height: 480
    title: qsTr("【QQ交流群:647637553】"+root_loader.source)

    Loader{
        id: root_loader
        anchors.fill: parent
        source: "qrc:/GroupBPage.qml"
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("GroupA")
            Action { text: "MyMap"; onTriggered: root_loader.setSource("qrc:/AMyMap.qml"); }
            MenuSeparator { }
            Action { text: "MapRuler"; onTriggered: root_loader.setSource("qrc:/AMapRuler.qml"); }
            Action { text: "MapArea"; onTriggered: root_loader.setSource("qrc:/AMapArea.qml"); }
        }
        Menu {
            title: qsTr("GroupB")
            Action { text: "GroupBPage"; onTriggered: root_loader.setSource("qrc:/GroupBPage.qml"); }
        }
    }
}
