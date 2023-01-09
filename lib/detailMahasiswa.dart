import 'package:flutter/material.dart';
import 'package:aplikasi_mahasiswa/service/mahasiswaService.dart';
import 'editMahasiswa.dart';
import 'model/mahasiswa.dart';

class DetailMahasiswa extends StatefulWidget {
  DetailMahasiswa(this.mahasiswa);

  final Mahasiswa mahasiswa;

  @override
  _DetailMahasiswaState createState() => _DetailMahasiswaState();
}

class _DetailMahasiswaState extends State<DetailMahasiswa> {
  _DetailMahasiswaState();

  final MahasiswaService api = MahasiswaService();
  String id = '';

  @override
  void initState() {
    id = widget.mahasiswa.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Mahasiswa',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.yellow,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
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
                            Text('Nama Mahasiswa:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.mahasiswa.nama,
                                style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Nomor Induk Mahasiswa:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.mahasiswa.nim,
                                style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Program Studi:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.mahasiswa.prodi,
                                style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Alamat:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.mahasiswa.alamat,
                                style: Theme.of(context).textTheme.headline6)
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
                                _navigateToEditScreen(
                                    context, widget.mahasiswa);
                              },
                              child: Text('Edit',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                              ),
                              onPressed: () {
                                _confirmDialog();
                              },
                              child: Text('Delete',
                                  style: TextStyle(color: Colors.black)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }

  _navigateToEditScreen(BuildContext context, Mahasiswa mahasiswa) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditMahasiswa(mahasiswa)),
    );
  }

  Future<Future<Mahasiswa?>> _confirmDialog() async {
    return showDialog<Mahasiswa>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Peringatan!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Yakin nih Mau Dihapus?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yoi'),
              onPressed: () {
                api.deleteMahasiswa(widget.mahasiswa.id).then((value) {
                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));
                });
              },
            ),
            TextButton(
              child: const Text('Ndak Jadi'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
