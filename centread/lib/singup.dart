import 'package:flutter/material.dart';
import 'package:Centread/signin.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'web_service_url.dart';
import 'package:http/http.dart' as http;

String ip = WebService.ip.toString();

class SignupPage extends StatefulWidget {
  static String tag = 'signup-page';
  @override
  _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool processing = false;
  TextEditingController namectrl, emailctrl, passctrl, confpassctrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
    confpassctrl = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      controller: emailctrl,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
      ),
    );
    final icon = Image.asset(
      'assets/register-final.png',
      width: 200,
      height: 200,
    );

    final name = TextFormField(
      controller: namectrl,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: 'Nama',
      ),
    );
    final password = TextFormField(
      controller: passctrl,
      obscureText: true,
      decoration: InputDecoration(hintText: 'Password'),
    );
    final password_confirm = TextFormField(
      controller: confpassctrl,
      obscureText: true,
      decoration: InputDecoration(hintText: 'Password Confirmation'),
    );
    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.green.shade100,
        elevation: 5.0,
        child: MaterialButton(
          onPressed: () {
            //Navigator.of(context).pushNamed(SigninPage.tag);
            registerUser();
          },
          color: Colors.green,
          child: processing == false
              ? Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                )
              : CircularProgressIndicator(backgroundColor: Colors.green),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Register', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            icon,
            name,
            email,
            password,
            password_confirm,
            registerButton,
          ],
        ),
      ),
    );
  }

  void registerUser() async {
    setState(() {
      processing = true;
    });
    var url = "http://" + ip + "/register";
    var data = {
      "email": emailctrl.text,
      "name": namectrl.text,
      "pass": passctrl.text,
      "conf_pass": confpassctrl.text
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "terdaftar") {
      Fluttertoast.showToast(
          msg: "Akun terdaftar, silahkan login",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "password tidak sama") {
        Fluttertoast.showToast(
            msg: "Password tidak sama", toastLength: Toast.LENGTH_SHORT);
      }
      if (jsonDecode(res.body) == "dibuat") {
        Fluttertoast.showToast(
            msg: "Akun berhasil dibuat", toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(
            msg: "Isi form dengan benar!", toastLength: Toast.LENGTH_SHORT);
      }
    }
    setState(() {
      processing = false;
    });
  }
}
