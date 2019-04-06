import QtQuick 2.0
import QtQuick.Controls 2.0

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("AgaTime")

    // Loader для смены Фрагментов
    Loader {
        id: loader
        anchors.fill: parent
        source: "SwipeView.qml"

        // Функция для смены содержимого Loader
        function loadFragment(index){

            switch(index){
            case 0:
                loader.source = "SwipeView.qml"
                break;
            case 1:
                loader.source = "InfoStat.qml"
                break;
            default:
                loader.source = "SwipeView.qml"
                break;
            }
        }
    }

    property alias drawer: drawer
    Drawer {
            id: drawer
            width: 0.66 * window.width
            height: window.height
            Rectangle {
                anchors.fill: parent
                color: "gray"

                // Список с пунктами меню
                ListView {
                    anchors.fill: parent

                    delegate: Item {
                        height: 48
                        anchors.left: parent.left
                        anchors.right: parent.right

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 5
                            color: "gray"

                            Text {
                                text: fragment
                                anchors.fill: parent
                                font.pixelSize: 20

                                renderType: Text.NativeRendering
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            MouseArea {
                                anchors.fill: parent

                                // По нажатию на пункт меню заменяем компонент в Loader
                                onClicked: {
                                    loader.loadFragment(index)
                                    drawer.close()
                                }
                            }
                        }
                    }
                    model: navModel
                }
            }
    }

    // Модель данных для списка с пунктами меню
    ListModel {
        id: navModel

        ListElement {fragment: "SwipeView"}
        ListElement {fragment: "InfoStat"}
    }
}
