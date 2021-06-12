import 'package:Centread/manhaj.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'web_service_url.dart';
import 'package:Centread/models/detail-manhaj.dart';
import 'dart:async';
import 'dart:convert';

String ip = WebService.ip;

class DetailManhaj extends StatefulWidget {
  static String tag = 'detail-manhaj';
  _DetailManhajState createState() => _DetailManhajState();
  final String idManhaj;
  DetailManhaj({Key key, @required this.idManhaj}) : super(key: key);
}

Future<List<DetailManhajM>> fetchManhaj(String id) async {
  final response = await http.get('http://' + ip + '/detail-manhaj/' + id);
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed
      .map<DetailManhajM>((json) => DetailManhajM.fromJson(json))
      .toList();
}

Future<List<DetailManhajM>> fetchNamaManhaj(String id) async {
  final response = await http.get('http://' + ip + '/nama-manhaj/' + id);
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed
      .map<DetailManhajM>((json) => DetailManhajM.fromJson(json))
      .toList();
}

class _DetailManhajState extends State<DetailManhaj> {
  Future<List<DetailManhajM>> list_manhaj;
  Future<List<DetailManhajM>> nama_manhaj;

  @override
  void initState() {
    super.initState();
    list_manhaj = fetchManhaj(widget.idManhaj.toString());
    nama_manhaj = fetchNamaManhaj(widget.idManhaj.toString());
  }

  Widget build(BuildContext context) {
    // String nama_surah;
    final judul_manhaj = FutureBuilder<List<DetailManhajM>>(
      future: nama_manhaj,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DetailManhajM current = snapshot.data[index];
                /*if (current.namasurah.toString().isNotEmpty) {
                  nama_surah = current.namasurah.toString();
                }*/
                if (current.namaManhaj.toString().isNotEmpty) {
                  return Text(
                    current.namaManhaj.toString(),
                    style: TextStyle(color: Colors.indigo[900]),
                  );
                }
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );

    final manhaj = FutureBuilder<List<DetailManhajM>>(
      future: list_manhaj,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                DetailManhajM current = snapshot.data[index];
                return Column(
                  children: [
                    SizedBox(width: 20.0),
                    Column(
                      children: <Widget>[
                        Text(
                            'Buku: ' +
                                current.judulbuku.toString() +
                                '(Ringkas)',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.indigo[900],
                              fontWeight: FontWeight.bold,
                            )),
                        Text('oleh: ' + current.pengarangbuku.toString()),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            current.ringkasanbuku.toString(),
                            textAlign: TextAlign.justify,
                          ),
                        )
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
        iconTheme: IconThemeData(color: Colors.indigo[900]),
        title: judul_manhaj,
        backgroundColor: Colors.indigo[200],
      ),
      body: Center(
        child: ListView(
          children: [
            Column(children: <Widget>[
              Divider(
                color: Colors.grey[400],
              ),
              manhaj
            ])
          ],
        ),
      ),
    );
  }
}
