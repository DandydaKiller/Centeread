import 'package:flutter/material.dart';
import 'web_service_url.dart';
import 'package:http/http.dart' as http;
import 'package:Centread/models/tafsir.dart';
import 'dart:async';
import 'dart:convert';
import 'detail-tafsir.dart';

String ip = WebService.ip;
Future<List<TafsirM>> fetchTafsir() async {
  final response = await http.get('http://' + ip + '/lihat-penafsir');
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<TafsirM>((json) => TafsirM.fromJson(json)).toList();
}

class Tafsir extends StatefulWidget {
  static String tag = 'tafsir';
  @override
  _TafsirState createState() => _TafsirState();
}

class _TafsirState extends State<Tafsir> {
  Future<List<TafsirM>> list_tafsir;

  @override
  void initState() {
    super.initState();
    list_tafsir = fetchTafsir();
  }

  Widget build(BuildContext context) {
    final searchbar = Container(
        width: 10,
        height: 32,
        child: TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'cari Tafsir',
              prefixIcon: Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              contentPadding: EdgeInsets.all(8.0),
            )));

    final tafsir = FutureBuilder<List<TafsirM>>(
      future: list_tafsir,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              TafsirM current = snapshot.data[index];
              return Container(
                  height: 480,
                  width: 100,
                  margin: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 3,
                        blurRadius: 2,
                        //offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                      borderRadius: BorderRadius.circular(5.0),
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailTafsir(
                                    idPenafsir: current.idpenafsir.toString(),
                                  ),
                                ));
                          },
                          child: Column(
                            children: [
                              Image.network(
                                  'http://' +
                                      ip +
                                      '/gambar/cover_tafsir/' +
                                      current.cover.toString(),
                                  width: 250,
                                  height: 400),
                              Text(
                                current.namapenafsir,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.red[900]),
                              ),
                              Divider(
                                color: Colors.grey[400],
                              ),
                              Text(
                                'Tahun: ' + current.tahunditafsirkan.toString(),
                                style: TextStyle(fontSize: 12),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ))));
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
        iconTheme: IconThemeData(color: Colors.red[900]),
        title: Text(
          'Tafsir',
          style: TextStyle(color: Colors.red[900]),
        ),
        backgroundColor: Colors.red[200],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            searchbar,
            SizedBox(height: 40),
            Column(
              children: <Widget>[tafsir],
            )
          ],
        ),
      ),
    );
  }
}
