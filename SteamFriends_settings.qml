import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import qs.Common
import qs.Widgets
import qs.Modules.Plugins
import qs.Services

PluginSettings {
    id: root
    pluginId: "steamfriends"

    Column {
        id: mainSettingsCol
        width: parent.width
        spacing: Theme.spacingL

        function loadValue(key, def) {
            return PluginService.loadPluginData(root.pluginId, key, def);
        }

        function saveValue(key, val) {
            PluginService.savePluginData(root.pluginId, key, val);
            PluginService.setGlobalVar(root.pluginId, key, val);
        }

        function loadValueInternal() {
            apiKeyField.loadValue();
            steamIdField.loadValue();
            showFriendsToggle.loadValue();
            onlyShowOnlineToggle.loadValue();
            groupOnlineOfflineToggle.loadValue();
            timeFormatSelector.loadValue();
            showLastOnlineToggle.loadValue();
        }

        Component.onCompleted: loadValueInternal()

        // --- Credentials Group ---
        Column {
            width: parent.width
            spacing: Theme.spacingM

            StyledText {
                text: "Credentials"
                font.pixelSize: Theme.fontSizeSmall
                font.weight: Font.DemiBold
                color: Theme.primary
                padding: 0
                leftPadding: Theme.spacingM
            }

            Column {
                width: parent.width
                spacing: 2

                // 1. API Key Field (First)
                Rectangle {
                    width: parent.width
                    height: apiKeyCol.implicitHeight + Theme.spacingM * 2
                    readonly property bool isFirst: true
                    readonly property bool isLast: false
                    readonly property real outerR: Theme.cornerRadius
                    readonly property real innerR: 4

                    topLeftRadius: isFirst ? outerR : innerR
                    topRightRadius: isFirst ? outerR : innerR
                    bottomLeftRadius: isLast ? outerR : innerR
                    bottomRightRadius: isLast ? outerR : innerR

                    color: Theme.withAlpha(Theme.surfaceContainerHigh, 0.5)
                    border.width: 1
                    border.color: Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.10)

                    ColumnLayout {
                        id: apiKeyCol
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: Theme.spacingM
                        anchors.rightMargin: Theme.spacingM
                        spacing: Theme.spacingS

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: Theme.spacingM

                            DankIcon {
                                name: "vpn_key"
                                size: 20
                                color: Theme.primary
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 2

                                StyledText {
                                    text: "Steam Web API Key"
                                    font.pixelSize: Theme.fontSizeMedium
                                    font.weight: Font.Medium
                                    color: Theme.surfaceText
                                }

                                StyledText {
                                    Layout.fillWidth: true
                                    text: "Required to fetch friends list and status from Steam API."
                                    font.pixelSize: Theme.fontSizeSmall
                                    color: Theme.surfaceVariantText
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        DankTextField {
                            id: apiKeyField
                            Layout.fillWidth: true
                            placeholderText: "Enter 32-character Steam Web API Key"

                            function loadValue() {
                                text = mainSettingsCol.loadValue("apikey", "");
                            }
                            onEditingFinished: {
                                mainSettingsCol.saveValue("apikey", text);
                            }
                        }
                    }
                }

                // 2. Steam ID Field (Last)
                Rectangle {
                    width: parent.width
                    height: steamIdCol.implicitHeight + Theme.spacingM * 2
                    readonly property bool isFirst: false
                    readonly property bool isLast: true
                    readonly property real outerR: Theme.cornerRadius
                    readonly property real innerR: 4

                    topLeftRadius: isFirst ? outerR : innerR
                    topRightRadius: isFirst ? outerR : innerR
                    bottomLeftRadius: isLast ? outerR : innerR
                    bottomRightRadius: isLast ? outerR : innerR

                    color: Theme.withAlpha(Theme.surfaceContainerHigh, 0.5)
                    border.width: 1
                    border.color: Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.10)

                    ColumnLayout {
                        id: steamIdCol
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: Theme.spacingM
                        anchors.rightMargin: Theme.spacingM
                        spacing: Theme.spacingS

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: Theme.spacingM

                            DankIcon {
                                name: "account_circle"
                                size: 20
                                color: Theme.primary
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 2

                                StyledText {
                                    text: "Steam 64-bit ID"
                                    font.pixelSize: Theme.fontSizeMedium
                                    font.weight: Font.Medium
                                    color: Theme.surfaceText
                                }

                                StyledText {
                                    Layout.fillWidth: true
                                    text: "Your unique 64-bit Steam ID (e.g. 76561198000000000)."
                                    font.pixelSize: Theme.fontSizeSmall
                                    color: Theme.surfaceVariantText
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        DankTextField {
                            id: steamIdField
                            Layout.fillWidth: true
                            placeholderText: "Enter 64-bit Steam ID"

                            function loadValue() {
                                text = mainSettingsCol.loadValue("steamid", "");
                            }
                            onEditingFinished: {
                                mainSettingsCol.saveValue("steamid", text);
                            }
                        }
                    }
                }
            }
        }

        // --- Display Settings Group ---
        Column {
            width: parent.width
            spacing: Theme.spacingM

            StyledText {
                text: "Display Settings"
                font.pixelSize: Theme.fontSizeSmall
                font.weight: Font.DemiBold
                color: Theme.primary
                padding: 0
                leftPadding: Theme.spacingM
            }

            Column {
                width: parent.width
                spacing: 2

                // 3. Show "Friends Online" Text (First)
                Rectangle {
                    width: parent.width
                    height: row3.implicitHeight + Theme.spacingM * 2
                    readonly property bool isFirst: true
                    readonly property bool isLast: false
                    readonly property real outerR: Theme.cornerRadius
                    readonly property real innerR: 4

                    topLeftRadius: isFirst ? outerR : innerR
                    topRightRadius: isFirst ? outerR : innerR
                    bottomLeftRadius: isLast ? outerR : innerR
                    bottomRightRadius: isLast ? outerR : innerR

                    color: Theme.withAlpha(Theme.surfaceContainerHigh, 0.5)
                    border.width: 1
                    border.color: Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.10)

                    RowLayout {
                        id: row3
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: Theme.spacingM
                        anchors.rightMargin: Theme.spacingM
                        spacing: Theme.spacingM

                        DankIcon {
                            name: "visibility"
                            size: 20
                            color: Theme.primary
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            StyledText {
                                text: "Show \"Friends Online\" Text"
                                font.pixelSize: Theme.fontSizeMedium
                                font.weight: Font.Medium
                                color: Theme.surfaceText
                            }

                            StyledText {
                                Layout.fillWidth: true
                                text: "Display \"X Friends Online\" label instead of only the number."
                                font.pixelSize: Theme.fontSizeSmall
                                color: Theme.surfaceVariantText
                                wrapMode: Text.WordWrap
                            }
                        }

                        DankToggle {
                            id: showFriendsToggle
                            hideText: true
                            checked: true

                            function loadValue() {
                                checked = mainSettingsCol.loadValue("showFriendsOnlineText", true);
                            }

                            onClicked: {
                                checked = !checked;
                                mainSettingsCol.saveValue("showFriendsOnlineText", checked);
                            }
                        }
                    }
                }

                // 4. Only Show Online Friends (Middle)
                Rectangle {
                    width: parent.width
                    height: row4.implicitHeight + Theme.spacingM * 2
                    readonly property bool isFirst: false
                    readonly property bool isLast: false
                    readonly property real outerR: Theme.cornerRadius
                    readonly property real innerR: 4

                    topLeftRadius: isFirst ? outerR : innerR
                    topRightRadius: isFirst ? outerR : innerR
                    bottomLeftRadius: isLast ? outerR : innerR
                    bottomRightRadius: isLast ? outerR : innerR

                    color: Theme.withAlpha(Theme.surfaceContainerHigh, 0.5)
                    border.width: 1
                    border.color: Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.10)

                    RowLayout {
                        id: row4
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: Theme.spacingM
                        anchors.rightMargin: Theme.spacingM
                        spacing: Theme.spacingM

                        DankIcon {
                            name: "person_search"
                            size: 20
                            color: Theme.primary
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            StyledText {
                                text: "Only Show Online Friends"
                                font.pixelSize: Theme.fontSizeMedium
                                font.weight: Font.Medium
                                color: Theme.surfaceText
                            }

                            StyledText {
                                Layout.fillWidth: true
                                text: "Hide offline friends from the friends list popout."
                                font.pixelSize: Theme.fontSizeSmall
                                color: Theme.surfaceVariantText
                                wrapMode: Text.WordWrap
                            }
                        }

                        DankToggle {
                            id: onlyShowOnlineToggle
                            hideText: true
                            checked: false

                            function loadValue() {
                                checked = mainSettingsCol.loadValue("onlyShowOnline", false);
                            }

                            onClicked: {
                                checked = !checked;
                                mainSettingsCol.saveValue("onlyShowOnline", checked);
                            }
                        }
                    }
                }

                // 5. Group Online & Offline Friends (Middle)
                Rectangle {
                    width: parent.width
                    height: row5.implicitHeight + Theme.spacingM * 2
                    readonly property bool isFirst: false
                    readonly property bool isLast: false
                    readonly property real outerR: Theme.cornerRadius
                    readonly property real innerR: 4

                    topLeftRadius: isFirst ? outerR : innerR
                    topRightRadius: isFirst ? outerR : innerR
                    bottomLeftRadius: isLast ? outerR : innerR
                    bottomRightRadius: isLast ? outerR : innerR

                    color: Theme.withAlpha(Theme.surfaceContainerHigh, 0.5)
                    border.width: 1
                    border.color: Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.10)

                    RowLayout {
                        id: row5
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: Theme.spacingM
                        anchors.rightMargin: Theme.spacingM
                        spacing: Theme.spacingM

                        DankIcon {
                            name: "table_rows"
                            size: 20
                            color: Theme.primary
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            StyledText {
                                text: "Group Online & Offline Friends"
                                font.pixelSize: Theme.fontSizeMedium
                                font.weight: Font.Medium
                                color: Theme.surfaceText
                            }

                            StyledText {
                                Layout.fillWidth: true
                                text: "Separate online and offline friends into distinct list sections."
                                font.pixelSize: Theme.fontSizeSmall
                                color: Theme.surfaceVariantText
                                wrapMode: Text.WordWrap
                            }
                        }

                        DankToggle {
                            id: groupOnlineOfflineToggle
                            hideText: true
                            checked: false

                            function loadValue() {
                                checked = mainSettingsCol.loadValue("groupOnlineOffline", false);
                            }

                            onClicked: {
                                checked = !checked;
                                mainSettingsCol.saveValue("groupOnlineOffline", checked);
                            }
                        }
                    }
                }

                // 6. Show Last Online Time (Middle)
                Rectangle {
                    width: parent.width
                    height: row6.implicitHeight + Theme.spacingM * 2
                    readonly property bool isFirst: false
                    readonly property bool isLast: false
                    readonly property real outerR: Theme.cornerRadius
                    readonly property real innerR: 4

                    topLeftRadius: isFirst ? outerR : innerR
                    topRightRadius: isFirst ? outerR : innerR
                    bottomLeftRadius: isLast ? outerR : innerR
                    bottomRightRadius: isLast ? outerR : innerR

                    color: Theme.withAlpha(Theme.surfaceContainerHigh, 0.5)
                    border.width: 1
                    border.color: Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.10)

                    RowLayout {
                        id: row6
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: Theme.spacingM
                        anchors.rightMargin: Theme.spacingM
                        spacing: Theme.spacingM

                        DankIcon {
                            name: "history"
                            size: 20
                            color: Theme.primary
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            StyledText {
                                text: "Show Last Online Time"
                                font.pixelSize: Theme.fontSizeMedium
                                font.weight: Font.Medium
                                color: Theme.surfaceText
                            }

                            StyledText {
                                Layout.fillWidth: true
                                text: "Display relative last online timestamp for offline friends."
                                font.pixelSize: Theme.fontSizeSmall
                                color: Theme.surfaceVariantText
                                wrapMode: Text.WordWrap
                            }
                        }

                        DankToggle {
                            id: showLastOnlineToggle
                            hideText: true
                            checked: true

                            function loadValue() {
                                checked = mainSettingsCol.loadValue("showLastOnline", true);
                            }

                            onClicked: {
                                checked = !checked;
                                mainSettingsCol.saveValue("showLastOnline", checked);
                            }
                        }
                    }
                }

                // 7. Time Format Selector (Last - Stacked Layout)
                Rectangle {
                    width: parent.width
                    height: timeFormatCol.implicitHeight + Theme.spacingM * 2
                    readonly property bool isFirst: false
                    readonly property bool isLast: true
                    readonly property real outerR: Theme.cornerRadius
                    readonly property real innerR: 4

                    topLeftRadius: isFirst ? outerR : innerR
                    topRightRadius: isFirst ? outerR : innerR
                    bottomLeftRadius: isLast ? outerR : innerR
                    bottomRightRadius: isLast ? outerR : innerR

                    color: Theme.withAlpha(Theme.surfaceContainerHigh, 0.5)
                    border.width: 1
                    border.color: Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.10)

                    ColumnLayout {
                        id: timeFormatCol
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: Theme.spacingM
                        anchors.rightMargin: Theme.spacingM
                        spacing: Theme.spacingS

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: Theme.spacingM

                            DankIcon {
                                name: "schedule"
                                size: 20
                                color: Theme.primary
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 2

                                StyledText {
                                    text: "Time Format"
                                    font.pixelSize: Theme.fontSizeMedium
                                    font.weight: Font.Medium
                                    color: Theme.surfaceText
                                }

                                StyledText {
                                    Layout.fillWidth: true
                                    text: "Choose time format for timestamps and last online indicators."
                                    font.pixelSize: Theme.fontSizeSmall
                                    color: Theme.surfaceVariantText
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        Item {
                            id: timeFormatSelector
                            Layout.fillWidth: true
                            implicitHeight: 40
                            property string currentFormat: "system"

                            function loadValue() {
                                currentFormat = mainSettingsCol.loadValue("timeFormat", "system");
                            }

                            RowLayout {
                                anchors.fill: parent
                                spacing: 2

                                Repeater {
                                    model: [
                                        { title: "System Default", key: "system", icon: "settings_suggest" },
                                        { title: "12-Hour", key: "12h", icon: "schedule" },
                                        { title: "24-Hour", key: "24h", icon: "alarm" }
                                    ]

                                    delegate: Item {
                                        id: tfItem
                                        Layout.fillWidth: true
                                        Layout.preferredWidth: 1
                                        height: 40

                                        property bool isSelected: timeFormatSelector.currentFormat === modelData.key
                                        property bool isHovered: tfItemMa.containsMouse

                                        Shape {
                                            id: tfItemBg
                                            anchors.fill: parent

                                            property real innerRadius: 4
                                            property real outerRadius: Theme.cornerRadius || 12
                                            property bool isFirst: index === 0
                                            property bool isLast: index === 2

                                            property real tlr: (isSelected || isHovered) ? (height / 2) : (isFirst ? outerRadius : innerRadius)
                                            property real blr: (isSelected || isHovered) ? (height / 2) : (isFirst ? outerRadius : innerRadius)
                                            property real trr: (isSelected || isHovered) ? (height / 2) : (isLast ? outerRadius : innerRadius)
                                            property real brr: (isSelected || isHovered) ? (height / 2) : (isLast ? outerRadius : innerRadius)

                                            property real tlrAnim: tlr; Behavior on tlrAnim { NumberAnimation { duration: 500; easing.type: Easing.OutExpo } }
                                            property real trrAnim: trr; Behavior on trrAnim { NumberAnimation { duration: 500; easing.type: Easing.OutExpo } }
                                            property real blrAnim: blr; Behavior on blrAnim { NumberAnimation { duration: 500; easing.type: Easing.OutExpo } }
                                            property real brrAnim: brr; Behavior on brrAnim { NumberAnimation { duration: 500; easing.type: Easing.OutExpo } }

                                            property color paintColor: isSelected
                                                    ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.18)
                                                    : (isHovered ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.08) : Qt.rgba(Theme.secondary.r, Theme.secondary.g, Theme.secondary.b, 0.04))

                                            property color paintBorder: isSelected
                                                    ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.5)
                                                    : (isHovered ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.3) : Qt.rgba(Theme.secondary.r, Theme.secondary.g, Theme.secondary.b, 0.12))

                                            ShapePath {
                                                fillColor: tfItemBg.paintColor
                                                strokeColor: tfItemBg.paintBorder
                                                strokeWidth: 1

                                                startX: tfItemBg.tlrAnim; startY: 0
                                                PathLine { x: tfItemBg.width - tfItemBg.trrAnim; y: 0 }
                                                PathArc { x: tfItemBg.width; y: tfItemBg.trrAnim; radiusX: tfItemBg.trrAnim; radiusY: tfItemBg.trrAnim; direction: PathArc.Clockwise }
                                                PathLine { x: tfItemBg.width; y: tfItemBg.height - tfItemBg.brrAnim }
                                                PathArc { x: tfItemBg.width - tfItemBg.brrAnim; y: tfItemBg.height; radiusX: tfItemBg.brrAnim; radiusY: tfItemBg.brrAnim; direction: PathArc.Clockwise }
                                                PathLine { x: tfItemBg.blrAnim; y: tfItemBg.height }
                                                PathArc { x: 0; y: tfItemBg.height - tfItemBg.blrAnim; radiusX: tfItemBg.blrAnim; radiusY: tfItemBg.blrAnim; direction: PathArc.Clockwise }
                                                PathLine { x: 0; y: tfItemBg.tlrAnim }
                                                PathArc { x: tfItemBg.tlrAnim; y: 0; radiusX: tfItemBg.tlrAnim; radiusY: tfItemBg.tlrAnim; direction: PathArc.Clockwise }
                                            }
                                        }

                                        scale: tfItemMa.pressed ? 0.98 : (isHovered ? 1.01 : 1.0)
                                        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }

                                        DankRipple { id: tfRip; anchors.fill: parent; cornerRadius: tfItemBg.tlrAnim; rippleColor: Theme.primary }

                                        RowLayout {
                                            anchors.centerIn: parent
                                            spacing: Theme.spacingXS

                                            DankIcon {
                                                name: modelData.icon
                                                size: 16
                                                color: tfItem.isSelected ? Theme.primary : Theme.surfaceVariantText
                                                Layout.alignment: Qt.AlignVCenter
                                            }

                                            StyledText {
                                                text: modelData.title
                                                font.pixelSize: Theme.fontSizeSmall
                                                font.weight: tfItem.isSelected ? Font.Bold : Font.Normal
                                                color: tfItem.isSelected ? Theme.primary : Theme.surfaceText
                                                Layout.alignment: Qt.AlignVCenter
                                            }
                                        }

                                        MouseArea {
                                            id: tfItemMa
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            cursorShape: Qt.PointingHandCursor
                                            onPressed: (m) => tfRip.trigger(m.x, m.y)
                                            onClicked: {
                                                timeFormatSelector.currentFormat = modelData.key;
                                                mainSettingsCol.saveValue("timeFormat", modelData.key);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
