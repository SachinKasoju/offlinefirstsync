import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:offline_sync_first/services/services.dart';

class SyncManager {

  final firestore = FirebaseFirestore.instance;

  Future<void> syncQueue() async {

    final queue = HiveDBService.queueBox;

    while (queue.isNotEmpty) {

      var action = queue.getAt(0);

      try {

        print("[SYNC] Processing ${action["type"]}");

        /// ADD NOTE
        if (action["type"] == "add_note") {

          await firestore
              .collection("notes")
              .doc(action["payload"]["id"])
              .set(
            action["payload"],
            SetOptions(merge: true), // idempotent write
          );

          var note = HiveDBService.notesBox.get(action["payload"]["id"]);

          if (note != null) {
            note["syncStatus"] = "synced";

            await HiveDBService.notesBox.put(note["id"], note);
          }
        }

        /// LIKE NOTE
        if (action["type"] == "like_note") {

          await firestore
              .collection("notes")
              .doc(action["payload"]["noteId"])
              .set(
            {"liked": true},
            SetOptions(merge: true), // idempotent
          );
        }

        /// SUCCESS → remove from queue
        await queue.deleteAt(0);

        print("[SYNC SUCCESS]");
        print("[QUEUE SIZE] ${queue.length}");

      } catch (e) {

        print("[SYNC FAILED] $e");

        int retry = action["retry"] ?? 0;

        /// Retry logic
        if (retry < 2) {

          action["retry"] = retry + 1;

          await queue.putAt(0, action);

          print("[RETRY] attempt ${action["retry"]} in 2 seconds");

          await Future.delayed(const Duration(seconds: 2));

        } else {

          /// Drop action after max retries
          print("[DROP] retry exceeded → removing action");

          await queue.deleteAt(0);
        }
      }
    }
  }
}