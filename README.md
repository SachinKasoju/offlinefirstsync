# offline_sync_first
This project demonstrates an offline-first Flutter application that uses a local database (Hive) and a sync queue mechanism to synchronize with Firebase Firestore when network connectivity is available. 

## Flutter Version
Flutter 3.24.4

## Architecture
Riverpod + Repository Pattern

## Application Flow
UI Layer
   ↓
Riverpod State Management
   ↓
Repository Layer
   ↓
Local Database (Hive)
   ↓
Sync Queue
   ↓
Firebase Firestore

## Features
- Offline note creation
- Sync queue
- Firestore sync
- Connectivity detection

## How to Run
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run

## Screenshots
all the functional screen shoots are attached in project File

## Approach
The application is designed with an offline-first strategy.
1.Notes can be created while offline
2.All write operations are stored in a sync queue
3.The queue processes automatically when internet connectivity returns
4.The system avoids duplicate queue operations
5.Local database always updates instantly for UI responsiveness


## Tradeoffs
1.Hive was chosen instead of SQLite for simplicity and speed
2.Sync retry logic is basic and could be improved
3.Background synchronization is triggered on connectivity events instead of background services

## Limitations
1.No authentication system
2.No conflict resolution strategy for simultaneous updates
3.Queue retry mechanism is basic
4.Background sync is not fully automated


## Next Steps
Future improvements could include:
1.Background sync worker
2.Conflict resolution strategy
3.Unit tests for repository and sync manager
4.Firestore security rules
5.Pagination for large datasets

## Edge Cases
1.Duplicate like prevention
2.Offline note creation
3.Queue retry mechanism
4.Connectivity change detection


## App Log
I/flutter (26086): [QUEUE] Add note queued
I/flutter (26086): [QUEUE SIZE] 1
I/flutter (26086): [QUEUE] Add note queued
I/flutter (26086): [QUEUE SIZE] 2
I/flutter (26086): [QUEUE] Like queued
I/flutter (26086): [QUEUE SIZE] 3
 
I/flutter (26086): [CONNECTIVITY] Internet restored
I/flutter (26086): [SYNC] Processing add_note
I/flutter (26086): [CONNECTIVITY] Internet restored
I/flutter (26086): [SYNC] Processing add_note
I/flutter (26086): [CONNECTIVITY] Internet restored
I/flutter (26086): [SYNC] Processing add_note
I/flutter (26086): [CONNECTIVITY] Internet restored
I/flutter (26086): [SYNC] Processing add_note

I/flutter (26086): [SYNC SUCCESS]
I/flutter (26086): [QUEUE SIZE] 2
I/flutter (26086): [SYNC] Processing add_note
I/flutter (26086): [SYNC SUCCESS]
I/flutter (26086): [QUEUE SIZE] 1
I/flutter (26086): [SYNC] Processing like_note
I/flutter (26086): [SYNC SUCCESS]
I/flutter (26086): [QUEUE SIZE] 0


Again --------------

I/flutter (26086): [QUEUE] Add note queued
I/flutter (26086): [QUEUE SIZE] 1

## Getting Started

State management is handled using Riverpod Notifier with code generation.
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
