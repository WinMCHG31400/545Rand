import QtQuick
import QtQuick.Controls
import QtQuick.Window
import GFile
import QtQuick.Dialogs
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import Qt.labs.platform
ApplicationWindow {
    id: window
    flags: Qt.FramelessWindowHint|Qt.Window|(top_btn.checked?Qt.WindowStaysOnTopHint:0)
    visible:true
    width: 584
    height: 334
    color: "#00000000"
    title: "545抽号器"
    property int sumn:0
    property int nummm: 1
    property int sim
    property int cclass:0
    property string name
    property var nN_names:[]
    property var names:[]
    property var names_:[]
    property bool start:true
    onClosing: file.save()
    Component.onCompleted:  {
        load()
    }
    function load(){
        file.source="./setting.json"
        var data=JSON.parse(file.read())
        names=data.names
        switch(data.tx){
        case 1:
            a2.checked=true
            break
        case 2:
            a2.checked=true
            break
        case 3:
            a3.checked=true
            break
        }
        nN.setValue(data.n)
        a3.first=data.first
        top_btn.checked=data.top
        start=false
    }

    GMesenger{
        id:mesenge
        z:46578
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -130
        x:20
        y:20
        onFocusChanged: {
            if(!mesenge.focus)
                mesenge.enabled=false
        }
    }
    GFile{
        id:file
        function output(){
            source=getDesktop()+"/545Rand-output-"+ Qt.formatDateTime(new Date(), "yy-mm-dd-hh-mm-ss")+".txt"
            write(output.text)
            mesenge.show("已导出到"+source,4000)
        }
        function save(){
            var tx
            if(a1.checked)tx=1
            else if(a2.checked)tx=2
            else tx=3
            var settingsData ={
                "names": names,
                "tx":tx,
                "n":nN.value,
                "first":a3.first,
                "top":top_btn.checked
            }
            var jsonString = JSON.stringify(settingsData, null, 4)
            file.source="./setting.json"
            file.write(jsonString)
        }
    }
    function cou(){
        var b=Math.floor(Math.random() * names.length)
        return names[b]
    }
    function coul(){
        var b;
        b=Math.floor(Math.random() * names_.length)
        var s=names_[b]
        for(var i=b;i<names_.length-1;i++)
        {
            names_[i]=names_[i+1]
        }
        names_.pop()
        return s

    }

    Window{
        id:full
        flags:Qt.WindowStaysOnTopHint
        color: "#00000000"
        visible: false
        Component.onCompleted: {
            for(var i=0;i<names.length;i++)
            {
                gcs.push(gCard.createObject(full))
                gcs[i].visible=false

            }
        }
        Rectangle{
            id:full_back
            anchors.fill: parent
            opacity:0
            Behavior on opacity {enabled:true; NumberAnimation { easing.type: Easing.OutBack; duration: 600 } }
            color: "#EF000000"
            Text{
                id:full_te
                text:"单击任意位置继续"
                Behavior on opacity {enabled:true; NumberAnimation {duration: 1200 } }
                color: "#FFFFFF"
                opacity: 0
                font.pixelSize: 40
                font.bold: true
                anchors.centerIn: parent
                anchors.verticalCenterOffset: parent.height/2-50
                anchors.horizontalCenterOffset: parent.width/2-200
            }
        }
        MouseArea{
            anchors.fill: parent
            z:99
            onClicked: {
                var a
                if(full_timer.i<12)
                    full_timer.i=11
                else if(full_timer.i<50)
                    full_timer.i=49
                else if(full_timer.i<57)
                    full_timer.i=56
                full_timer.running=true
            }
        }

        Component{
            id:gCard
            Image{
                z:10
                source:"qrc:/545b.svg"
                property bool thise:false
                property string text
                Behavior on scale {enabled:true; NumberAnimation { easing.type: Easing.OutBack; duration: thise?1200:600 } }
                Behavior on opacity {enabled:true; NumberAnimation { easing.type: Easing.OutBack; duration: thise?1200:600 } }
                Behavior on anchors.verticalCenterOffset {enabled:true; NumberAnimation { easing.type: Easing.OutBack; duration: thise?1200:600 } }
                Behavior on anchors.horizontalCenterOffset {enabled:true; NumberAnimation { easing.type: Easing.OutBack; duration: thise?1200:600 } }
                Text{
                    text:parent.text
                    font.pixelSize: 170
                    font.bold: true
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -30
                }
            }
        }
        property var gcc
        property var gcs:[]
        Item{
            id:ro
            width: parent.width
            height: parent.width
            anchors.centerIn: parent
            scale: 0.0
            property bool thise:true
            Behavior on scale {enabled:ro.thise; NumberAnimation {duration: 1200 } }
            Behavior on opacity {enabled:ro.thise; NumberAnimation { easing.type: Easing.OutBack; duration: 4800 } }
            RadialGradient {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0; color: "#FFFFFFFF" }
                    GradientStop { position: 0.5; color: "#00FFFFFF" }
                }
            }
        }
        Timer{
            id:full_timer
            interval: 100
            repeat: true
            property int i:0
            onTriggered: {
                i++
                switch(i){
                case 12:
                    full.gcc.visible=true
                    full.gcc.thise=true
                    full.gcc.anchors.verticalCenterOffset=0
                    full.gcc.opacity=1
                    full.gcc.scale=0.7
                    ro.opacity=0
                    break
                case 18:
                    full_te.opacity=0.8
                    break
                case 34:
                    full_te.opacity=0
                    break
                case 46:
                    i=17
                    break
                case 50:
                    full.gcc.thise=false
                    full.gcc.anchors.verticalCenterOffset=(Math.random() > 0.5 ? 1 : -1)*full.height/2*(1+Math.random())
                    full.gcc.anchors.horizontalCenterOffset=(Math.random() > 0.5 ? 1 : -1)*full.width/2*(1+Math.random())
                    full.gcc.opacity=0
                    full.gcc.scale=0
                    full_back.opacity=0
                    full_te.opacity=0
                    break
                case 53:
                    c1.finish(name)
                    break
                case 56:
                    full.visible=false
                    ro.scale=0
                    ro.opacity=0
                    full.gcc.destroy()
                    running=false
                }
            }
        }

        function startS(name){
            full.visibility=Window.FullScreen
            ro.thise=false
            ro.scale=0
            ro.opacity=0
            gcc=gCard.createObject(full)
            full_back.opacity=1
            gcc.anchors.centerIn=gcc.parent
            gcc.anchors.verticalCenterOffset=full.height/2
            gcc.anchors.horizontalCenterOffset=0
            gcc.visible=false
            gcc.opacity=0
            full_te.opacity=0
            ro.thise=true
            ro.opacity=1
            ro.scale=2.5
            gcc.scale=0
            gcc.text=name
            full_timer.i=0
            full_timer.running=true
        }
    }
    Rectangle{
        anchors.fill: parent
        border.color: "#80808080"
        border.width: 2
    }
    Item{
        x:2
        y:2
        Rectangle{
            width: window.width-4
            height: 30
            color:"#BBBBBB"
            Image{
                source:"qrc:/545rand.png"
                width: 30
                height: 30
            }
            Text{
                x:32
                y:2
                text:window.title
                font.pixelSize: 20
            }
            FontLoader {
                    id: font5
                    source: "qrc:/545.otf"  // 相对路径
                }
            DelButton{
                x:window.width-126
                y:0
                width: 30
                height: 30
                text:"C"
                colorBg: "#00000000"
                colorBorder: "#00000000"
                font.pixelSize: 25
                padding: 0
                topPadding: 8
                font.family: font5.name
                onClicked: {
                    mesenge.show("打开设置配置文件",2000)
                    file.openFile("./setting.json")
                }
            }
            DelButton{
                id:top_btn
                x:window.width-96
                y:0
                width: 30
                height: 30
                checkable: true
                checked: false
                text:checked?"A":"B"
                colorBg: "#00000000"
                colorBorder: "#00000000"
                font.pixelSize: 25
                padding: 0
                topPadding: 8
                font.family: font5.name
                onCheckedChanged: if(!start)mesenge.show(checked?"始终显示在最上层":"始终显示在最上层：关闭",2000)

            }
            DelButton{
                x:window.width-66
                y:-3
                width: 30
                height: 30
                text: "-"
                font.pixelSize: 30
                colorBg: "#00000000"
                colorBorder: "#00000000"
                padding: 0
                topPadding: 8
                onClicked: {
                    window.visibility=Window.Minimized
                }
            }
            DelButton{
                x:window.width-36
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
                    Qt.quit()
                }
            }
            Item{
                width: window.width-126
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
                            window.x += mouseX - dragX
                            window.y += mouseY - dragY
                        }
                    }
                }
            }


        }

        Rectangle{
            x:10
            y:40
            width: 330
            height: 280
            color: "#E8E8E8"
            ScrollView {
                id:output__
                anchors.fill: parent
                TextEdit {
                    x:(output__.parent.width-width)/2
                    width: contentWidth
                    id:output
                    text: ""
                    horizontalAlignment: Text.Center
                    font.pixelSize: 30
                    color: "black"
                }
                ScrollBar.vertical: ScrollBar {
                    id:output_
                    height: parent.height
                    policy: output__.contentHeight>output__.height?ScrollBar.AlwaysOn:ScrollBar.AlwaysOff
                    x:parent.width-output_.width
                    Behavior on position {NumberAnimation { easing.type: Easing.OutBack; duration: 300 } }
                }
            }
        }
        Rectangle{//抽一个
            id:txS
            x:10
            y:40
            width: 330
            height: 280
            color: "#DDE8E8E8"
            visible: false
            opacity: 0
            property bool enabled:true
            MouseArea{
                anchors.fill: parent
                onClicked: txS_ti.n=41
            }

            NumberAnimation on opacity {
                running: txS.visible
                duration: 300
                easing.type: Easing.OutQuad
                to: 1.0
                onStopped:txS_ti.running=true
            }
            NumberAnimation on opacity {
                running: !txS.enabled
                duration: 300
                easing.type: Easing.OutQuad
                to: 0.0
                onStopped:
                {
                    txS.enabled=true
                    txS.visible=false
                    txS_te.text=""
                }
            }
            function start(){
                visible=true
            }
            Text{
                id:txS_te
                anchors.centerIn: parent
                font.pixelSize: 40
            }
            Timer{
                id:txS_ti
                interval: 100
                repeat: true
                property int n:0
                onTriggered: {
                    n++
                    if(interval>50)
                        interval--
                    if(n<=40)
                        txS_te.text=cou()
                    else if(n==41)
                    {
                        interval=150
                        txS_te.text=name
                    }
                    else
                    {
                        n=0
                        c1.finish(name)
                        interval=100
                        running=false
                        txS.enabled=false
                    }
                }
            }
        }

        Rectangle{//抽N个
            id:txN
            x:10
            y:40
            width: 330
            height: 280
            color: "#DDE8E8E8"
            visible: false
            opacity: 0
            property bool enabled:true
            property var thisTe
            property var texts:[]
            property int n:0
            Component{
                id:textM
                Text{
                    transformOrigin: Item.TopLeft
                    property bool thise:false
                    font.pixelSize: 40
                    Behavior on x {enabled:thise;  NumberAnimation { easing.type: Easing.OutBack; duration: 300 } }
                    Behavior on y {enabled:thise; NumberAnimation { easing.type: Easing.OutBack; duration: 300 } }
                    Behavior on scale {enabled:thise; NumberAnimation { easing.type: Easing.OutBack; duration: 300 } }
                }
            }

            Component.onCompleted: {
                for(var i=0;i<10;i++)
                {
                    texts[i]=textM.createObject()
                    texts[i].parent=txN
                    texts[i].y=(txN.height-texts[i].height)/2
                }
            }

            MouseArea{
                anchors.fill: parent
                onClicked: txN_ti.n=41
            }
            NumberAnimation on opacity {
                running: txN.visible
                duration: 300
                easing.type: Easing.OutQuad
                to: 1.0
                onStopped:
                {
                    txN.thisTe=txN.texts[0]
                    txN.thisTe.visible=true
                    txN_ti.running=true
                }
            }
            NumberAnimation on opacity {
                running: !txN.enabled
                duration: 300
                easing.type: Easing.OutQuad
                to: 0.0
                onStopped:
                {
                    txN.enabled=true
                    txN.visible=false
                    for(var i=0;i<10;i++)
                    {
                        txN.texts[i].thise=false
                        txN.texts[i].scale=1
                        txN.texts[i].y=(txN.height-txN.texts[i].height)/2
                        txN.texts[i].visible=false
                        txN.texts[i].text=""
                    }
                }
            }
            function start(){
                visible=true
            }
            Timer{
                id:txN_ti
                interval: 100
                repeat: true
                property int n:0
                onTriggered: {
                    n++
                    if(interval>50)
                        interval--
                    if(n<=40)
                    {
                        txN.thisTe.text=cou()
                        txN.thisTe.x=(txN.width-txN.thisTe.width)/2
                    }
                    else if(n==41)
                    {
                        interval=150
                        txN.thisTe.text=nN_names[txN.n]
                    }
                    else if(n>=42)
                    {
                        txN.n++
                        if(txN.n==nN.value+1)
                        {
                            n=0
                            txN.n=0
                            cn.finish()
                            interval=100
                            running=false
                            txN.enabled=false
                            console.log(txN.n)
                        }
                        else if(txN.n==nN.value)
                        {
                            txN.thisTe.text=nN_names[txN.n-1]
                            txN.thisTe.thise=true
                            txN.thisTe.x=txN.n>5?(((txN.n-5)%6-1)*60+15):((txN.n%6-1)*60+15)
                            txN.thisTe.y=txN.n>5?45:15
                            txN.thisTe.scale=0.4
                            interval=600
                        }
                        else if(txN.n<nN.value)
                        {
                            txN.thisTe.text=nN_names[txN.n-1]
                            interval=100
                            txN.thisTe.thise=true
                            txN.thisTe.x=txN.n>5?(((txN.n-5)%6-1)*60+15):((txN.n%6-1)*60+15)
                            txN.thisTe.y=txN.n>5?45:15
                            txN.thisTe.scale=0.4
                            txN.thisTe=txN.texts[txN.n]
                            txN.thisTe.visible=true
                            console.log(txN.n)
                            n=0
                        }
                    }
                }
            }
        }

        Item{
            x:350
            y:48
            width: 280
            height: 80
            DelButton{
                function finish(){
                    output.text+=(sumn==1?"":"\n")+"["+sumn+"]"+name
                    if(output__.contentHeight>output__.height)output_.position=(output__.contentHeight-output__.height)/output__.contentHeight
                    enabled=true
                    cn.enabled=cn.enabled=a3.checked?false:true
                }
                id:c1
                x:0
                y:0
                width: 100
                height: 30
                text: "抽一次"
                font.pixelSize: 20
                onClicked: {
                    sumn++
                    name=cou()
                    enabled=false
                    cn.enabled=false
                    if(a3.checked)
                        full.startS(name)
                    else if(a1.checked)
                    {
                        txS.start()
                    }
                    else
                        finish()
                }
            }
            DelButton{
                id:cn
                x:120
                y:0
                width: 100
                height: 30
                text: {
                    var n=['一','二','三','四','五','六','七','八','九','十']
                    return n[nN.value-1]+"连抽"
                }
                font.pixelSize: 20
                function finish(){
                    for(var i=0;i<nN.value;i++)
                    {
                        sumn++
                        output.text+=(sumn==1?"":"\n")+"["+sumn+"]"+nN_names[i]
                    }
                    if(output__.contentHeight>output__.height)output_.position=(output__.contentHeight-output__.height)/output__.contentHeight
                    enabled=a3.checked?false:true
                    c1.enabled=true
                    nN.enabled=true
                }
                onClicked: {
                    if(nN.value>0)
                    {
                        var i=0
                        for(i=0;i<names.length;i++)
                            names_.pop()
                        for(i=0;i<names.length;i++)
                            names_.push(names[i])
                        if(nN.value<=names_.length)
                        {
                            enabled=false
                            c1.enabled=false
                            nN.enabled=false
                            for(i=0;i<nN.value;i++)
                            {
                                nN_names[i]=coul()
                            }
                            if(a1.checked)
                            {
                                txN.start()
                            }
                            else
                                finish()
                        }
                        else
                            mesenge.show("N不能大于班级总人数",3000)
                    }
                }
            }
            CScrollBar{
                y:45
                text:"N="
                id:nN
                minValue: 1
                maxValue: 10
                Component.onCompleted: setValue(5)
                width: 120
                step: 1
            }
            DelButton{
                x:0
                y:80
                width: 100
                height:30
                text: "清除"
                font.pixelSize: 20
                onClicked: {
                    output.text=""
                    sumn=0
                }
            }
            DelButton{
                x:120
                y:80
                width: 100
                height:30
                text: "导出"
                font.pixelSize: 20
                onClicked: file.output()
            }
            Rectangle{
                x:0
                y:130
                width: parent.width-60
                height: 130
                border.color: "#80808080"
                radius: 3
                DelButton{
                    id:a1
                    width: parent.width-20
                    height: 25
                    x:10
                    y:35
                    checkable: true
                    type: checked ? 3 : 1
                    text: "开启特效"
                    checked: true
                    onCheckedChanged: {
                        if(checked)
                        {
                            a2.checked=false
                            a3.checked=false
                            cn.enabled=true
                        }
                    }
                    onClicked: checked=true
                }
                DelButton{
                    id:a2
                    width: parent.width-20
                    height: 25
                    x:10
                    y:65
                    checkable: true
                    text: "关闭特效"
                    type: checked ? 3 : 1
                    onCheckedChanged: {
                        if(checked)
                        {
                            a1.checked=false
                            a3.checked=false
                            cn.enabled=true
                        }
                    }
                    onClicked: checked=true
                }
                DelButton{
                    id:a3
                    width: parent.width-20
                    height: 25
                    x:10
                    y:95
                    checkable: true
                    type: checked ? 3 : 1
                    text: "超级特效"
                    property bool first:true
                    onCheckedChanged: {
                        a1.checked=false
                        a2.checked=false
                        cn.enabled=false
                    }
                    onClicked: {
                        if(first){
                            first=false
                            error.visible=true
                            error.raise()
                        }
                    }
                    Window{
                        id:error
                        flags:Qt.FramelessWindowHint|Qt.Window
                        color: "#00000000"
                        x:error.screen.width/2-width/2
                        y:error.screen.height/2-height/2
                        width: 320
                        height: 150
                        minimumHeight: height
                        maximumHeight: height
                        minimumWidth: width
                        maximumWidth: width
                        title: "545抽号器>提示"
                        Rectangle{
                            anchors.fill: parent
                            border.color: "#80808080"
                            border.width: 2
                        }
                        Item{
                            x:2
                            y:2
                            Rectangle{
                                width: error.width-4
                                height: 30
                                color:"#BBBBBB"
                                Image{
                                    source:"qrc:/545rand.png"
                                    width: 30
                                    height: 30
                                }
                                Text{
                                    x:32
                                    y:2
                                    text:error.title
                                    font.pixelSize: 20
                                }
                                DelButton{
                                    x:error.width-36
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
                                        error.visible=false
                                    }
                                }
                                Item{
                                    width: error.width-36
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
                                                error.x += mouseX - dragX
                                                error.y += mouseY - dragY
                                            }
                                        }
                                    }
                                }
                                Item{
                                    y:20
                                    Text{
                                        x:20
                                        y:25
                                        font.pixelSize: 20
                                        text:"超级特效暂不支持多连抽\n相关内容制作（等待假期）中..."
                                    }

                                    Item{
                                        y:80
                                        DelButton{
                                            text:"催更"
                                            font.pixelSize: 16
                                            type:3
                                            width: 100
                                            x:30
                                            height: 25
                                            onClicked: Qt.openUrlExternally("https://space.bilibili.com/1150293211")
                                        }
                                        DelButton{
                                            text:"关闭"
                                            enabled: false
                                            font.pixelSize: 16
                                            width: 100
                                            x:180
                                            height: 25
                                            onClicked: error.visible=false
                                        }
                                    }
                                }
                            }
                        }
                    }

                }
                DelButton{
                    text:"关于"
                    font.pixelSize: 16
                    width: 60
                    x:parent.width-width-10
                    y:8
                    height: 20
                    onClicked:
                    {
                        about.visible=true
                        about.raise()
                    }
                    About{
                        id:about
                    }
                }
            }
        }
    }
}

