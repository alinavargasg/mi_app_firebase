import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      home: const AuthExample(), // ✅ marcado como const
    );
  }
}

class AuthExample extends StatefulWidget {
  const AuthExample({super.key}); // ✅ Constructor con key

  @override
  AuthExampleState createState() => AuthExampleState(); // ✅ clase pública
}

class AuthExampleState extends State<AuthExample> {
  String status = "Not signed in";

  void signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      setState(() {
        status = "Signed in anonymously";
      });
    } catch (e) {
      setState(() {
        status = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firebase Auth")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(status),
            ElevatedButton(
              onPressed: signInAnonymously,
              child: const Text("Login anónimo"),
            ),
          ],
        ),
      ),
    );
  }
}
