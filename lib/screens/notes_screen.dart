import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/notes_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../services/sync_manager.dart';

class NotesScreen extends ConsumerWidget {
  NotesScreen({super.key});

  final controller = TextEditingController();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final notes = ref.watch(notesNotifierProvider);
    final notifier = ref.read(notesNotifierProvider.notifier);

    Connectivity().onConnectivityChanged.listen((status) {
      if (status != ConnectivityResult.none) {
        print("[CONNECTIVITY] Internet restored");
        SyncManager().syncQueue();
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text(
          "Offline-first Sync Queue",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: notes.isEmpty
          ? const Center(
        child: Text(
          "No Notes Yet",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          controller: scrollController,
          itemCount: notes.length,
          itemBuilder: (context, index) {

            final note = notes[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 12),

              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      note["title"],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Row(
                    children: [

                      if (note["syncStatus"] == "pending")
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.sync,
                            color: Colors.orange,
                          ),
                        ),

                      IconButton(
                        icon: Icon(
                          note["liked"] == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: note["liked"] == true
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          notifier.likeNote(note["id"]);
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),

        onPressed: () {

          showDialog(
            context: context,
            builder: (context) {

              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                title: const Text(
                  "Add Note",
                  style:
                  TextStyle(fontWeight: FontWeight.bold),
                ),

                content: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Enter note text",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                  ),
                ),

                actions: [

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close",
                        style: TextStyle(color: Colors.white)),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () async {

                      if (controller.text.isNotEmpty) {

                        await notifier.addNote(controller.text);

                        controller.clear();

                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Save",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}