import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io';
import 'package:translator/translator.dart';

class BoundingBox extends StatefulWidget {
  _BoundingBoxState createState() => _BoundingBoxState();
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  BoundingBox(this.results, this.previewH, this.previewW, this.screenH,
      this.screenW, this.model);
}

class _BoundingBoxState extends State<BoundingBox> {
  GoogleTranslator translator = new GoogleTranslator();
  FlutterTts flutterTts = FlutterTts();
  int i = 0;
  String output_translate;

  void translate(String input) {
    translator.translate(input, to: "id").then((output) {
      setState(() {
        output_translate = output.toString();
      });
    });
  }

  Future _speak(String word) async {
    //if (i % 2 == 0) {
    String temp;
    if (word != temp) {
      await flutterTts.setLanguage("id-ID");
      await flutterTts.speak(word);
      // await Future.delayed(Duration(seconds: 3));
    }
    temp = word;
    // sleep(Duration(seconds: 1));

    // i++;
    //}
    // await flutterTts.awaitSpeakCompletion(true);
  }

  FlatButton button = FlatButton(
    child: Text("Button"),
    onPressed: () => print('pressed'),
  );
  FlatButton speakButton;
  @override
  void initState() {
    super.initState();
    //_speak(widget.results.toString());
    //print("Result : " + widget.results.toString());
  }

  @override
  Widget build(BuildContext context) {
    //button.onPressed();
    //speakButton.onPressed();
    if (i == null || i == 0) {
      i = 0;
    }
    List<Widget> _renderBoxes() {
      return widget.results.map((re) {
        var _x = re["rect"]["x"];
        var _w = re["rect"]["w"];
        var _y = re["rect"]["y"];
        var _h = re["rect"]["h"];
        var scaleW, scaleH, x, y, w, h;

        if (widget.screenH / widget.screenW >
            widget.previewH / widget.previewW) {
          scaleW = widget.screenH / widget.previewH * widget.previewW;
          scaleH = widget.screenH;
          var difW = (scaleW - widget.screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          w = _w * scaleW;
          if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
          y = _y * scaleH;
          h = _h * scaleH;
        } else {
          scaleH = widget.screenW / widget.previewW * widget.previewH;
          scaleW = widget.screenW;
          var difH = (scaleH - widget.screenH) / scaleH;
          x = _x * scaleW;
          w = _w * scaleW;
          y = (_y - difH / 2) * scaleH;
          h = _h * scaleH;
          if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
        }

        speakButton = FlatButton(
          onPressed: () {
            if ((w * h / widget.screenW * widget.screenH) * 100 >= 90) {
              translate("${re["detectedClass"]}");
              _speak("ada " + output_translate + " didepan");
            } else if ((w * h / widget.screenW * widget.screenH) * 100 < 90) {
              _speak("Didepan Kosong");
            }
            /* _speak(
                        "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%");*/
          },
          child: Text("speak"),
        );
        if (i == 7) {
          speakButton.onPressed();
          i = 0;
        } else {
          print("I nya :" + i.toString());
          i++;
        }
        // speakButton.onPressed();

        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: Container(
              padding: EdgeInsets.only(top: 5.0, left: 5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(37, 213, 253, 1.0),
                  width: 3.0,
                ),
              ),
              child: Column(children: [
                Text(
                  "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                    color: Color.fromRGBO(37, 213, 253, 1.0),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ])),
        );
      }).toList();
    }

    return Stack(
      children: _renderBoxes(),
    );
  }
}
