import QtQuick 2.0

import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQml 2.0


InfoStatForm {
    property var locale: Qt.locale()
    property date curDate: new Date()
    property string del_str
    property int del_index
    property int day: 1
    property int today: curDate.getDate()
    function initial() {
        console.log("initial", curDate.getMonth())

        while(day <= today) {
            var tmp = curDate.toLocaleDateString(locale, "yyyy-MM") +
                    "-"
            if(day < 10)
                tmp = tmp + 0
            tmp = tmp + day
            console.log(tmp)
            if(api.day(tmp))
            {
                listModel.append({date: api.getDate(),
                                  start: api.getStart(),
                                  finish: api.getFinish(),
                                  startDinner: api.getStartDinner(),
                                  finishDinner: api.getFinishDinner(),
                                  message: api.getMessage()})
            }
            day++
        }
    }

    MouseArea {
        id: area
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 50
        onDoubleClicked: {
            initial()
        }
    }

    ListView {
        id: listView
        anchors.top: parent.top
        anchors.bottom: area.top
        anchors.left: parent.left
        anchors.right: parent.right
//        anchors.fill: parent

        /* in this property we specify the layout of the object
         * that will be displayed in the list as a list item
         * */
        delegate: Item {
            id: item
            anchors.left: parent.left
            anchors.right: parent.right
            height: 40

            Row {
              anchors.fill: parent
              spacing: 5
              Rectangle {
                  width: parent.width / 6
                  height: 40
                  color: "grey"
                  border.width: 5
                  radius: 10
                  Label {
                    id: label_data
//                  anchors.fill: parent
                    text: date
                  }
                  MouseArea {
                      anchors.fill: parent
                      onDoubleClicked: {
                          del_str = label_data.text
                          del_index = index
//                          if(api.del(label_data.text))
//                            listModel.remove(index)
//                          del_dialog.title = "Удалить " + del_str + " ?"
                          del_dialog.open()
                      }
                  }
              }
              Rectangle {
                  width: parent.width / 6
                  height: 40
                  color: "grey"
                  border.width: 5
                  radius: 10
                  Label {
                      id: label_start
                      text: start
                  }
                  MouseArea {
                      anchors.fill: parent
                      onDoubleClicked: {
                          changeDialog.date = label_data.text
                          changeDialog.num = 1
                          changeDialog.open()
                      }
                  }
              }
              Rectangle {
                  width: parent.width / 6
                  height: 40
                  color: "grey"
                  border.width: 5
                  radius: 10
                  Label {
                    text: finish
                  }
              }
              Rectangle {
                  width: parent.width / 6
                  height: 40
                  color: "grey"
                  border.width: 5
                  radius: 10
                  Label {
                    text: startDinner
                  }
              }
              Rectangle {
                  width: parent.width / 6
                  height: 40
                  color: "grey"
                  border.width: 5
                  radius: 10
                  Label {
                    text: finishDinner
                  }
              }
              Rectangle {
                  width: parent.width / 6
                  height: 40
                  color: "grey"
                  border.width: 5
                  radius: 10
                  Label {
                    text: message
                  }
              }
            }
        }

        model: ListModel {
            id: listModel
        }
    }

//    Connections {
//        target: api
//        onAddData: {
//            listModel.append({label_value: str})
//        }
//    }

    id: infoStatForm
    transform: Translate {
                  x: drawer.position * infoStatForm.width * 0.33
              }

    Dialog {
        id: changeDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        property string date
        property int num //Нумерация Api::Enum
        SetDigitalClock {
            anchors.fill: parent
            date_: changeDialog.date
            num_: changeDialog.num
        }
    }

    Dialog {
        id: del_dialog

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        RowLayout {
          anchors.right: parent.right
          anchors.rightMargin: 0

          ToolButton {
            text: qsTr("Нет")
            onClicked: del_dialog.reject()
          }

          ToolButton {
            text: qsTr("Да")
            onClicked: del_dialog.accept()
          }
        }
        standardButtons:  Dialog.Cancel | Dialog.Yes

        onAccepted: {
            if(api.del(del_str))
                listModel.remove(del_index)
        }
    }
}

