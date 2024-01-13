import 'package:flutter/material.dart';
import 'student/student_form.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student App',
      theme: ThemeData(
        // Postavke teme
      ),
      home: const BasicScreen(),
    );
  }
}

class BasicScreen extends StatelessWidget {
  const BasicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Osnovni ekran'),
      ),
      body: const Center(
        child: Text('Ovo je osnovni ekran'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_moderator),
            label: 'Unos studenta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Pretraga studenata',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StudentForm()),
            );
          } else {
            // Dodajte druge logike navigacije prema potrebi
          }
        },
      ),
    );
  }
}
