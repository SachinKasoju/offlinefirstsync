import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/notes_repository.dart';

part 'notes_provider.g.dart';

/// Repository Provider
@riverpod
NotesRepository notesRepository(NotesRepositoryRef ref) {
  return NotesRepository();
}

/// Notes State Notifier
@riverpod
class NotesNotifier extends _$NotesNotifier {

  @override
  List<Map<String, dynamic>> build() {
    final repo = ref.read(notesRepositoryProvider);

    final notes = repo.getNotes();

    notes.sort(
          (a, b) => DateTime.parse(a["updatedAt"])
          .compareTo(DateTime.parse(b["updatedAt"])),
    );

    return notes;
  }

  Future<void> addNote(String title) async {
    final repo = ref.read(notesRepositoryProvider);

    await repo.addNote(title);

    state = build();
  }

  Future<void> likeNote(String id) async {
    final repo = ref.read(notesRepositoryProvider);

    await repo.likeNote(id);

    state = build();
  }
}