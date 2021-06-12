import 'package:Centread/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signin.dart';
import 'dashboard.dart';
import 'singup.dart';
import 'quran.dart';
import 'hadist.dart';
import 'manhaj.dart';
import 'tafsir.dart';
import 'zakat.dart';
import 'zakatCheckout.dart';
import 'detail-quran.dart';
import 'detail-hadist.dart';
import 'models/zakatController.dart';
import 'models/zakatCheckoutController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/sigin-page': (context) => SigninPage(),
    DashboardPage.tag: (context) => DashboardPage(),
    SignupPage.tag: (context) => SignupPage(),
    ResetPassword.tag: (context) => ResetPassword(),
    Quran.tag: (context) => Quran(),
    Hadist.tag: (context) => Hadist(),
    Manhaj.tag: (context) => Manhaj(),
    Tafsir.tag: (context) => Tafsir(),
    '/catalog': (context) => Zakat(),
    '/cart': (context) => ZakatCheckout(),
    DetailQuran.tag: (context) => DetailQuran(),
    DetailHadist.tag: (context) => DetailHadist(),
  };
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // In this sample app, CatalogModel never changes, so a simple Provider
          // is sufficient.
          Provider(create: (context) => CatalogModel()),
          // CartModel is implemented as a ChangeNotifier, which calls for the use
          // of ChangeNotifierProvider. Moreover, CartModel depends
          // on CatalogModel, so a ProxyProvider is needed.
          ChangeNotifierProxyProvider<CatalogModel, CartModel>(
            create: (context) => CartModel(),
            update: (context, catalog, cart) {
              cart.catalog = catalog;
              return cart;
            },
          ),
        ],
        child: MaterialApp(
          title: 'Provider Demo',
          // theme: appTheme,
          initialRoute: '/sigin-page',
          routes: routes,
        ));
  }
}
