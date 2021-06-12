import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'web_service_url.dart';
import 'package:http/http.dart' as http;
import 'auth.dart';

String ip = WebService.ip.toString();

//import 'package:Centread/signin.dart';
class ResetPassword extends StatefulWidget {
  static String tag = 'reset';

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool processing = false;
  TextEditingController emailctrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailctrl = new TextEditingController();
  }

  Widget build(BuildContext context) {
    final image = Image.asset('assets/reset-final.png');

    final email = TextFormField(
      controller: emailctrl,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Masukkan Email Akun anda',
      ),
    );

    final nextButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.green.shade100,
        elevation: 5.0,
        child: MaterialButton(
          onPressed: () {
            //Navigator.of(context).pushNamed(SigninPage.tag);
          },
          color: Colors.green,
          child: Text(
            'Next',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Reset Password', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            image,
            email,
            nextButton,
          ],
        ),
      ),
    );
  }

  void userSignIn() async {
    setState(() {
      processing = true;
    });
    var url = "http://" + ip + "/reset";
    var data = {
      "email": emailctrl.text,
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "berhasil") {
      Fluttertoast.showToast(
          msg: "Email token Berhasil dikirim", toastLength: Toast.LENGTH_SHORT);
    }

    setState(() {
      processing = false;
    });
  }
}
