# Book List App

The app renders more than eight books as cards with a cover image, title, author name, and favorite button. Tapping a card shows the selected book title in a SnackBar, while the favorite icon toggles the book in or out of favorites with contextual messaging. `OrientationBuilder` adapts cover dimensions, spacing, and typography automatically for both portrait and landscape orientations. The list is generated with `ListView.builder`, and new SnackBars dismiss any previous message before displaying the next one.

![Book list portrait view](Screenshot%202025-11-09%20161329.png)

![SnackBar example](Screenshot%202025-11-09%20161344.png)

![Landscape view](Screenshot%202025-11-09%20161359.png)
