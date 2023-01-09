import 'dart:convert';

List<Mahasiswa> mahasiswaFromJson(String str) =>
    List<Mahasiswa>.from(json.decode(str).map((x) => Mahasiswa.fromJson(x)));

String mahasiswaToJson(List<Mahasiswa> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mahasiswa {
  Mahasiswa({
    required this.id,
    required this.nama,
    required this.nim,
    required this.prodi,
    required this.alamat,
  });

  String id;
  String nama;
  String nim;
  String prodi;
  String alamat;

  factory Mahasiswa.fromJson(Map<String, dynamic> json) => Mahasiswa(
        id: json["id"],
        nama: json["nama"],
        nim: json["nim"],
        prodi: json["prodi"],
        alamat: json["alamat"],
      );

  get title => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "nim": nim,
        "prodi": prodi,
        "alamat": alamat,
      };
}
