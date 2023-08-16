import 'package:flutter/material.dart';
import 'package:flutter_sql_lite_crud/views/Create_screen.dart';
import 'package:flutter_sql_lite_crud/views/delete_screen.dart';
import 'package:flutter_sql_lite_crud/views/read_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  sqfliteFfiInit(); // Initialize FFI

  runApp(
    FutureBuilder<void>(
      future: _initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        } else {
          return const CircularProgressIndicator();
        }
      },
    ),
  );
}

Future<void> _initializeApp() async {
  databaseFactory = databaseFactoryFfi;
  // Additional initialization steps if needed
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema App',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinema App'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cinema App - SQL Lite',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: const ButtonStyle(
                fixedSize: MaterialStatePropertyAll(Size.fromWidth(250)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateScreen()),
                );
              },
              child: const Text('Create Movie'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: const ButtonStyle(
                fixedSize: MaterialStatePropertyAll(Size.fromWidth(250)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReadScreen()),
                );
              },
              child: const Text('Read Movies'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: const ButtonStyle(
                fixedSize: MaterialStatePropertyAll(Size.fromWidth(250)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeleteScreen()),
                );
              },
              child: const Text('Delete Movie'),
            ),
          ],
        ),
      ),
    );
  }
}
