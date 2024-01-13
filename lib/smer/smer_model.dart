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
  const token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IkdsdXNjZXZpYyIsIm5hbWVpZCI6ImdsdXNjZXZpY2x1a2FAZ21haWwuY29tIiwiSWQiOiI5OSIsIlRpbWVTdGFtcCI6IjEvMTMvMjAyNCA2OjM3OjQxIFBNIiwibmJmIjoxNzA1MTY3NDYxLCJleHAiOjE3MDUxOTYyNjEsImlhdCI6MTcwNTE2NzQ2MX0.omIBkOzkA_gJuuDuuYg9guTSfltlK3H2AJZdxzct76w';
  final response = await http.get(
    Uri.parse('https://pmappbk2.ddns.net/Smer/get_smerovi'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    // Ako je status OK (200), parsiraj odgovor
    List<dynamic> data = json.decode(response.body);
    List<Smer> smerovi = data.map((item) => Smer.fromJson(item)).toList();
    return smerovi;
  } else {
    // Ako nije OK, baci izuzetak
    throw Exception('Failed to load smerovi');
  }
}
