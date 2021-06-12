import 'package:avatar_glow/avatar_glow.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'BoundingBox.dart';
import 'Camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
//import 'package:lamp/lamp.dart';
//import 'package:flutter_lantern/flutter_lantern.dart';
import 'package:torch_compat/torch_compat.dart';
import 'package:wakelock/wakelock.dart';

const String ssd = "SSD MobileNet";

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomeScreen(this.cameras);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  stt.SpeechToText _speechToText = stt.SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  bool _flashon = false;

  Future _speak(String kata) async {
    await flutterTts.setLanguage("id-ID");
    await flutterTts.speak(kata);
    if (kata == "explain" || kata == "jelaskan") {
      await flutterTts.awaitSpeakCompletion(true);
    }
  }

  bool _isListening = false;
  String _text_command = '';
  //int i_listen = 0;

  @override
  void initState() {
    super.initState();
    // _speechToText = stt.SpeechToText();
    Wakelock.enable();
    _speak(
        "Selamat Datang Di Aplikasi Si Saight Silahkan Tekan Layar mana saja hingga bunyi biiip dan katakan perintah anda, katakan mulai atau start untuk memulai deteksi aplikasi, dan berhenti atau stop untuk menghentikan aplikasi sedangkan untuk menyalakan dan mematikan flash tekan layar dimana saja secara lama");
  }

  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";
  FlatButton selamat_datang;
  loadModel() async {
    String result;

    switch (_model) {
      case ssd:
        result = await Tflite.loadModel(
            labels: "assets/ssd_mobilenet.txt",
            model: "assets/ssd_mobilenet.tflite");
    }
    print(result);
  }

  onSelectModel(model) {
    setState(() {
      _model = model;
    });

    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  FloatingActionButton stt_button;
  // FlatButton stt_button2;

  @override
  Widget build(BuildContext context) {
    /*  if (i_listen == null || i_listen == 0) {
      i_listen = 0;
    }*/
    stt_button = FloatingActionButton(
      onPressed: () {
        // onSelectModel(ssd);
        _listen();
      },
      child: Icon(Icons.mic),
    );

    /*if (i_listen == 6) {
      stt_button2.onPressed();
      i_listen = 0;
    } else {
      print("I nya :" + i_listen.toString());
      i_listen++;
    }*/
    /*Future _speak(String kata, String word) async {
      await flutterTts.setLanguage("id-ID");
      await flutterTts.speak(kata);
      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.setLanguage("en-GB");
      await flutterTts.speak(word);
      await flutterTts.awaitSpeakCompletion(true);
    }

    selamat_datang = FlatButton(
        onPressed: () {
          _speak("Selamat Datang di Aplikasi", "CSight");
        },
        child: null);
    selamat_datang.onPressed();*/
    Image appLogo = new Image(
        image: new ExactAssetImage("assets/logo-panjang.png"),
        height: 150.0,
        width: 150.0,
        alignment: FractionalOffset.center);
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.7),
        elevation: 0.0,
        title: appLogo,
      ),
      body: _model == ""
          ? Stack(children: [
              Container(
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      'assets/guide.jpeg',
                      height: 350,
                      width: 100,
                    ),
                    Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text(
                            'Katakan Explain/Jelaskan untuk mengulangi petunjuk diatas, dan nyalakan internet sebelum memulai deteksi',
                            textAlign: TextAlign.justify)),
                    SizedBox(
                      height: 90,
                    ),
                    Container(
                        width: 320,
                        // height: 90,
                        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                        color: Colors.grey[200],
                        child: TextFormField(
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            //cursorHeight: 20,
                            decoration: InputDecoration(
                              hintText: 'Command terakhir : ' + _text_command,
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              prefixIcon:
                                  Icon(Icons.mic, color: Colors.grey[400]),
                              // fillColor: Colors.grey[450],
                              contentPadding: EdgeInsets.all(15.0),
                              border: InputBorder.none,
                            )))
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright @ 2021 Dandy,Caca dan Arif',
                    style: TextStyle(color: Colors.grey[400]),
                    textAlign: TextAlign.center,
                  )),
              Container(
                color: Colors.transparent,
                width: screen.width,
                height: screen.height,
                child: Material(
                  color: Colors.transparent,
                  child: MaterialButton(
                    onPressed: () {
                      // onSelectModel(ssd);
                      _listen();
                    },
                    onLongPress: () {
                      if (_flashon == false) {
                        _text_command = "Flash ON";
                        _speak("Flash Menyala");
                        TorchCompat.turnOn();
                        _flashon = true;
                      } else {
                        _text_command = "Flash OFF";
                        _speak("Flash MAti");
                        TorchCompat.turnOff();
                        _flashon = false;
                      }
                    },
                  ),
                ),
              )
            ])
          : Stack(
              children: [
                Camera(widget.cameras, _model, setRecognitions),
                BoundingBox(
                    _recognitions == null ? [] : _recognitions,
                    math.max(_imageHeight, _imageWidth),
                    math.min(_imageHeight, _imageWidth),
                    screen.width,
                    screen.height,
                    _model),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      //alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white.withOpacity(0.5),
                      height: 100,
                      width: 350,
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: 320,
                      // height: 90,
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      color: Colors.grey[200].withOpacity(0.7),
                      child: TextFormField(
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          //cursorHeight: 20,
                          decoration: InputDecoration(
                            hintText: 'Command terakhir : ' + _text_command,
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon:
                                Icon(Icons.mic, color: Colors.grey[400]),
                            // fillColor: Colors.grey[450],
                            contentPadding: EdgeInsets.all(15.0),
                            border: InputBorder.none,
                          ))),
                ),
                Container(
                    color: Colors.transparent,
                    width: screen.width,
                    height: screen.height,
                    child: Material(
                        color: Colors.transparent,
                        child: MaterialButton(onPressed: () {
                          // onSelectModel(ssd);
                          _listen();
                        }, onLongPress: () {
                          if (_flashon == false) {
                            _text_command = "Flash ON";
                            _speak("Flash Menyala");
                            //TorchCompat.turnOn();
                            _flashon = true;
                          } else {
                            _text_command = "Flash OFF";
                            _speak("Flash Mati");
                            //TorchCompat.turnOff();
                            _flashon = false;
                          }
                        })))
              ],
            ),
      floatingActionButton: AvatarGlow(
        child: stt_button,
        endRadius: 75.0,
        animate: true,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        glowColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _listen() async {
    bool available = await _speechToText.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speechToText.listen(
        listenFor: Duration(seconds: 3),
        onResult: (val) => setState(() {
          if (val.recognizedWords == "mulai" ||
              val.recognizedWords == "start") {
            _text_command = val.recognizedWords;
            _speak("Deteksi Dimulai");
            onSelectModel(ssd);
          } else if (val.recognizedWords == "jelaskan" ||
              val.recognizedWords == "explain") {
            _text_command = val.recognizedWords;
            _speak(
                "Silahkan Tekan Layar mana saja hingga bunyi biiip dan katakan perintah anda, katakan mulai atau start untuk memulai deteksi aplikasi, dan berhenti atau stop untuk menghentikan aplikasi sedangkan untuk menyalakan dan mematikan flash tekan layar dimana saja secara lama");
          } else if (val.recognizedWords == "berhenti" ||
              val.recognizedWords == "stop") {
            _text_command = val.recognizedWords;
            onSelectModel("");
            _speak("Deteksi Berhenti");
          }
        }),
      );
    }
  }
}
