import 'package:flutter/material.dart';
import 'package:aplikasi_mahasiswa/service/mahasiswaService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'main.dart';
import 'model/mahasiswa.dart';

class EditMahasiswa extends StatefulWidget {
  EditMahasiswa(this.mahasiswa);

  final Mahasiswa mahasiswa;

  @override
  _EditMahasiswaState createState() => _EditMahasiswaState();
}

class _EditMahasiswaState extends State<EditMahasiswa> {
  _EditMahasiswaState();

  final MahasiswaService api = MahasiswaService();
  final _addFormKey = GlobalKey<FormState>();
  String id = '';
  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final prodiController = TextEditingController();
  final alamatController = TextEditingController();

  int count = 0;

  @override
  void initState() {
    id = widget.mahasiswa.id;
    namaController.text = widget.mahasiswa.nama;
    nimController.text = widget.mahasiswa.nim;
    prodiController.text = widget.mahasiswa.prodi;
    alamatController.text = widget.mahasiswa.alamat;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Mahasiswa',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.yellow,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: namaController,
                                decoration: const InputDecoration(
                                  labelText: 'Nama Lengkap Mahasiswa',
                                  hintText: 'Masukkan Nama Lengkap Mahasiswa',
                                  icon: Icon(Icons.assignment_ind),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Nama Tidak Boleh Kosong!';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: nimController,
                                decoration: const InputDecoration(
                                  labelText: 'Nomor Induk Mahasiswa',
                                  hintText: 'Masukkan NIM Mahasiswa',
                                  icon: Icon(Icons.assignment_outlined),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'NIM Tidak Boleh Kosong!';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: prodiController,
                                decoration: const InputDecoration(
                                  labelText: 'Program Studi Mahasiswa',
                                  hintText: 'Masukkan Program Studi Mahasiswa',
                                  icon: Icon(Icons.import_contacts),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Program Studi Tidak Boleh Kosong!';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: alamatController,
                                decoration: const InputDecoration(
                                  labelText: 'Alamat Mahasiswa',
                                  hintText: 'Masukkan Alamat Mahasiswa',
                                  icon: Icon(Icons.location_on),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Alamat Tidak Boleh Kosong!';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow,
                                ),
                                onPressed: () {
                                  if (_addFormKey.currentState!.validate()) {
                                    _addFormKey.currentState!.save();
                                    api
                                        .updateMahasiswa(
                                            id,
                                            namaController.text,
                                            nimController.text,
                                            prodiController.text,
                                            alamatController.text)
                                        .then((value) {
                                      setState(() {
                                        if (value) {
                                          Alert(
                                              context: context,
                                              title: "Berhasil",
                                              desc:
                                                  "Data Berhasil Diedit Brodi",
                                              type: AlertType.success,
                                              buttons: [
                                                DialogButton(
                                                    child: Text("OK",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    onPressed: () {
                                                      _navigateToMain(context,
                                                          widget.mahasiswa);
                                                    })
                                              ]).show();
                                        } else {
                                          Alert(
                                              context: context,
                                              title: "Gagal",
                                              desc:
                                                  "Data Gagal Diedit Bro. Coba Lagi",
                                              type: AlertType.error,
                                              buttons: [
                                                DialogButton(
                                                    child: Text("OK",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    })
                                              ]).show();
                                        }
                                      });
                                    });
                                  }
                                },
                                child: Text('Simpan Perubahan',
                                    style: TextStyle(color: Colors.black)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }

  _navigateToMain(BuildContext context, Mahasiswa mahasiswa) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }
}
