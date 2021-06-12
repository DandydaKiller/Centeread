import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'web_service_url.dart';
import 'package:Centread/models/detail-quran.dart';
import 'dart:async';
import 'dart:convert';

String ip = WebService.ip;

class DetailQuran extends StatefulWidget {
  static String tag = 'detail-quran';
  _DetailQuranState createState() => _DetailQuranState();
  final String idSurah;
  DetailQuran({Key key, @required this.idSurah}) : super(key: key);
}

Future<List<DetailQuranM>> fetchAyat(String id) async {
  final response = await http.get('http://' + ip + '/detail-ayat/' + id);
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed
      .map<DetailQuranM>((json) => DetailQuranM.fromJson(json))
      .toList();
}

Future<List<DetailQuranM>> fetchNamaSurah(String id) async {
  final response = await http.get('http://' + ip + '/nama-surah/' + id);
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed
      .map<DetailQuranM>((json) => DetailQuranM.fromJson(json))
      .toList();
}

class _DetailQuranState extends State<DetailQuran> {
  Future<List<DetailQuranM>> list_ayat;
  Future<List<DetailQuranM>> nama_surah;

  @override
  void initState() {
    super.initState();
    list_ayat = fetchAyat(widget.idSurah.toString());
    nama_surah = fetchNamaSurah(widget.idSurah.toString());
  }

  Widget build(BuildContext context) {
    // String nama_surah;
    final judul_surah = FutureBuilder<List<DetailQuranM>>(
      future: nama_surah,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DetailQuranM current = snapshot.data[index];
                /*if (current.namasurah.toString().isNotEmpty) {
                  nama_surah = current.namasurah.toString();
                }*/
                if (current.namasurah.toString().isNotEmpty) {
                  return Text(current.namasurah.toString(),
                      style: TextStyle(color: Colors.green[900]));
                }
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );

    final ayat = FutureBuilder<List<DetailQuranM>>(
      future: list_ayat,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                DetailQuranM current = snapshot.data[index];
                return Column(
                  children: [
                    SizedBox(width: 20.0),
                    Column(
                      children: <Widget>[
                        Text(
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
                            )),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(20),
                          child: Text(current.ayat.toString(),
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 22,
                              )),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(20),
                            child: Text(
                              current.artiayat.toString() +
                                  ' (' +
                                  current.urutanayat.toString() +
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
        iconTheme: IconThemeData(color: Colors.green[900]),
        title: judul_surah,
        backgroundColor: Colors.green[200],
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
