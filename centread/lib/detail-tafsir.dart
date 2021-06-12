import 'package:Centread/hasil-tafsir.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'web_service_url.dart';
import 'package:Centread/models/detail-tafsir.dart';
import 'dart:async';
import 'dart:convert';
//import 'detail-quran.dart';

String ip = WebService.ip;

class DetailTafsir extends StatefulWidget {
  static String tag = 'detail-tafsir';
  @override
  _DetailTafsirState createState() => _DetailTafsirState();
  final String idPenafsir;
  DetailTafsir({Key key, @required this.idPenafsir}) : super(key: key);
}

Future<List<DetailTafsirM>> fetchDetailTafsir(String id) async {
  final response = await http.get('http://' + ip + '/lihat-tafsir/' + id);
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed
      .map<DetailTafsirM>((json) => DetailTafsirM.fromJson(json))
      .toList();
}

Future<List<DetailTafsirM>> fetchNamaTafsir(String id) async {
  final response = await http.get('http://' + ip + '/nama-penafsir/' + id);
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed
      .map<DetailTafsirM>((json) => DetailTafsirM.fromJson(json))
      .toList();
}

class _DetailTafsirState extends State<DetailTafsir> {
  Future<List<DetailTafsirM>> list_surah;
  Future<List<DetailTafsirM>> nama_tafsir;

  @override
  void initState() {
    super.initState();
    list_surah = fetchDetailTafsir(widget.idPenafsir.toString());
    nama_tafsir = fetchNamaTafsir(widget.idPenafsir.toString());
  }

  Widget build(BuildContext context) {
    final searchbar = Container(
        width: 10,
        height: 32,
        child: TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'cari surah',
              prefixIcon: Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              contentPadding: EdgeInsets.all(8.0),
            )));
    /* final tab_quran = DefaultTabController(
        length: 3,
        child: Container(
            child: TabBar(
          tabs: [
            Tab(
              child: Text('Surah'),
            ),
            Tab(child: Text('Favorite'))
          ],
        )));*/
    final list_tafsir = FutureBuilder<List<DetailTafsirM>>(
      future: list_surah,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              DetailTafsirM current = snapshot.data[index];
              return Column(
                children: <Widget>[
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        current.idsurah.toString(),
                      ),
                      SizedBox(width: 20.0),
                      Text(current.lafadz.toString(),
                          style: TextStyle(
                            fontSize: 19,
                          )),
                      SizedBox(width: 10.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              child: Text(
                                current.namasurah.toString(),
                                style:
                                    TextStyle(color: Colors.red, fontSize: 17),
                              ),
                              onTap: () {
                                /* print("Congratulation! ID Surah " +
                                    current.idsurah.toString() +
                                    " Had been pressed");*/
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HasilTafsir(
                                        idTafsir: current.idtafsir.toString(),
                                      ),
                                    ));
                              },
                            ),
                            Text(current.artisurah.toString() +
                                '(' +
                                current.jumlahayat.toString() +
                                ')')
                          ]),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[400],
                  ),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );

    final judul_tafsir = FutureBuilder<List<DetailTafsirM>>(
      future: nama_tafsir,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DetailTafsirM current = snapshot.data[index];
                /*if (current.namasurah.toString().isNotEmpty) {
                  nama_surah = current.namasurah.toString();
                }*/
                if (current.namapenafsir.toString().isNotEmpty) {
                  return Text(current.namapenafsir.toString(),
                      style: TextStyle(color: Colors.red[900]));
                }
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
        title: judul_tafsir,
        backgroundColor: Colors.red[200],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40),
            searchbar,
            SizedBox(height: 40),
            Column(
              children: <Widget>[
                Text('Surah'),
                Divider(
                  color: Colors.grey[400],
                ),
                list_tafsir
              ],
            )
          ],
        ),
      ),
    );
  }
}
