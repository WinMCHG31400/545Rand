import QtQuick
import Qt5Compat.GraphicalEffects

Window{
    id:root
    flags:Qt.FramelessWindowHint|Qt.Window
    color: "#00000000"
    x:root.screen.width/2-width/2
    y:root.screen.height/2-height/2
    width: 320
    height: 330
    minimumHeight: height
    maximumHeight: height
    minimumWidth: width
    maximumWidth: width
    title: "545抽号器>关于"
    Rectangle{
        anchors.fill: parent
        border.color: "#80808080"
        border.width: 2
    }
    Item{
        x:2
        y:2
        Rectangle{
            width: root.width-4
            height: 30
            color:"#BBBBBB"
            Image{
                source:"qrc:/545rand.svg"
                width: 30
                height: 30
            }
            Text{
                x:32
                y:2
                text:root.title
                font.pixelSize: 20
            }
            DelButton{
                x:root.width-36
                y:-3
                width: 30
                height: 30
                text: "×"
                colorBg: "#00000000"
                colorBorder: "#00000000"
                font.pixelSize: 30
                padding: 0
                type:6
                topPadding: 8
                onClicked: {
                    root.visible=false
                }
            }
            Item{
                width: root.width-36
                height: 30
                MouseArea {
                    anchors.fill: parent
                    property int dragX
                    property int dragY
                    property bool dragging
                    onPressed: {
                        dragX = mouseX
                        dragY = mouseY
                        dragging = true
                    }
                    onReleased: {
                        dragging = false
                    }
                    onPositionChanged: {
                        if (dragging) {
                            root.x += mouseX - dragX
                            root.y += mouseY - dragY
                        }
                    }
                }
            }
            Item{
                y:20
                Item{
                    x:20
                    y:15
                    Image {
                        y:5
                        width: 70
                        height: 70
                        source: "qrc:/545rand.svg"
                    }
                    Text{
                        x:70
                        y:20
                        font.pixelSize: 20
                        text:"545Rand v0.1"
                    }
                    Text {
                        x:70
                        y:40
                        text: "(547抽号器545特供版)"
                    }
                }
                Item{
                    x:20
                    y:100
                    Image {
                        width: 70
                        height: 70
                        source: "qrc:/Qt.png"
                    }
                    Text{
                        x:70
                        y:15
                        font.pixelSize: 20
                        text:"Made with Qt6 (qml)"
                    }
                    Text {
                        x:70
                        y:35
                        text: "(Desktop Qt 6.8.3 MinGW 64-bit)"
                    }
                }
                Item{
                    x:20
                    y:180
                    Image {
                        width: 60
                        height: 60
                        source: "qrc:/winmchg31400.jpg"
                    }
                    Text{
                        x:70
                        y:8
                        font.pixelSize: 20
                        text:"Made by"
                    }
                    Text {
                        x:70
                        y:31
                        font.pixelSize: 20
                        text: "WinMCHG31400"
                    }
                }
                Item{
                    y:260
                    DelButton{
                        text:"源代码"
                        font.pixelSize: 16
                        width: 100
                        x:30
                        height: 25
                        onClicked: Qt.openUrlExternally("https://github.com/WinMCHG31400/545Rand")
                    }
                    DelButton{
                        text:"547官网"
                        font.pixelSize: 16
                        width: 100
                        x:180
                        height: 25
                        onClicked: Qt.openUrlExternally("https://lazxg547b.pages.dev")
                    }
                }
            }
        }
    }
}
