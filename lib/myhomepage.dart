import 'package:flutter/material.dart';
import 'package:flutter_currencies_tracker/currency.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController amountController = new TextEditingController();
  TextEditingController fromController = new TextEditingController();
  TextEditingController toController = new TextEditingController();
  bool dataIsLoading = false;

  getConversion({
    @required String from,
    @required String to,
    @required String amount,
  }) async {
    var _response =
        await Currency.getConversion(from: from, to: to, amount: amount);
    var _rate = _response.rate;
    setState(() => dataIsLoading = true);
    return _rate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('account transactions'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onTap: () async {
                  if (amountController.text == "") {
                    ///alert göster
                  }
                  var value = await getConversion(
                    amount: amountController.text,
                  );
                  if (dataIsLoading == true) {
                    print(value);
                  } else {
                    print("değer girilmedi!");
                  }
                },
                controller: amountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'amount',
                ),
              ),
            ),
            Padding(

              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onTap: () async {
                  if (amountController.text == "") {
                  }
                  var value = await getConversion(
                    from: fromController.text,
                  );
                  if (dataIsLoading == true) {
                    print(value);
                  } else {
                    print("değer girilmedi!");
                  }
                },
                controller: fromController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'From',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onTap: () async {
                  if (amountController.text == "") {
                    ///alert göster
                  }
                  var value = await getConversion(
                    to: toController.text,
                  );
                  if (dataIsLoading == true) {
                    print(value);
                  } else {
                    print("değer girilmedi!");
                  }
              },
                ///box dec
                ///padding ver
                ///butonu tasarla
                ///inputlara veri girilmemişse uyarı ver
                /// deidğini yap
                controller: toController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'To',
                ),
              ),
            ),
            RaisedButton(
              color: Colors.blue[300],
              onPressed: () async {
                if (amountController.text == "") {
                  ///alert göster
                }
                var value = await getConversion(
                  from: fromController.text,
                  to: toController.text,
                  amount: amountController.text,
                );
                if (dataIsLoading == true) {
                  print(value);
                } else {
                  print("değer daha gelmedi !");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
