# github-viewer
simple github viewer

Uses/Has:
• UIKit
• UICollectionView
• SwiftUI
• URL on disk caching for search results and avatars
• preliminary localization support

TODO:
• two lines for description in master view
• persist favourites
• either remove the scope segments from favourites tab or implement scope filtering in there
• remove extra divider llines in detail view
• fix master view selection
• show some text when there is no content
• show some UI when no internet is available and handle errors better
• lay the list under the tab bar so it shows through
• fix avatar flash that happens when you click on a favourite button
• always show the scope segments (now they are hidden sometimes)
• fix navigation bar issue in detailView
• fix tabBar layout
• fix scroll position on refresh (the list shall be visually static with extra items load on top)
• draw placeholders on borken avatar links
• show network activity indicator
• do a proper search via the query string (now local filtering is used) - (but check how slow/fast git api will do that)
• when going from days to months and to years days results shall also be in month's and month results - in year's. at the moment it looks odd
• show number of stars in master view
• localize to french, spanish, german
• get rid of storyboard
• make app icon
• make launch screen
• make mac catalyst version
• move diffable data source applying to a background queue
• get rid of UIKit/collection view and reimplement in SwiftUI
• simplify project folder structure
• fix readme formatting
