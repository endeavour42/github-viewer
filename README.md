# github-viewer
simple github viewer

## Uses/Has:
* UIKit
* UICollectionView
* pull to refresh and infinite scrolling
* SwiftUI piecewise
* URL on disk caching for search results and avatars
* preliminary localization support

## TODO:
* fix caching, now it is too aggressive and doesn't revalidate resources
* two lines for description in master view
* persist favourites in local storage
* either remove the scope segments from favourites tab or implement scope filtering in there
* remove extra divider llines in detail view
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
* simplify project folder structure
* fix readme formatting
