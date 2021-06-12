import 'package:flutter/material.dart';
import 'web_service_url.dart';
import 'package:http/http.dart' as http;
import 'package:Centread/models/manhaj.dart';
import 'dart:async';
import 'dart:convert';
import 'detail-manhaj.dart';

String ip = WebService.ip;
Future<List<ManhajM>> fetchManhaj() async {
  final response = await http.get('http://' + ip + '/lihat-manhaj');
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<ManhajM>((json) => ManhajM.fromJson(json)).toList();
}

class Manhaj extends StatefulWidget {
  static String tag = 'manhaj';
  @override
  _ManhajState createState() => _ManhajState();
}

class _ManhajState extends State<Manhaj> {
  Future<List<ManhajM>> list_manhaj;

  @override
  void initState() {
    super.initState();
    list_manhaj = fetchManhaj();
  }

  Widget build(BuildContext context) {
    final searchbar = Container(
        width: 10,
        height: 32,
        child: TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'cari manhaj',
              prefixIcon: Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              contentPadding: EdgeInsets.all(8.0),
            )));

    final manhaj = FutureBuilder<List<ManhajM>>(
      future: list_manhaj,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              ManhajM current = snapshot.data[index];
              return Container(
                  height: 200,
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
                                  builder: (context) => DetailManhaj(
                                    idManhaj: current.idmanhaj.toString(),
                                  ),
                                ));
                          },
                          child: Column(
                            children: [
                              Text(
                                'Manhaj ' + current.namamanhaj.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.indigo[900]),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                current.deskripsimanhaj.toString(),
                                textAlign: TextAlign.justify,
                              )
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
          iconTheme: IconThemeData(color: Colors.indigo[900]),
          title: Text(
            'Manhaj',
            style: TextStyle(color: Colors.indigo[900]),
          ),
          backgroundColor: Colors.indigo[100]),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            searchbar,
            SizedBox(
              height: 40,
            ),
            Column(
              children: <Widget>[manhaj],
            )
          ],
        ),
      ),
    );
  }
}
