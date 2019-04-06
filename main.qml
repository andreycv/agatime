import QtQuick 2.0
import QtQuick.Controls 2.0
//import QtQuick.Window 2.0
//import QtQuick.Layouts 1.1

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("AgaTime")

    // Пересчёт независимых от плотности пикселей в физические пиксели устройства
//    readonly property int dpi: Screen.pixelDensity * 25.4
//    function dp(x){ return (dpi < 120) ? x : x*(dpi/160); }

//     Loader для смены Фрагментов
    Loader {
        id: loader
        anchors.fill: parent
        source: "InfoStat.qml"

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
                        height: 48//dp(48)
                        anchors.left: parent.left
                        anchors.right: parent.right

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 5//dp(5)
                            color: "gray"

                            Text {
                                text: fragment
                                anchors.fill: parent
                                font.pixelSize: 20//dp(20)

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
