// search_students.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_first_app/student/student_model.dart';

class SearchStudentsPage extends StatefulWidget {
  const SearchStudentsPage({Key? key}) : super(key: key);

  @override
  SearchStudentsPageState createState() => SearchStudentsPageState();
}

class SearchStudentsPageState extends State<SearchStudentsPage> {
  TextEditingController _prezimeController = TextEditingController();
  String _poslednjePrezime = '';
  List<Student> _rezultatiPretrage = [];

  @override
  void initState() {
    super.initState();
    _loadLastPrezime();
  }

  void _loadLastPrezime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedPrezime = prefs.getString('poslednjePrezime') ?? '';

    setState(() {
      _poslednjePrezime = savedPrezime;
      _prezimeController.text = savedPrezime;
      //Pokrece pretragu ukoliko je sacuvana sesija
      _pretragaStudenata(savedPrezime);
    });
  }

  void _saveLastPrezime(String prezime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('poslednjePrezime', prezime);
  }

  Future<void> _pretragaStudenata(String prezime) async {
    if (prezime != '') {
      String apiUrl =
          'https://pmappbk2.ddns.net/Student/get_studenti_po_prezimenu?prezime=$prezime';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Ako je uspešno, dekodirajte JSON odgovor u listu studenata
        List<dynamic> data = jsonDecode(response.body);
        List<Student> rezultati =
            data.map((json) => Student.fromJson(json)).toList();

        setState(() {
          _rezultatiPretrage = rezultati;
        });
      } else {
        // Ako nije uspešno, tretirajte odgovor prema potrebi
        print(
            'Greška prilikom pretrage studenata. Kod greške: ${response.statusCode}');
        print(response.body);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pretraga studenata'),
        ),
        body: Center(
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _prezimeController,
                    decoration: const InputDecoration(
                      labelText: 'Prezime',
                      hintText: 'Unesite prezime',
                      contentPadding: EdgeInsets.only(bottom: 8.0),
                    ),
                    onChanged: (value) {
                      if (value.length >= 2) {
                        _saveLastPrezime(value);
                        _pretragaStudenata(value);
                      }
                    },
                  ),
                  // Prikaz rezultata pretrage koristeći Card widget
                  Expanded(
                    child: ListView.builder(
                      itemCount: _rezultatiPretrage.length,
                      itemBuilder: (context, index) {
                        Student student = _rezultatiPretrage[index];

                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('assets/hat.png'),
                              radius:
                                  30, // Prilagodite veličinu kruga prema potrebi
                            ),
                            title: Text('${student.ime} ${student.prezime}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Datum rođenja: ${student.datumRodjenja}'),
                                Text('Email: ${student.email}'),
                                Text(
                                    'Mesto stanovanja: ${student.adresaBoravka}'),
                                Text('Broj telefona: ${student.telefon}'),
                                // Dodajte ostale informacije o studentu prema potrebi
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
