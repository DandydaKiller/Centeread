//import 'dart:ui';

import 'package:Centread/hadist.dart';
import 'package:Centread/manhaj.dart';
import 'package:Centread/quran.dart';
import 'package:Centread/tafsir.dart';
import 'package:flutter/material.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'auth.dart';
import 'package:Centread/models/artikel.dart';
import 'web_service_url.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

String ip = WebService.ip;
Future<List<ArtikelM>> fetchHadist() async {
  final response = await http.get('http://' + ip + '/lihat-artikel');
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<ArtikelM>((json) => ArtikelM.fromJson(json)).toList();
}

class DashboardPage extends StatefulWidget {
  static String tag = 'dashboard';

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<List<ArtikelM>> list_hadist;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    list_hadist = fetchHadist();
  }

  Widget build(BuildContext context) {
    int _current = 0;
    final List<String> list_gambar = [
      'assets/slider1.jpg',
      'assets/slider2.jpg',
      'assets/slider3.jpg',
      'assets/slider4.jpg',
    ];
    final image_slider = CarouselSlider(
        options: CarouselOptions(
          height: 300.0,
          onPageChanged: (index, reason) {
            _current = index;
          },
        ),
        items: list_gambar
            .map((i) => Container(
                  child: Center(
                    child: Image.asset(
                      i,
                      fit: BoxFit.fill,
                      width: 1500,
                      height: 1500,
                    ),
                  ),
                ))
            .toList());

    final list_menu = Container(
        height: 150,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 7),
            ),
          ],
        ),
        child: Card(
          //elevation: 20.0,
          color: Colors.white,
          margin: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: Material(
                      color: Colors.blue,
                      child: InkWell(
                        splashColor: Colors.red,
                        child: SizedBox(
                            width: 63,
                            height: 63,
                            child: Image.asset('assets/icon/quran.png')),
                        onTap: () {
                          Navigator.of(context).pushNamed(Quran.tag);
                        },
                      ),
                    ),
                  ),
                  Text(
                    'Al-Quran',
                    style: TextStyle(fontStyle: FontStyle.normal),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: Material(
                      color: Colors.blue,
                      child: InkWell(
                        splashColor: Colors.red,
                        child: SizedBox(
                            width: 63,
                            height: 63,
                            child: Image.asset('assets/icon/hadist.png')),
                        onTap: () {
                          Navigator.of(context).pushNamed(Hadist.tag);
                        },
                      ),
                    ),
                  ),
                  Text(
                    'Hadist',
                    style: TextStyle(fontStyle: FontStyle.normal),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: Material(
                      color: Colors.blue,
                      child: InkWell(
                        splashColor: Colors.red,
                        child: SizedBox(
                            width: 63,
                            height: 63,
                            child: Image.asset('assets/icon/tafsir.png')),
                        onTap: () {
                          Navigator.of(context).pushNamed(Tafsir.tag);
                        },
                      ),
                    ),
                  ),
                  Text(
                    'Tafsir',
                    style: TextStyle(fontStyle: FontStyle.normal),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: Material(
                      color: Colors.blue,
                      child: InkWell(
                        splashColor: Colors.red,
                        child: SizedBox(
                            width: 63,
                            height: 63,
                            child: Image.asset('assets/icon/manhaj.png')),
                        onTap: () {
                          Navigator.of(context).pushNamed(Manhaj.tag);
                        },
                      ),
                    ),
                  ),
                  Text(
                    'Manhaj',
                    style: TextStyle(fontStyle: FontStyle.normal),
                  )
                ],
              ),
            ],
          ),
        ));
    final artikel_islami = FutureBuilder<List<ArtikelM>>(
      future: list_hadist,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              ArtikelM current = snapshot.data[index];
              return Container(
                  height: 270,
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
                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailHadist(
                                    idBukuHadist:
                                        current.idbukuhadist.toString(),
                                  ),
                                ));*/
                          },
                          child: Column(
                            children: [
                              Image.network(
                                  'http://' +
                                      ip +
                                      '/gambar/artikel/' +
                                      current.gambarartikel.toString(),
                                  width: 250,
                                  height: 200),
                              Text(
                                current.judulartikel.toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              Divider(
                                color: Colors.grey[400],
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
    final artikel_islami_sebelumnya = Container(
      height: 330,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Card(
        //elevation: 20.0,
        color: Colors.white,
        margin: EdgeInsets.all(5.0),
        child: ListView(
          //adding:
          children: <Widget>[
            Image.asset(
              'assets/post/contoh_post.jpg',
              width: 600,
              height: 240,
            ),
            Text(
                'Cerita Sebenarnya dari Malaikat Harut dan Marut, Malaikat yang di Hukum Allah karna Mengajarkan Sihir kepada Masyarakat Babylonia',
                style: TextStyle(fontSize: 15.0, color: Colors.black)),
            Divider(
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      // body: body,
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text('Akun'),
          ),
          body: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Text(
                Auth.name,
                style: TextStyle(fontSize: 20),
              ),
              Text(Auth.email),
              Row(
                children: [
                  Icon(Icons.attach_money_sharp),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/catalog');
                      },
                      child: Text('Zakat Saya'))
                ],
              ),
              Row(
                children: [
                  Icon(Icons.logout),
                  FlatButton(
                      onPressed: () {
                        Auth.setter('guest', '');

                        Navigator.of(context).pushNamed('/sigin-page');
                      },
                      child: Text('Logout'))
                ],
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text('Dashboard', style: TextStyle(color: Colors.white)),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logo-2.png',
              fit: BoxFit.contain,
              height: 1000,
            ),
          ],
        ),
        /*Text(
          'Centread',
          style: TextStyle(color: Colors.white),
        ),*/
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            image_slider,
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(list_gambar, (index, url) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 0.0),
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Colors.lightGreenAccent
                        : Colors.grey,
                  ),
                );
              }),
            ),
            list_menu,
            artikel_islami,
          ],
        ),
      ),
    );
  }
}
