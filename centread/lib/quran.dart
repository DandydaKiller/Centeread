import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'web_service_url.dart';
import 'package:Centread/models/quran.dart';
import 'dart:async';
import 'dart:convert';
import 'detail-quran.dart';

String ip = WebService.ip;
Future<List<QuranM>> fetchSurah() async {
  final response = await http.get('http://' + ip + '/lihat-quran');
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<QuranM>((json) => QuranM.fromJson(json)).toList();
}

class Quran extends StatefulWidget {
  static String tag = 'quran';
  @override
  _QuranState createState() => _QuranState();
}

class _QuranState extends State<Quran> {
  Future<List<QuranM>> list_surah;
  @override
  void initState() {
    super.initState();
    list_surah = fetchSurah();
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
    final quran_surah = FutureBuilder<List<QuranM>>(
      future: list_surah,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              QuranM current = snapshot.data[index];
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
                                style: TextStyle(
                                    color: Colors.green, fontSize: 17),
                              ),
                              onTap: () {
                                /* print("Congratulation! ID Surah " +
                                    current.idsurah.toString() +
                                    " Had been pressed");*/
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailQuran(
                                        idSurah: current.idsurah.toString(),
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

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green[900]),
        title: Text(
          'Quran',
          style: TextStyle(color: Colors.green[900]),
        ),
        backgroundColor: Colors.green[200],
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
                quran_surah
              ],
            )
          ],
        ),
      ),
    );
  }
}
