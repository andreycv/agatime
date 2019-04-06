import QtQuick 2.0

import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQml 2.0

RowLayout {
    property string date_
    property int num_ //Нумерация Api::Enum
    Spinner {
        id: h
        width: parent.width / 3
        height: parent.height
        label: "Часы"
        isHour: true
    }

    Spinner {
        id: m
        width: parent.width / 3
        height: parent.height
        label: "Минуты"
        isHour: false
    }

    Button {
        id: apply
        text: "Apply"
        width: parent.width / 3
        height: parent.height
        property string str: ""
        property date curDate: new Date()
        onClicked: {
            str = ""
            if(h < 10)
                str = str + "0"
            str = str + h + ":"
            if(m < 10)
                str = str + "0"
            str = str + m + ":00"
//            console.log(h.value, m.value, str, date_, num_)
            api.update(date_, str.toLocaleString(), num_)
        }
    }
//    Button {
//        id: reject
//        text: "Cancel"
//        width: parent.width / 4
//        height: parent.height
//        onClicked: {
//            console.log("Cancel")
//        }
//    }

}
