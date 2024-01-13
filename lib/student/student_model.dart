// student_model.dart

class Student {
  final int id;
  final String brojIndeksa;
  final String ime;
  final String prezime;
  final DateTime datumRodjenja;
  final String email;
  final String adresaBoravka;
  final String telefon;
  final String lozinka;
  final DateTime timestamp;
  final int boravakMestoId;
  final int rodjenjeMestoId;
  final int upisanaGodinaStudije;
  final int smerId;

  Student({
    required this.id,
    required this.brojIndeksa,
    required this.ime,
    required this.prezime,
    required this.datumRodjenja,
    required this.email,
    required this.adresaBoravka,
    required this.telefon,
    required this.lozinka,
    required this.timestamp,
    required this.boravakMestoId,
    required this.rodjenjeMestoId,
    required this.upisanaGodinaStudije,
    required this.smerId,
  });

  Student copyWith({
    int? id,
    String? brojIndeksa,
    String? ime,
    String? prezime,
    DateTime? datumRodjenja,
    String? email,
    String? adresaBoravka,
    String? telefon,
    String? lozinka,
    DateTime? timestamp,
    int? boravakMestoId,
    int? rodjenjeMestoId,
    int? upisanaGodinaStudije,
    int? smerId,
  }) {
    return Student(
      id: id ?? this.id,
      brojIndeksa: brojIndeksa ?? this.brojIndeksa,
      ime: ime ?? this.ime,
      prezime: prezime ?? this.prezime,
      datumRodjenja: datumRodjenja ?? this.datumRodjenja,
      email: email ?? this.email,
      adresaBoravka: adresaBoravka ?? this.adresaBoravka,
      telefon: telefon ?? this.telefon,
      lozinka: lozinka ?? this.lozinka,
      timestamp: timestamp ?? this.timestamp,
      boravakMestoId: boravakMestoId ?? this.boravakMestoId,
      rodjenjeMestoId: rodjenjeMestoId ?? this.rodjenjeMestoId,
      upisanaGodinaStudije: upisanaGodinaStudije ?? this.upisanaGodinaStudije,
      smerId: smerId ?? this.smerId,
    );
  }
}
