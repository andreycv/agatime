import QtQuick 2.0

import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQml 2.0

MainPageForm {
    property var varList: []
    property bool commentWasChanged: false
    GridLayout {
        id:gridLayout
        columns: 2

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        Label {
            id: start
            width: 252
            height: 127
            text: api.getStart()
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: true
        }

        Label {
            id: finish
            width: 252
            height: 127
            text: api.getFinish()
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: true
        }
        Label {
            id: startDinner
            width: 252
            height: 127
            text: api.getStartDinner()
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: true
        }
        Label {
            id: finishDinner
            width: 252
            height: 127
            text: api.getFinishDinner()
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: true
        }
        Label {
            id: data
            width: 252
            height: 127
            text: api.getDate()
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: true
        }
        TextArea {
            id: message
            width: 652
            height: 127
            text: api.getMessage()

            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: true
            onFocusChanged: {
                console.log("onEditingFinished")
                commentWasChanged = true
            }
        }
        Button {
            id: button_update
            height: 50
            text: "Update"
            width: parent.width * 3 / 4
            visible: start.text === ""
            onClicked: {
                if(!api.day())
                    return
                start.text = api.getStart()
                finish.text = api.getFinish()
                startDinner.text = api.getStartDinner()
                finishDinner.text = api.getFinishDinner()
            }
        }
        Button {
            id: messageButton
            text: "send message"
            visible: commentWasChanged && !startButton.enabled
            onClicked: {
                if(api.setMessage(message.text))
                    visible = false
            }
        }
    }
    Row {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        Button {
            id: startButton
            width: (parent.width / 4)
            text: "start"
            enabled: start.text === ""
            onClicked: {
                enabled = false
                console.log("start")
                if(api.setStart()) {
                    start.text = api.getStart()
                    data.text = api.getDate()
                }
                if(commentWasChanged)
                    api.setMessage(message.text)
            }
        }
        Button {
            id: finishButton
            width: (parent.width / 4)
            text: "finish"
            enabled: start.text !== "" && finish.text === ""
            onClicked: {
                console.log("finish")
                if(api.setFinish()) {
                    finish.text = api.getFinish()
                }
                if(commentWasChanged)
                    api.setMessage(message.text)
            }
        }
        Button {
            id: startDinnerButton
            width: (parent.width / 4)
            text: "startDinner"
            enabled: start.text !== "" && startDinner.text === ""
            onClicked: {
                console.log("startDinner")
                if(api.setStartDinner()) {
                    startDinner.text = api.getStartDinner()
                }
                if(commentWasChanged)
                    api.setMessage(message.text)
            }
        }
        Button {
            id: finishDinnerButton
            width: (parent.width / 4)
            text: "finishDinner"
            enabled: start.text !== "" && finishDinner.text === ""
            onClicked: {
                console.log("finishDinner")
                if(api.setFinishDinner()) {
                    finishDinner.text = api.getFinishDinner()
                }
                if(commentWasChanged)
                    api.setMessage(message.text)
            }
        }
    }
}
