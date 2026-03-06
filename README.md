# Card Organizer App
A lightweight Card Organizer Flutter app that groups study or reference cards into folders, supports card images, and persists data locally. The repository’s lib folder contains the app entry point and the core layers: database helper, data models, repository layer for folders and cards, and UI screens (folders list, card list/detail, add/edit flows).

## Key features

- Folder CRUD — create, read, update, delete folders.
- Card CRUD — create, read, update, delete cards within folders.
- Image support — cards can include images (assets or remote URIs).
- Local persistence — SQLite database with repository abstraction.
- Simple navigation — folder list → card list → card detail → add/edit.

## Architecture and design
- Layered structure — UI screens call into repository classes that encapsulate SQL operations; a database helper initializes the SQLite database and handles migrations.

- Data model — two primary entities: Folder and Card; cards reference folders via a foreign key and are removed when their parent folder is deleted (cascade behavior is implemented at the DB layer).

- Separation of concerns — UI widgets remain thin and delegate persistence to repository classes so logic is testable and easier to maintain. The lib folder contains these layers.

## File structure (lib) — high level

- main.dart — app entry point and route setup.
- Database helper — initializes DB, enables foreign keys, and runs migrations.
- Models — Folder and Card data classes.
- Repositories — folder and card repositories that expose CRUD methods.
- Screens / Widgets — folder list screen, card list screen, card detail screen, add/edit forms, and any grid/list UI components.