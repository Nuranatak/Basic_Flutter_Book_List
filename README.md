# Book List App

An interactive Flutter experience for browsing and marking favorite books. The project demonstrates how to build a responsive list UI with card layouts, SnackBar feedback, and simple state management in Flutter.

## Features

- **Dynamic Listing:** Displays eight or more books using `ListView.builder` for efficient, scrollable rendering.
- **Rich Cards:** Each entry shows a cover image, title, author, and a favorite toggle housed in a Material `Card`.
- **SnackBar Feedback:** Tapping a card reveals the book title, while toggling favorites confirms adding or removing the selection.
- **Responsive Layout:** `OrientationBuilder` adapts spacing, typography, and image dimensions for portrait and landscape orientations.

## Screenshots

![Book list portrait view](Screenshot%202025-11-09%20161329.png)

![SnackBar example](Screenshot%202025-11-09%20161344.png)

![Landscape view](Screenshot%202025-11-09%20161359.png)


## Notes

- SnackBars use `ScaffoldMessenger` to dismiss previous messages before showing new ones.
- Favorites are tracked with an in-memory `Set`, making it simple to integrate persistent storage later.
- The project is intended as a learning exercise for Flutter UI patterns and adaptive design.
