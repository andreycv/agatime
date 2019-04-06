import QtQuick 2.0
import QtQuick.Controls 2.0
//import QtQuick.Window 2.0
//import QtQuick.Layouts 1.1

SwipeView {
    id: swipeView
    anchors.fill: parent

    MainPage {
    }

    Graph {
    }

    transform: Translate {
                  x: drawer.position * swipeView.width * 0.33
              }
}
