import QtQuick

NumberAnimation{
    property: "y"
    
    duration: 500
    easing.type: Easing.InBack
    easing.overshoot: 1.0
    easing.amplitude: 0.5
}