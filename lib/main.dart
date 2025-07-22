import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      title: 'Mi App Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return snapshot.data != null
              ? HomeScreen(user: snapshot.data!)
              : const LoginScreen();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No autenticado'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signInAnonymously(context),
              child: const Text('Login Anónimo'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  static const _apiUrl = 'http://localhost:3000/saludo';

  Future<String> _fetchSaludo() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['mensaje'] ?? 'Mensaje no encontrado';
      }
      return 'Error HTTP: ${response.statusCode}';
    } catch (e) {
      return 'Error de conexión: ${e.toString()}';
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Usuario: ${user.isAnonymous ? 'Anónimo' : user.email}'),
            const SizedBox(height: 20),
            FutureBuilder<String>(
              future: _fetchSaludo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return Text(
                  snapshot.hasData ? 'Saludo: ${snapshot.data}' : 'Error',
                  style: Theme.of(context).textTheme.titleMedium,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}