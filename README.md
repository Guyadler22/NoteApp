# NoteApp

This is a note-taking app that allows users to register and log in using Firebase Authentication. Each user can create, edit, and update their own notes, which are stored in Firebase Realtime Database. The app also includes a feature to retrieve the location of each note. Additionally, the Swipe-to-Delete library is integrated for easy note deletion.

## Features

### Authentication
- Users can register and log in using their email and password through Firebase Authentication.
- Firebase Auth Podfile is used for easy integration and management of authentication functionalities.
### Note Management
- Each authenticated user has their own set of notes.
- Users can create, edit, and update their own notes.
- Notes are stored in Firebase Realtime Database using the Firebase Database Podfile.
### Note Location Retrieval
- The app includes a feature to retrieve the location associated with each note.
- Location coordinates are stored along with the note details in Firebase Realtime Database.
- The location can be displayed on a map or converted to an address using reverse geocoding.
### Swipe-to-Delete
- The Swipe-to-Delete library is integrated to allow users to easily delete notes by swiping.
## Architecture

The app follows the Model-View-Controller (MVC) design pattern for better code organization and separation of concerns.

- Models: The data models representing notes and user information.
- Views: The user interface components including screens, forms, and table views.
- Controllers: The logic that handles user interactions, data management, and Firebase integration.
