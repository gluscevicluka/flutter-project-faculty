// student_form.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_first_app/student/student_model.dart';
import 'package:flutter_first_app/smer/smer_model.dart';
import 'package:flutter_first_app/mesto/mesto_model.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({Key? key}) : super(key: key);

  @override
  StudentFormState createState() => StudentFormState();
}

class StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  late Student _student;
  late List<Smer> _smerovi = [];
  Smer? _selectedSmer;

  late List<Mesto> _mesta = [];
  Mesto? _selectedMesto;
  Mesto? _selectedMestoRodjenja;

  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _student = Student(
      id: 0,
      brojIndeksa: '',
      ime: '',
      prezime: '',
      datumRodjenja: DateTime.now(),
      email: '',
      adresaBoravka: '',
      telefon: '',
      lozinka: '',
      timestamp: DateTime.now(),
      boravakMestoId: 0,
      rodjenjeMestoId: 0,
      upisanaGodinaStudije: 0,
      smerId: 0,
    );

    _fetchSmerovi();
    _fetchMesta();
  }

  //Preload database fetch data
  Future<void> _fetchSmerovi() async {
    try {
      List<Smer> smerovi = await getSmerovi();
      setState(() {
        _smerovi = smerovi;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _fetchMesta() async {
    try {
      List<Mesto> mesta = await getMesta();
      setState(() {
        _mesta = mesta;
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Unos studenta'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Broj indeksa'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite broj indeksa';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _student = _student.copyWith(brojIndeksa: value!);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Ime'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite ime';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _student = _student.copyWith(ime: value!);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Prezime'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite prezime';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _student = _student.copyWith(prezime: value!);
                    },
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Datum rodjenja',
                      suffixIcon: IconButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null &&
                              pickedDate != _selectedDate) {
                            setState(() {
                              _selectedDate = pickedDate;
                              _dateController.text =
                                  DateFormat("yyyy-MM-dd").format(pickedDate);
                            });
                          }
                        },
                        icon: Icon(Icons.date_range),
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _student = _student.copyWith(email: value!);
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Adresa borakva'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite adresu boravka';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _student = _student.copyWith(adresaBoravka: value!);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Telefon'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite telefon';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _student = _student.copyWith(telefon: value!);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Lozinka'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite lozinku';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _student = _student.copyWith(lozinka: value!);
                    },
                  ),
                  DropdownButtonFormField<Mesto>(
                    value: _selectedMestoRodjenja,
                    items: _mesta.map((mesto) {
                      return DropdownMenuItem<Mesto>(
                        value: mesto,
                        child: Text(mesto.nazivMesta),
                      );
                    }).toList(),
                    onChanged: (Mesto? value) {
                      setState(() {
                        _selectedMestoRodjenja = value;
                        _student =
                            _student.copyWith(boravakMestoId: value!.idMesto);
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Izaberite mesto rodjenja';
                      }
                      return null;
                    },
                    decoration:
                        const InputDecoration(labelText: 'Mesto rodjenja'),
                  ),
                  DropdownButtonFormField<Mesto>(
                    value: _selectedMesto,
                    items: _mesta.map((mesto) {
                      return DropdownMenuItem<Mesto>(
                        value: mesto,
                        child: Text(mesto.nazivMesta),
                      );
                    }).toList(),
                    onChanged: (Mesto? value) {
                      setState(() {
                        _selectedMesto = value;
                        _student =
                            _student.copyWith(boravakMestoId: value!.idMesto);
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Izaberite mesto boravka';
                      }
                      return null;
                    },
                    decoration:
                        const InputDecoration(labelText: 'Mesto boravka'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Upisana godina studija'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite upisanu godinu studija';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _student = _student.copyWith(
                          upisanaGodinaStudije: int.parse(value!));
                    },
                  ),
                  DropdownButtonFormField<Smer>(
                    value: _selectedSmer,
                    items: _smerovi.map((smer) {
                      return DropdownMenuItem<Smer>(
                        value: smer,
                        child: Text(smer.nazivSmera),
                      );
                    }).toList(),
                    onChanged: (Smer? value) {
                      setState(() {
                        _selectedSmer = value;
                        _student = _student.copyWith(smerId: value!.id);
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Izaberite smer';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Smer'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Ovde pozovite API servis za dodavanje studenta
                          // Na primer, studentService.addStudent(_student);
                        }
                      },
                      child: const Text('Potvrdi'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
