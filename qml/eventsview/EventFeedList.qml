/****************************************************************************
**
** Copyright (C) 2013-2014 Jolla Ltd.
**
****************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Ambience 1.0
import Sailfish.Accounts 1.0
import com.jolla.lipstick 0.1
import org.nemomobile.lipstick 0.1
import org.nemomobile.socialcache 1.0

Column {
    id: column

    property bool collapsed
    property bool hasVisibleFeeds: height > 0
    property bool hasRemovableNotifications
    property bool showingRemovableContent   // will be true if there are no notifications, but removal animations are still running
    property int animationDuration

    signal expanded(Item item, real itemYOffset)

    function findMatchingRemovableItems(filterFunc, matchingResults) {
        for (var i=0; i<eventFeedList.count; i++) {
            var loader = eventFeedList.itemAt(i)
            if (loader.status == Loader.Ready) {
                loader.item.findMatchingRemovableItems(filterFunc, matchingResults)
            }
        }
    }

    function removeAllNotifications() {
        for (var i=0; i<eventFeedList.count; i++) {
            var loader = eventFeedList.itemAt(i)
            if (loader.status == Loader.Ready) {
                loader.item.removeAllNotifications()
            }
        }
    }

    function _reloadHasRemovableNotifications() {
        for (var i=0; i<eventFeedList.count; i++) {
            if (!eventFeedList.itemAt(i) || eventFeedList.itemAt(i).status != Loader.Ready) {
                continue
            }
            var loadedItem = eventFeedList.itemAt(i).item
            if (loadedItem.hasRemovableItems) {
                hasRemovableNotifications = true
                return
            }
        }
        hasRemovableNotifications = false
    }

    function _reloadShowingRemovableContent() {
        for (var i=0; i<eventFeedList.count; i++) {
            if (!eventFeedList.itemAt(i) || eventFeedList.itemAt(i).status != Loader.Ready) {
                continue
            }
            var loadedItem = eventFeedList.itemAt(i).item
            if (loadedItem.userRemovable && loadedItem.mainContentHeight > 0) {
                showingRemovableContent = true
                return
            }
        }
        showingRemovableContent = false
    }

    opacity: collapsed ? 0 : 1

    Behavior on opacity {
        FadeAnimation {
            duration: column.animationDuration
        }
    }

    EventFeedSocialSubviewModel {
        id: eventFeedListModel
        manager: accountManager
    }

    EventFeedAccountManager {
        id: accountManager
    }

    SocialImageCache {
        id: downloader
    }

    Repeater {
        id: eventFeedList
        model: eventFeedListModel.model

        Loader {
            id: loader
            width: column.width
            asynchronous: true

            Component.onCompleted: {
                var props = {
                    "downloader": downloader,
                    "providerName": providerName,
                    "subviewModel": eventFeedListModel,
                    "animationDuration": Qt.binding(function() { return column.animationDuration }),
                    "collapsed": Qt.binding(function() { return column.collapsed }),
                    "showingInActiveView": Qt.binding(function() { return Desktop.eventsViewVisible }),
                    "eventsColumnMaxWidth": Math.min(Screen.width, Screen.height)
                }
                setSource(Qt.resolvedUrl("file:///usr/share/lipstick/eventfeed/" + providerName + "-delegate.qml"), props)
            }

            onLoaded: {
                column._reloadHasRemovableNotifications()
            }

            Connections {
                target: loader.item
                onExpanded: {
                    column.expanded(loader.item, itemPosY)
                }
                onHasRemovableItemsChanged: {
                    column._reloadHasRemovableNotifications()
                }
                onMainContentHeightChanged: {
                    if (loader.item.userRemovable) {
                        if (!column.showingRemovableContent && loader.item.mainContentHeight > 0) {
                            column.showingRemovableContent = true
                        } else if (column.showingRemovableContent && loader.item.mainContentHeight == 0) {
                            column._reloadShowingRemovableContent()
                        }
                    }
                }
            }
        }
    }
}
