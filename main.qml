import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id: root_window
    visible: true
    width: 640
    height: 480
    title: qsTr("Gong Jian Bo 1992【QQ交流群:647637553】")

    Loader{
        id: root_loader
        anchors.fill: parent
        source: "qrc:/AMyMap.qml"
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

        }
    }
}
