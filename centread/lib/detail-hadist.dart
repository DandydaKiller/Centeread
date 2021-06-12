import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'web_service_url.dart';
import 'package:Centread/models/detail-hadist.dart';
import 'dart:async';
import 'dart:convert';

String ip = WebService.ip;

class DetailHadist extends StatefulWidget {
  static String tag = 'detail-hadist';
  _DetailHadistState createState() => _DetailHadistState();
  final String idBukuHadist;
  DetailHadist({Key key, @required this.idBukuHadist}) : super(key: key);
}

Future<List<DetailHadistM>> fetchHadist(String id) async {
  final response = await http.get('http://' + ip + '/detail-hadist/' + id);
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed
      .map<DetailHadistM>((json) => DetailHadistM.fromJson(json))
      .toList();
}

Future<List<DetailHadistM>> fetchNamaBuku(String id) async {
  final response = await http.get('http://' + ip + '/nama-hadist/' + id);
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed
      .map<DetailHadistM>((json) => DetailHadistM.fromJson(json))
      .toList();
}

class _DetailHadistState extends State<DetailHadist> {
  Future<List<DetailHadistM>> list_hadist;
  Future<List<DetailHadistM>> nama_buku;

  @override
  void initState() {
    super.initState();
    list_hadist = fetchHadist(widget.idBukuHadist.toString());
    nama_buku = fetchNamaBuku(widget.idBukuHadist.toString());
  }

  Widget build(BuildContext context) {
    // String nama_surah;
    final judul_surah = FutureBuilder<List<DetailHadistM>>(
      future: nama_buku,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DetailHadistM current = snapshot.data[index];
                /*if (current.namasurah.toString().isNotEmpty) {
                  nama_surah = current.namasurah.toString();
                }*/
                if (current.judulbukuhadist.toString().isNotEmpty) {
                  return Text(current.judulbukuhadist.toString(),
                      style: TextStyle(color: Colors.amber[900]));
                }
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );

    final ayat = FutureBuilder<List<DetailHadistM>>(
      future: list_hadist,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                DetailHadistM current = snapshot.data[index];
                return Column(
                  children: [
                    SizedBox(width: 20.0),
                    Column(
                      children: <Widget>[
                        /*Text(
                            (() {
                              if (current.idayat.toString() != "1" &&
                                  current.urutanayat == "1") {
                                return 'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ ';
                              } else {
                                return '';
                              }
                            }()),
                            style: TextStyle(
                              fontSize: 22,
                            )),*/
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(20),
                          child: Text(current.hadist.toString(),
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 22,
                              )),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(20),
                            child: Text(
                              current.artihadist.toString() +
                                  ' ( H.R.' +
                                  ' Nomor ' +
                                  current.urutanhadist.toString() +
                                  ')',
                              textAlign: TextAlign.justify,
                            ))
                      ],
                    ),
                    Divider(
                      color: Colors.grey[400],
                    ),
                  ],
                );
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.amber[900]),
        title: judul_surah,
        backgroundColor: Colors.amberAccent[100],
      ),
      body: Center(
        child: ListView(
          children: [
            Column(children: <Widget>[
              Divider(
                color: Colors.grey[400],
              ),
              ayat
            ])
          ],
        ),
      ),
    );
  }
}
