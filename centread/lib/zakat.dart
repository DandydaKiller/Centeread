import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Centread/models/zakatCheckoutController.dart';
import 'package:Centread/models/zakatController.dart';

class Zakat extends StatelessWidget {
  static String tag = '/zakat';
  @override
  Widget build(BuildContext context) {
    int total_tampil = 0;
    var cart = context.watch<CartModel>();

    final searchbar = Container(
        width: 10,
        height: 32,
        child: TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'cari jenis zakat',
              prefixIcon: Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              contentPadding: EdgeInsets.all(8.0),
            )));

    final list_zakat = CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => _MyListItem(index)),
        ),
      ],
    );

    final checkout = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        // borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.deepOrange[800],
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 50.0,
          height: 42.0,
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
          color: Colors.deepOrange[800],
          child: Text('Check out', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Zakat Saya',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[900],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[Text('\Rp${cart.totalPrice}'), checkout],
        ),
      ),
      body: list_zakat,
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
    var isInCart = context.select<CartModel, bool>(
      // Here, we are only interested whether [item] is inside the cart.
      (cart) => cart.items.contains(item),
    );

    return FlatButton(
      onPressed: isInCart
          ? null
          : () {
              // If the item is not in cart, we let the user add it.
              // We are using context.read() here because the callback
              // is executed whenever the user taps the button. In other
              // words, it is executed outside the build method.
              var cart = context.read<CartModel>();
              cart.add(item);
            },
      splashColor: Theme.of(context).primaryColor,
      child:
          isInCart ? Icon(Icons.check, semanticLabel: 'ADDED') : Text('Pilih'),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, Item>(
      // Here, we are only interested in the item at [index]. We don't care
      // about any other change.
      (catalog) => catalog.getByPosition(index),
    );
    var textTheme = Theme.of(context).textTheme.headline6;

    /*return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );*/
    return Container(
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
          color: Colors.white,
          margin: EdgeInsets.all(5.0),
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    item.name,
                    style: textTheme,
                  ),
                  Text("Jumlah orang yang akan di fitrahkan"),
                  Row(
                    children: [Text("Orang")],
                  ),
                ],
              ),
              _AddButton(item: item)
            ],
          ),
        ));
  }
}
