# github-viewer
simple github viewer

## Author:
Mike Kluev

## What it does:
Lists trending github repositories sorted by star count for day/month and year periods. Just that.

## What it does not:
Anything else

## iPhone:
![iphoneScreenshot](https://github.com/mikekl/github-viewer/blob/master/screenshots/iphone.png)

## mac:
![macScreenshot](https://github.com/mikekl/github-viewer/blob/master/screenshots/mac.png)

## Uses/Has:
* UIKit
* UICollectionView
* diffable data sources
* pull to refresh and infinite scrolling
* SwiftUI piecewise
* URL on disk caching for search results and avatars
* preliminary localization support
* network activity indicator
* iphone / ipad / mac catalyst support
* simple local persistence
* partial work offline functionality

## TODO:
* fix caching, now it is too aggressive and doesn't revalidate resources
* fix month/year calculation logic
* two lines for description in master view
* either remove the scope segments from favourites tab or implement scope filtering in there
* remove extra divider lines in detail view
* fix master view selection
* show some text when there is no content
* lay the list under the tab bar so it shows through
* fix avatar flash that happens when you click on a favourite button
* always show the scope segments (now they are hidden sometimes)
* fix navigation bar issue in detailView
* fix tabBar layout
* fix scroll position on refresh (the list shall be visually static with extra items load on top)
* draw placeholders on borken avatar links
* do a proper search via the query string (now local filtering is used) - (but check how slow/fast git api will do that)
* get rid of storyboard
* make app icon
* move diffable data source applying to a background queue
* get rid of UIKit/collection view and reimplement in SwiftUI
