import 'dart:convert';
import 'package:http/http.dart' as http;

class Mesto {
  final int idMesto;
  final String nazivMesta;
  final String pttOznaka;
  final int pttBroj;
  final String drzava;

  Mesto({
    required this.idMesto,
    required this.nazivMesta,
    required this.pttOznaka,
    required this.pttBroj,
    required this.drzava,
  });

  factory Mesto.fromJson(Map<String, dynamic> json) {
    return Mesto(
      idMesto: json['idMesto'],
      nazivMesta: json['nazivMesta'],
      pttOznaka: json['pttOznaka'],
      pttBroj: json['pttBroj'],
      drzava: json['drzava'],
    );
  }
}

Future<List<Mesto>> getMesta() async {
  final response = await http.get(
    Uri.parse('https://pmappbk2.ddns.net/Mesto/get_mesta'),
  );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<Mesto> mesta = data.map((item) => Mesto.fromJson(item)).toList();

    return mesta;
  } else {
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to load mesta');
  }
}
