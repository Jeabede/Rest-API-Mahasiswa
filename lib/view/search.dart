import 'package:flutter/material.dart';
import '../detailMahasiswa.dart';
import '../model/mahasiswa.dart';
import '../service/mahasiswaService.dart';

// ignore: must_be_immutable
class SearchMahasiswa extends StatefulWidget {
  late String keyword;

  SearchMahasiswa({required this.keyword});

  @override
  State<SearchMahasiswa> createState() => _SearchMahasiswaState();
}

class _SearchMahasiswaState extends State<SearchMahasiswa> {
  late Future data;
  List<Mahasiswa> data2 = [];
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();
  bool cekData = true;

  @override
  void initState() {
    data = MahasiswaService().getMahasiswa();
    data.then((value) => {
          setState(() {
            data2 = value;
            data2 = data2
                .where((element) =>
                    element.nama
                        .toLowerCase()
                        .contains(widget.keyword.toLowerCase()) ||
                    element.nim
                        .toString()
                        .toLowerCase()
                        .contains(widget.keyword))
                .toList();
            if (data2.length == 0) {
              cekData = false;
            }
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text(
                "Hasil Pencarian",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )
            : TextField(
                controller: searchText,
                style: TextStyle(color: Colors.black, fontSize: 20),
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
      body: data2.length == 0
          ? cekData
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : Center(
                  child: Text(
                    "Pencarian Tidak Ditemukan",
                    style: TextStyle(fontSize: 20),
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
    );
  }
}
