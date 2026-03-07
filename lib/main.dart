import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:offline_sync_first/screens/notes_screen.dart';
import 'package:offline_sync_first/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveDBService.init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Offline First Sync",
      debugShowCheckedModeBanner: false,
      home: NotesScreen(),
    );
  }
}