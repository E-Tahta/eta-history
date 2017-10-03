/*****************************************************************************
 *   Copyright (C) 2016 by Hikmet Bas                                        *
 *   <hikmet.bas@pardus.org.tr>                                              *
 *                                                                           *
 *   This program is free software; you can redistribute it and/or modify    *
 *   it under the terms of the GNU General Public License as published by    *
 *   the Free Software Foundation; either version 2 of the License, or       *
 *   (at your option) any later version.                                     *
 *                                                                           *
 *   This program is distributed in the hope that it will be useful,         *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 *   GNU General Public License for more details.                            *
 *                                                                           *
 *   You should have received a copy of the GNU General Public License       *
 *   along with this program; if not, write to the                           *
 *   Free Software Foundation, Inc.,                                         *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .          *
 *****************************************************************************/

import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import eta.bridge 1.0

ApplicationWindow {
    id: main
    visible: true
    width: 700
    height: 400
    title: "Eta Oturum Kayıtları"
    x: (Screen.width - main.width) / 2
    y: (Screen.height - main.height) / 2

    property string usernames
    property int rad : 5

    function fillUsers(){
        var list
        model.clear()
        main.usernames = bridge.getUsers()
        list = main.usernames.split("\n")
        for (var i = 0; i<list.length-1; i++){
            model.append({"name":list[i]})
        }
    }

    Bridge {
        id: bridge
    }

    ListModel {
        id: model
    }

    Item {
        id: container
        width: main.width -20
        height: main.height -20
        anchors.centerIn: parent

        Rectangle {
            id: r1
            radius: main.rad
            width: parent.width/5
            height: parent.height

            ListView {
                id: list
                width: parent.width
                height: parent.height
                model: model
                delegate: Component {
                    Item {
                        width: parent.width
                        height: 40
                        Item {
                            height: parent.height
                            width: parent.width
                            Text {
                                anchors.centerIn: parent
                                text: name
                                font.pointSize: 10
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                list.currentIndex = index
                                list.focus = true
                            }
                        }
                    }
                }
                highlight: Rectangle {
                    color: 'orange'
                    radius: main.rad
                }
                focus: true
                onCurrentItemChanged: {
                    txt.text =
                            bridge.getHistory("last -w :0 | grep "
                                          + model.get(list.currentIndex).name +
                                          " | awk '{print \" \"$1 \" \t \""+
                                          "\" \" $4 \" \" $5 \" \t \" $6 \""+
                                          "\" $7 \" \" $8 \" \" $9}'")
                }
            }
        }

        Rectangle {
            id: r2
            radius: main.rad
            width: parent.width * 4 / 5
            height: parent.height
            anchors.left: r1.right
            TextArea {
                width: parent.width - 10
                height: parent.height - 10
                anchors.centerIn: parent
                readOnly: true
                id: txt
            }
        }
    }

    Component.onCompleted: {
        fillUsers()
    }
}

