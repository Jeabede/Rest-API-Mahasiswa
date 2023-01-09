import 'dart:convert';

import 'package:aplikasi_mahasiswa/model/mahasiswa.dart';
import 'package:http/http.dart' as http;

class MahasiswaService {
  static final String _baseURL =
      'http://otwgus.my.id/belajar/index.php/mahasiswa';

  Future getMahasiswa() async {
    Uri urlApi = Uri.parse(_baseURL);

    final response = await http.get(urlApi);
    if (response.statusCode == 200) {
      return mahasiswaFromJson(response.body.toString());
    } else {
      throw Exception("Failed to Load data Mahasiswa");
    }
  }

  Future saveMahasiswa(
      String id, String nama, String nim, String prodi, String alamat) async {
    Uri urlApi = Uri.parse(_baseURL);

    final response = await http.post(urlApi,
        body: ({
          "id": id,
          "nama": nama,
          "nim": nim,
          "prodi": prodi,
          "alamat": alamat
        }));
    if (response.statusCode == 200) {
      print("Berhasil Menyimpan Data");
      return true;
    } else {
      print("Gagal Menyimpan Data");
      return false;
    }
  }

  Future updateMahasiswa(
      String id, String nama, String nim, String prodi, String alamat) async {
    Uri urlApi = Uri.parse(_baseURL);

    final response = await http.put('$_baseURL/$id',
        body: ({
          "id": id,
          "nama": nama,
          "nim": nim,
          "prodi": prodi,
          "alamat": alamat
        }));

    if (response.statusCode == 200) {
      print("Berhasil Mengedit Data");
      return true;
    } else {
      print("Gagal mengedit Data");
      return false;
    }
  }

  Future<Mahasiswa> deleteMahasiswa(String id) async {
    Uri urlApi = Uri.parse(_baseURL);
    final http.Response response = await http.delete(
      '$_baseURL/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      print("Berhasil Menghapus Data");
      return Mahasiswa.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal Menghapus Data');
    }
  }
}
