import 'package:flutter/material.dart';
import 'package:Centread/dashboard.dart';
import 'package:Centread/singup.dart';
import 'package:Centread/reset_password.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'web_service_url.dart';
import 'package:http/http.dart' as http;
import 'auth.dart';

String ip = WebService.ip.toString();

class SigninPage extends StatefulWidget {
  static String tag = 'sigin-page';
  @override
  _SigninPageState createState() => new _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool processing = false;
  TextEditingController namectrl, emailctrl, passctrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      'assets/welcome-final.png',
      height: 200,
      width: 200,
    );
    /*Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo-2.png'),
      ),
    );*/

    final email = TextFormField(
      controller: emailctrl,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final password = TextFormField(
      controller: passctrl,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.green.shade100,
        elevation: 5.0,
        child: MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            onPressed: () {
              //Navigator.of(context).pushNamed(DashboardPage.tag);
              userSignIn();
            },
            color: Colors.green,
            child: processing == false
                ? Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  )
                : CircularProgressIndicator(backgroundColor: Colors.green)
            /* Text('Log In', style: TextStyle(color: Colors.white)),*/
            ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(ResetPassword.tag);
      },
    );

    final maybelater = FlatButton(
        child: Text(
          'Maybe Later',
          style: TextStyle(color: Colors.grey),
        ),
        onPressed: () {
          Auth.setter('guest', '');
          Navigator.of(context).pushNamed(DashboardPage.tag);
        });

    final register = FlatButton(
      child: Text(
        'Register',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(SignupPage.tag);
      },
    );

    final spinkit = SpinKitRing(
      color: Colors.blue,
    );

    final logo_login_google = FlatButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                elevation: 16,
                child: Container(
                  height: 400.0,
                  width: 360.0,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Image.asset(
                        'assets/logo-login-google.png',
                        cacheHeight: 90,
                        cacheWidth: 90,
                      ),
                      spinkit,
                      Center(
                        child: Text(
                          "Login With Google",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Image.asset('assets/login_google.png'));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 25.0),
            logo,
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            Row(
              children: [forgotLabel, register],
            ),
            //logo_login_google,
            maybelater
          ],
        ),
      ),
    );
  }

  void userSignIn() async {
    setState(() {
      processing = true;
    });
    var url = "http://" + ip + "/login";
    var data = {
      "email": emailctrl.text,
      "pass": passctrl.text,
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "belum terdaftar") {
      Fluttertoast.showToast(
          msg: "maaf Akun anda belum terdaftar!",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "password salah") {
        Fluttertoast.showToast(
            msg: "Password anda salah!", toastLength: Toast.LENGTH_SHORT);
      } else {
        var parsed = jsonDecode(res.body);
        //print('${parsed.runtimeType} : $parsed');
        var name = parsed['nama'];
        var email = parsed['email'];
        //print(name);
        //print(email);
        Auth.setter(name, email);
        //print(Auth.email);
        //print(Auth.name);
        Fluttertoast.showToast(
            msg: "Berhasil Login", toastLength: Toast.LENGTH_SHORT);
        Navigator.of(context).pushNamed(DashboardPage.tag);
      }
    }

    setState(() {
      processing = false;
    });
  }
}
