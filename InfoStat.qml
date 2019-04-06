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

    Label {
        id: area
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 50
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: "Double click to update"

        MouseArea {
            anchors.fill: parent
            onDoubleClicked: {
                parent.visible = false
                initial()
            }
        }
    }

    ListView {
        id: listView
        anchors.top: parent.top
        anchors.bottom: area.top
        anchors.left: parent.left
        anchors.right: parent.right

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
                      text: date
                    }
                    MouseArea {
                        anchors.fill: parent
                        onDoubleClicked: {
                            del_str = label_data.text
                            del_index = index
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

