import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import Quickshell
import Quickshell.Widgets
import "./Theme"
import "./Components"
import "./Animation"

Window {
    property int starting_y_offset: 100
    property int ears_height: 100
    property int ears_width: 150
    property int ears_margin: border_radius + border_width
    property real ears_border_width: 3
    property int ears_inner_margin: 25
    property color ears_inner_color: Theme.iris
    property real ears_inner_opacity: 0.8
    property int ears_inner_over: 10
    property int ears_radius: 6

    property int in_anim_len: 500
    property int out_anim_len: 500

    property int border_radius: 25
    property real border_width: 3 
    property string border_color: Theme.iris
    property real bg_opacity: 0.8

    property int rows: 5
    property int columns: 4

    property color search_text_color: Theme.foam
    property color placeholder_text_color: Theme.muted
    property color highlight_bg: Qt.rgba(Qt.color(Theme.iris).r, Qt.color(Theme.iris).g, Qt.color(Theme.iris).b, 0)
    property color highlight_text_color: Theme.foam
    property color highlight_border_color: Theme.iris

    function launchSelect() {
        if (grid.currentItem && grid.currentItem.modelData) {
            grid.currentItem.modelData.execute()
            quit_anim.running = true
        }
    }

    id: rootWin

    y: Screen.height + height
    x: Screen.width/2 - width/2
    width: 800 
    height: 500 + ears_height 
    color: "transparent"
    title: "very_simple_app_lanucher"
    opacity: 0

    visible: false
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    
    
    /* quit when window lost focus */
    onActiveChanged: {
        if (!active) quit_anim.running = true
    }
    
    /* background */
    Rectangle {
        id: bg
        anchors.fill: parent
        anchors.topMargin: rootWin.ears_height
        radius: rootWin.border_radius
        color: Theme.base
        TextField {
                id: filter
                anchors.horizontalCenter: parent.horizontalCenter
                y: 15
                placeholderText: "Search your applications..."
                placeholderTextColor: rootWin.placeholder_text_color
                color: rootWin.search_text_color
                focus: true
                
                padding:15

                font{
                    family: "mononoki"
                    pixelSize: 20
                }
                background: Rectangle {
                color{
                    r: Qt.color(Theme.overlay).r
                    g: Qt.color(Theme.overlay).g
                    b: Qt.color(Theme.overlay).b
                    a: 0.3
                }
                    radius: 12
                    border {
                        width: 2
                        color: Theme.overlay
                    }
                }
                /* key stuffs */
                Keys.onPressed: (event) => {
                    const ctrl = event.modifiers & Qt.ControlModifier

                    if (event.key === Qt.Key_Right || (event.key === Qt.Key_N && ctrl)) {
                        if (grid.currentIndex < grid.count - 1) {
                            grid.currentIndex += 1
                            event.accepted = true
                        } else { grid.currentIndex = grid.count - 1;  event.accepted = true }
                    }

                    if (event.key === Qt.Key_Left || (event.key === Qt.Key_P && ctrl)) {
                        if (grid.currentIndex > 0) {
                            grid.currentIndex -= 1
                            event.accepted = true
                        } else { grid.currentIndex = 0;  event.accepted = true }
                    }

                    if (event.key === Qt.Key_Down) {
                        if (grid.currentIndex + rootWin.rows < grid.count - 1) {
                            grid.currentIndex += rootWin.rows
                            event.accepted = true
                        } else { grid.currentIndex = grid.count - 1;  event.accepted = true }
                    }

                    if (event.key === Qt.Key_Up) {
                        if (grid.currentIndex > rootWin.rows) {
                            grid.currentIndex -= rootWin.rows
                            event.accepted = true
                        } else { grid.currentIndex = 0 ;  event.accepted = true }
                    }
                    if (event.key === Qt.Key_Return) {
                        rootWin.launchSelect()
                        event.accepted = true
                    }
                }
                onTextChanged: {
                    Qt.callLater(() => {
                    grid.currentIndex = filter_model.values.length > 0 ? 0 : -1
                
            })}
            }
        /* quit on pressing escape */
        Keys.onEscapePressed:{ 
            quit_anim.running = true 
            
        }
    }
    /* ears*/
    Item {
        id: ears
        anchors.top: parent.top
        height: rootWin.ears_height + 50
        width: rootWin.width 
        layer.enabled: true
        layer.samples: 5

        /* lines */
        Shape{
            ShapePath{
                strokeColor: Theme.iris
                strokeWidth: 3
                strokeStyle: ShapePath.SolidLine

                startX: rootWin.ears_margin + rootWin.ears_width + rootWin.border_width / 2
                startY: rootWin.ears_height + rootWin.border_width / 2
                PathLine {
                    x: rootWin.width - rootWin.ears_width - rootWin.ears_margin - rootWin.border_width / 2
                    y: rootWin.ears_height + rootWin.border_width / 2
                }
            }
            ShapePath{
                strokeColor: Theme.iris
                strokeWidth: 3
                strokeStyle: ShapePath.SolidLine
                fillColor: "transparent"

                startX: rootWin.border_width / 2
                startY: rootWin.border_radius + rootWin.ears_height + rootWin.border_width / 2
                PathArc {
                    radiusX: rootWin.border_radius
                    radiusY: rootWin.border_radius 
                    x: rootWin.border_radius + rootWin.border_width / 2
                    y: rootWin.ears_height + rootWin.border_width / 2
                }
            }
            ShapePath{
                strokeColor: Theme.iris
                strokeWidth: 3
                strokeStyle: ShapePath.SolidLine
                fillColor: "transparent"

                startX: rootWin.width - rootWin.border_radius - rootWin.border_width / 2
                startY: rootWin.ears_height + rootWin.border_width / 2
                PathArc {
                    radiusX: rootWin.border_radius
                    radiusY: rootWin.border_radius 
                    x: rootWin.width - rootWin.border_width / 2
                    y: rootWin.border_radius + rootWin.ears_height + rootWin.border_width / 2
                }
            }
        
        }
        /* left ear */
        Shape {
            anchors.left: parent.left
            anchors.leftMargin: rootWin.ears_margin
            height: rootWin.ears_height
            width: rootWin.ears_width
            antialiasing: true
            smooth: true
            
            ShapePath {
                strokeColor: Theme.iris
                strokeStyle: ShapePath.SolidLine
                
                strokeWidth: rootWin.ears_border_width
                fillColor{
                    r: Qt.color(Theme.base).r
                    g: Qt.color(Theme.base).g
                    b: Qt.color(Theme.base).b
                    a: rootWin.bg_opacity
                }
                startX: 0
                startY: rootWin.ears_height
                PathLine { x: 0; y: rootWin.ears_height }
                PathLine { x: rootWin.ears_width / 2 - rootWin.ears_radius; y: 0 + 5 }
                PathArc {
                    x: rootWin.ears_width / 2 + rootWin.ears_radius
                    y: 0 + rootWin.ears_radius
                    radiusX: rootWin.ears_radius + rootWin.ears_radius/5
                    radiusY: rootWin.ears_radius
                }
                PathLine { x: rootWin.ears_width ; y: rootWin.ears_height }
            }
            // inner ear
            ShapePath {
                strokeColor: "transparent"
                fillColor{
                    r: Qt.color(rootWin.ears_inner_color).r
                    g: Qt.color(rootWin.ears_inner_color).g
                    b: Qt.color(rootWin.ears_inner_color).b
                    a: rootWin.ears_inner_opacity
                }
                startX: rootWin.ears_inner_margin - rootWin.ears_inner_over / 2
                startY: rootWin.ears_height + rootWin.ears_inner_over
                PathLine { x: rootWin.ears_width / 2 - rootWin.ears_radius ; y: rootWin.ears_inner_margin + rootWin.ears_inner_margin / 4 + 5}
                PathArc {
                    x: rootWin.ears_width / 2 + rootWin.ears_radius 
                    y: rootWin.ears_inner_margin + rootWin.ears_inner_margin / 4 + rootWin.ears_radius
                    radiusX: rootWin.ears_radius + rootWin.ears_radius/5
                    radiusY: rootWin.ears_radius
                }
                PathLine { x: rootWin.ears_width - rootWin.ears_inner_margin + rootWin.ears_inner_over / 2; y: rootWin.ears_height + rootWin.ears_inner_over}
            }
        }
        /* right ear */
        Shape {
            anchors.right: parent.right
            anchors.rightMargin: rootWin.ears_margin
            height: rootWin.ears_height
            width: rootWin.ears_width
            antialiasing: true
            ShapePath {
                strokeColor: Theme.iris
                strokeStyle: ShapePath.SolidLine
                
                strokeWidth: rootWin.ears_border_width
                fillColor{
                    r: Qt.color(Theme.base).r
                    g: Qt.color(Theme.base).g
                    b: Qt.color(Theme.base).b
                    a: rootWin.bg_opacity
                }
                startX: 0
                startY: rootWin.ears_height
                PathLine { x: 0; y: rootWin.ears_height }
                PathLine { x: rootWin.ears_width / 2 - rootWin.ears_radius; y: 0 + 5 }
                PathArc {
                    x: rootWin.ears_width / 2 + rootWin.ears_radius
                    y: 0 + rootWin.ears_radius
                    radiusX: rootWin.ears_radius + rootWin.ears_radius/5
                    radiusY: rootWin.ears_radius
                }
                PathLine { x: rootWin.ears_width ; y: rootWin.ears_height }
            }
            // inner ear
            ShapePath {
                strokeColor: "transparent"
                fillColor{
                    r: Qt.color(rootWin.ears_inner_color).r
                    g: Qt.color(rootWin.ears_inner_color).g
                    b: Qt.color(rootWin.ears_inner_color).b
                    a: rootWin.ears_inner_opacity
                }
                startX: rootWin.ears_inner_margin - rootWin.ears_inner_over / 2
                startY: rootWin.ears_height + rootWin.ears_inner_over
                PathLine { x: rootWin.ears_width / 2 - rootWin.ears_radius ; y: rootWin.ears_inner_margin + rootWin.ears_inner_margin / 4 + 5}
                PathArc {
                    x: rootWin.ears_width / 2 + rootWin.ears_radius 
                    y: rootWin.ears_inner_margin + rootWin.ears_inner_margin / 4 + rootWin.ears_radius
                    radiusX: rootWin.ears_radius + rootWin.ears_radius/5
                    radiusY: rootWin.ears_radius
                }
                PathLine { x: rootWin.ears_width - rootWin.ears_inner_margin + rootWin.ears_inner_over / 2; y: rootWin.ears_height + rootWin.ears_inner_over}
            }
        }
    }


    /* clipping mask + lines */
    Rectangle {
        id: clip
        clip: true
        anchors.fill: parent
        anchors.topMargin: rootWin.ears_height + rootWin.border_width + rootWin.border_radius
        color: "transparent"


    /* main rectangle (search panel) */
    Rectangle {
        anchors.fill: parent
        anchors.topMargin: -rootWin.border_width - rootWin.border_radius
        radius: rootWin.border_radius
        color: "transparent"
        border.width: rootWin.border_width
        border.color: rootWin.border_color
        

            Component {
                id: entryDeli

                Item {
                    id: entry_root
                    required property var modelData
                    required property var index 
                    property real img_scale: 1
                    property color text_color: Theme.text
                    property int y_img

                    width: grid.cellWidth
                    height: grid.cellHeight

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        grid.currentIndex = parent.index
                    }
                    onDoubleClicked: {
                        grid.currentIndex = parent.index
                        rootWin.launchSelect()
                    }

                    HoverHandler {
                        id: hh
                        acceptedDevices: PointerDevice.Mouse

                        onHoveredChanged: {
                            if (hh.hovered) {
                                entry_root.y_img = -10
                                entry_root.img_scale = 1.2
                                entry_root.text_color = rootWin.highlight_text_color
                            }
                            if (!hh.hovered && grid.currentIndex != entry_root.index) {
                                entry_root.img_scale = 1
                                entry_root.text_color = Theme.text
                                entry_root.y_img = 0
                            }
                        }
                    }
                    }
                

                Column {
                    id: entry_col
                    property var modelData: parent.modelData
                    property var index: parent.index 

                    property real img_scale: parent.img_scale
                    property color text_color: parent.text_color
                    property int y_img: parent.y_img

                    transform: Translate{
                        y: entry_col.y_img
                    }
                        Behavior on y_img {
                            NumberAnimation{
                                duration: 200
                                easing.type: Easing.OutBack
                                easing.overshoot: 5
                            }
                        }

                    spacing: -y_img 

                    width: grid.width / 5
                    height: grid.height / 3



                    Image {
                        scale: entry_col.img_scale
                        Behavior on scale {
                            ScaleAnimator{
                                duration: 200
                                easing.type: Easing.OutBack
                                easing.overshoot: 5
                            }
                        }

                        width: 90
                        height: 90
                        source: Quickshell.iconPath(modelData.icon, true)
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: modelData.name
                        font.pixelSize: 15
                        font.bold: true
                        color: entry_col.text_color
                        width: parent.width - 10
                        anchors.horizontalCenter: parent.horizontalCenter
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter

                        Behavior on color {
                            ColorAnimation{
                                duration: 200
                            }
                        }
                    }
                }
                }
            }
            Item {
                anchors {
                    fill: parent
                    topMargin: 65
                    margins: 20
                }
                clip: true

            GridView {
                id: grid
                y: 20
                width: parent.width
                height: parent.height - 20

                highlight: Rectangle {
                    color: rootWin.highlight_bg
                    radius: 12
                    border.width: 2
                    border.color: rootWin.highlight_border_color
                }
                highlightMoveDuration: 120
                cellWidth: width/5
                cellHeight: height/3
                delegate: entryDeli
                keyNavigationWraps: true
                currentIndex: filter_model.values.length > 0 ? 0 : -1;
                snapMode: GridView.SnapToRow

                property var last_item

                model: grid.model_ready ? filter_model : null
                
                property bool model_ready: false
                ScriptModel {
                    id: filter_model
                    values: {
                        const Entries = [...DesktopEntries.applications.values]
                        .filter(e => e.name)
                        .sort((a, b) => a.name.localeCompare(b.name))

                        const q = filter.text.trim().toLowerCase()
                        if (q === "") {
                            return  Entries 
                        } else {
                            return Entries.filter(e => e.name && e.name.toLowerCase().includes(q))
                        }
                    }
                }
                Timer {
                    interval: 50
                    repeat: false
                    running: true
                    onTriggered: {
                        grid.model_ready = true
                    }
                }
                onCurrentItemChanged: {
                    if (grid.currentItem) {
                        grid.currentItem.y_img = -10
                        grid.currentItem.img_scale = 1.2
                        grid.currentItem.text_color = rootWin.highlight_text_color
                    }
                    if (last_item) {
                        last_item.img_scale = 1
                        last_item.text_color = Theme.text
                        last_item.y_img = 0
                    }
                    last_item = currentItem
                }
                // animations
                property bool ready: false
                Timer {
                    interval: rootWin.in_anim_len
                    repeat: false
                    onTriggered: {
                        grid.ready = true
                    }
                    running: true
                }
                add: ready ? add_trans : null

                Transition{
                    id: add_trans
                    NumberAnimation{
                        properties: "scale"
                        from: 0
                        to: 1
                        duration: 200
                        easing.type: Easing.OutQuad
                    }
                }


                remove: Transition{  
                    ParallelAnimation{
                        NumberAnimation {
                            property: "opacity"
                            to: 0
                            duration: 200
                            easing.type: Easing.OutQuad
                        }
                        NumberAnimation{
                            properties: "scale"
                            from: 1
                            to: 0
                            duration: 150
                            easing.type: Easing.InQuad
                        }
                }

            }
            }
            }
        

            
        

        }
    }


    /* exit animation */
    ParallelAnimation {
        id: quit_anim
        Quit {
            target: rootWin
            from: rootWin.y
            to: Screen.height
            duration: rootWin.out_anim_len

        }
        NumberAnimation {
            target: rootWin
            property: "opacity"
            from: 1
            to: 0
            duration: rootWin.out_anim_len
            easing.type: Easing.InQuad
        }
        onFinished: {
            rootWin.x = Screen.width / 2 - rootWin.width / 2
            rootWin.visible = false
            Qt.quit()
        }
    }


        // PauseAnimation{
        //     id: tiny_pause
        //     duration: rootWin.in_anim_len / 5
        //     onFinished: {
        //         rootWin.visible = true
        //         bg.color.a = rootWin.bg_opacity
        //     }

        //     running: true
        // }

    ParallelAnimation {
        id: go_up_anim
        running: true
        
        onStarted: {
            rootWin.visible = true
            bg.color.a = rootWin.bg_opacity
        }
        NumberAnimation{
            target: rootWin
            property: "y"
            duration: rootWin.in_anim_len
            from: Screen.height + rootWin.height
            to: Screen.height/2 - rootWin.height / 2
            easing.type: Easing.OutBack
            easing.overshoot: 1.0
            easing.amplitude: 0.5
        }
        NumberAnimation {
            target: rootWin
            property: "opacity"
            from: 0
            to: 1
            easing.type: Easing.OutQuad
            duration: rootWin.in_anim_len
        }
    }

        
}