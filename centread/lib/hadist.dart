import 'package:flutter/material.dart';
import 'web_service_url.dart';
import 'package:http/http.dart' as http;
import 'package:Centread/models/buku-hadist.dart';
import 'dart:async';
import 'dart:convert';
import 'detail-hadist.dart';

String ip = WebService.ip;
Future<List<BukuHadistM>> fetchHadist() async {
  final response = await http.get('http://' + ip + '/lihat-hadist');
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<BukuHadistM>((json) => BukuHadistM.fromJson(json)).toList();
}

class Hadist extends StatefulWidget {
  static String tag = 'hadist';
  @override
  _HadistState createState() => _HadistState();
}

class _HadistState extends State<Hadist> {
  Future<List<BukuHadistM>> list_hadist;
  @override
  void initState() {
    super.initState();
    list_hadist = fetchHadist();
  }

  Widget build(BuildContext context) {
    final searchbar = Container(
        width: 10,
        height: 32,
        child: TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'cari hadist',
              prefixIcon: Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              contentPadding: EdgeInsets.all(8.0),
            )));

    final hadist = FutureBuilder<List<BukuHadistM>>(
      future: list_hadist,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              BukuHadistM current = snapshot.data[index];
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
                                  builder: (context) => DetailHadist(
                                    idBukuHadist:
                                        current.idbukuhadist.toString(),
                                  ),
                                ));
                          },
                          child: Column(
                            children: [
                              Image.network(
                                  'http://' +
                                      ip +
                                      '/gambar/cover_hadist/' +
                                      current.cover.toString(),
                                  width: 250,
                                  height: 400),
                              Text(
                                current.judulbukuhadist.toString() +
                                    ' - ' +
                                    current.riwayatoleh.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.amber[900]),
                              ),
                              Divider(
                                color: Colors.grey[400],
                              ),
                              Text(
                                'Tahun: ' + current.tahunriwayat.toString(),
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
        iconTheme: IconThemeData(color: Colors.amber[900]),
        title: Text(
          'Hadist',
          style: TextStyle(color: Colors.amber[900]),
        ),
        backgroundColor: Colors.amberAccent[100],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40),
            searchbar,
            SizedBox(height: 40),
            Column(
              children: <Widget>[hadist],
            )
          ],
        ),
      ),
    );
  }
}
