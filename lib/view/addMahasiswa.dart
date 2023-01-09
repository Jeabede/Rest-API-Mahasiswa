import 'package:aplikasi_mahasiswa/view/search.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_mahasiswa/service/mahasiswaService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddMahasiswa extends StatefulWidget {
  const AddMahasiswa({super.key});

  @override
  State<AddMahasiswa> createState() => _AddMahasiswaState();
}

class _AddMahasiswaState extends State<AddMahasiswa> {
  final _formKey = GlobalKey<FormState>();

  bool isSearching = false;
  TextEditingController searchText = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController prodiController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  int count = 0;

  void createData() {
    MahasiswaService()
        .saveMahasiswa(idController.text, namaController.text,
            nimController.text, prodiController.text, alamatController.text)
        .then((value) {
      setState(() {
        if (value) {
          Alert(
              context: context,
              title: "Berhasil",
              desc: "Data Tersimpan Brodi",
              type: AlertType.success,
              buttons: [
                DialogButton(
                    child: Text("OK", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    })
              ]).show();
        } else {
          Alert(
              context: context,
              title: "Gagal",
              desc: "Data Gagal Tersimpan Bro. Coba Lagi",
              type: AlertType.error,
              buttons: [
                DialogButton(
                    child: Text("OK", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]).show();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: !isSearching
              ? Text(
                  "Tambah Data Mahasiswa",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )
              : TextField(
                  controller: searchText,
                  style: TextStyle(color: Colors.black, fontSize: 26),
                  decoration: InputDecoration(
                      hintText: "Pencarian",
                      hintStyle: TextStyle(color: Colors.grey)),
                  onSubmitted: (value) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            SearchMahasiswa(keyword: searchText.text)));
                  },
                ),
          backgroundColor: Colors.yellow,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    this.isSearching = !this.isSearching;
                  });
                },
                icon: !isSearching
                    ? Icon(Icons.search, color: Colors.black)
                    : Icon(Icons.cancel, color: Colors.red))
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: namaController,
                    decoration: InputDecoration(
                        hintText: 'Masukkan Nama Lengkap Mahasiswa',
                        labelText: 'Nama Mahasiswa',
                        icon: Icon(Icons.assignment_ind)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama Tidak Boleh Kosong!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: nimController,
                    decoration: InputDecoration(
                        hintText: 'Masukkan NIM Mahasiswa',
                        labelText: 'Nomor Induk Mahasiswa',
                        icon: Icon(Icons.assignment_outlined)),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'NIM Tidak Boleh Kosong!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: prodiController,
                    decoration: InputDecoration(
                        hintText: 'Masukkan Program Studi Mahasiswa',
                        labelText: 'Program Studi Mahasiswa',
                        icon: Icon(Icons.import_contacts)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Program Studi Tidak Boleh Kosong!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: alamatController,
                    decoration: InputDecoration(
                        hintText: 'Masukkan Alamat Mahasiswa',
                        labelText: 'Alamat Mahasiswa',
                        icon: Icon(Icons.location_on)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat Tidak Boleh Kosong!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          createData();
                        }
                      },
                      child: Text("Simpan Data",
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                      ))
                ],
              )),
        ));
  }
}
