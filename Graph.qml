import QtQuick 2.0

GraphForm {
    Spinner {
        id: rowSpinner
        label: "Часы"
        onValueChanged: {
            console.log(value)
//            resultText.text = "Loading...";
//            myWorker.sendMessage( { row: rowSpinner.value, column: columnSpinner.value } );
        }
    }
}
