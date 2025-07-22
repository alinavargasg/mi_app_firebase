import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configuración de logging
  debugPrint = (String? message, {int? wrapWidth}) {
    developer.log(message ?? '', name: 'APP');
  };

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      developer.log('Usuario anónimo conectado: ${userCredential.user?.uid}');

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      developer.log('Error en login anónimo: $e', error: e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al conectar: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autenticación'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido a la App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Cambia el color
                  padding: const EdgeInsets.symmetric(vertical: 15), // Ajusta el padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                /*Inicia sesión al hacer clic en el botón "Ingresar como Invitado"*/
                onPressed: () => _signInAnonymously(context),
                child: const Text(
                  'Ingresar como Invitado',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<String> _fetchSaludo() async {
    try {
      const url = 'http://10.0.2.2:3000/saludo'; // Para Android emulator
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['mensaje'] ?? 'Mensaje no encontrado';
      }
      return 'Error en la API: ${response.statusCode}';
    } catch (e) {
      developer.log('Error de conexión: $e', error: e);
      return 'Error de conexión: Verifica tu servidor local';
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              /*Cierra sesión al hacer clic en el icono de la parte superior derecha
              de la pantalla*/
              await _signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const AuthScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _fetchSaludo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.data ?? 'No hay mensaje',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                const Text('Estás autenticado como usuario anónimo'),
              ],
            );
          },
        ),
      ),
    );
  }
}