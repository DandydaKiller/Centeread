import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'web_service_url.dart';
import 'package:Centread/models/hasil-tafsir.dart';
import 'dart:async';
import 'dart:convert';

String ip = WebService.ip;

class HasilTafsir extends StatefulWidget {
  static String tag = 'detail-quran';
  _HasilTafsirState createState() => _HasilTafsirState();
  final String idTafsir;
  HasilTafsir({Key key, @required this.idTafsir}) : super(key: key);
}

Future<List<HasilTafsirM>> fetchAyat(String id) async {
  final response = await http.get('http://' + ip + '/detail-tafsir/' + id);
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed
      .map<HasilTafsirM>((json) => HasilTafsirM.fromJson(json))
      .toList();
}

Future<List<HasilTafsirM>> fetchNamaSurah(String id) async {
  final response = await http.get('http://' + ip + '/detail-tafsir/' + id);
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed
      .map<HasilTafsirM>((json) => HasilTafsirM.fromJson(json))
      .toList();
}

class _HasilTafsirState extends State<HasilTafsir> {
  Future<List<HasilTafsirM>> list_ayat;
  Future<List<HasilTafsirM>> nama_surah;

  @override
  void initState() {
    super.initState();
    list_ayat = fetchAyat(widget.idTafsir.toString());
    nama_surah = fetchNamaSurah(widget.idTafsir.toString());
  }

  Widget build(BuildContext context) {
    // String nama_surah;
    bool berhenti = false;
    final judul_surah = FutureBuilder<List<HasilTafsirM>>(
      future: nama_surah,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                HasilTafsirM current = snapshot.data[index];
                /*if (current.namasurah.toString().isNotEmpty) {
                  nama_surah = current.namasurah.toString();
                }*/
                if (current.namasurah.toString().isNotEmpty &&
                    berhenti == false) {
                  berhenti = true;
                  return Text(current.namasurah.toString(),
                      style: TextStyle(color: Colors.red[900]));
                }
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );

    final ayat = FutureBuilder<List<HasilTafsirM>>(
      future: list_ayat,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                HasilTafsirM current = snapshot.data[index];
                return Column(
                  children: [
                    SizedBox(width: 20.0),
                    Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              ' Surah ' +
                                  current.namasurah +
                                  ' Ayat Ke- ' +
                                  current.ayat.toString() +
                                  '',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.red[900],
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              current.tafsir.toString(),
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
        iconTheme: IconThemeData(color: Colors.red[900]),
        title: judul_surah,
        backgroundColor: Colors.red[200],
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
