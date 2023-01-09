import 'dart:async';

import 'package:aplikasi_mahasiswa/service/mahasiswaService.dart';
import 'package:aplikasi_mahasiswa/view/addMahasiswa.dart';
import 'package:aplikasi_mahasiswa/view/search.dart';
import 'package:flutter/material.dart';
import 'detailMahasiswa.dart';
import 'model/mahasiswa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future data;
  List<Mahasiswa> data2 = [];
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();

  void ambilData() {
    data = MahasiswaService().getMahasiswa();
    data.then((value) => {
          setState(() {
            data2 = value;
          })
        });
  }

  FutureOr onGoBack(dynamic value) {
    ambilData();
  }

  navigateAddMahasiswa() {
    Route route = MaterialPageRoute(builder: (context) => AddMahasiswa());
    Navigator.push(context, route).then(onGoBack);
  }

  @override
  void initState() {
    ambilData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/ubhara.png',
        ),
        leadingWidth: 50,
        title: !isSearching
            ? Text(
                "Mahasiswa Ubhara",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )
            : TextField(
                controller: searchText,
                style: TextStyle(color: Colors.black, fontSize: 20),
                decoration: InputDecoration(
                    hintText: "Ketikkan Nama atau NIM",
                    hintStyle: TextStyle(color: Colors.grey)),
                onSubmitted: (value) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SearchMahasiswa(keyword: searchText.text)));
                },
              ),
        backgroundColor: Colors.yellow,
        elevation: 0,
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
      body: data2.length == 0
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : ListView.builder(
              itemCount: data2.length,
              itemBuilder: (context, index) {
                return Card(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailMahasiswa(data2[index])),
                          );
                        },
                        child: ListTile(
                            leading: Icon(Icons.person, color: Colors.black),
                            title: Text(data2[index].nama),
                            subtitle: Text(data2[index].nim))));
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateAddMahasiswa();
        },
        tooltip: 'Tambah Data',
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.yellow,
      ),
    );
  }
}
