import 'package:uuid/uuid.dart';
import '../models/data/note_model.dart';
import '../services/services.dart';

class NotesRepository {

  final uuid = const Uuid();

  Future<void> addNote(String title) async {

    final id = uuid.v4();

    final note = Note(
      id: id,
      title: title,
      syncStatus: "pending",
      updatedAt: DateTime.now(),
    );

    await HiveDBService.notesBox.put(id, note.toJson());

    await HiveDBService.queueBox.add({
      "id": id,
      "type": "add_note",
      "payload": note.toJson(),
      "retry": 0
    });

    print("[QUEUE] Add note queued");
    print("[QUEUE SIZE] ${HiveDBService.queueBox.length}");
  }

  Future<void> likeNote(String noteId) async {

    final queue = HiveDBService.queueBox;

    /// Deduplication check
    bool exists = queue.values.any((item) =>
    item["type"] == "like_note" &&
        item["payload"]["noteId"] == noteId);

    if (exists) {
      print("[QUEUE] Duplicate like ignored");
      return;
    }

    final noteData = HiveDBService.notesBox.get(noteId);

    noteData["liked"] = true;

    await HiveDBService.notesBox.put(noteId, noteData);

    await queue.add({
      "id": "like_$noteId",
      "type": "like_note",
      "payload": {"noteId": noteId},
      "retry": 0
    });

    print("[QUEUE] Like queued");
    print("[QUEUE SIZE] ${queue.length}");
  }

  List<Map<String, dynamic>> getNotes() {
    return HiveDBService.notesBox.values
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}