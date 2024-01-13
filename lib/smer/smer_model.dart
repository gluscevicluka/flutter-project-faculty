
import 'dart:convert';
import 'package:http/http.dart' as http;

class Smer {
  final int id;
  final String naziv;

  Smer({required this.id, required this.naziv});

  factory Smer.fromJson(Map<String, dynamic> json) {
    return Smer(
      id: json['id'],
      naziv: json['naziv'],
    );
  }
}

// smer_api.dart

Future<List<Smer>> getSmerovi() async {
  final response = await http.get(Uri.parse('https://pmappbk2.ddns.net/Smer/get_smerovi'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    List<Smer> smerovi = jsonData.map((json) => Smer.fromJson(json)).toList();
    return smerovi;
  } else {
    throw Exception('Failed to load smerovi');
  }
}
