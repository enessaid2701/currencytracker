import 'package:flutter/material.dart';
import 'package:flutter_currencies_tracker/currency.dart';
import 'package:toast/toast.dart';

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
  TextEditingController resultController = new TextEditingController();
  bool dataIsLoading = false;
  var value;

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

  showToast(String message) {
    Toast.show('$message', context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('conversion'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: TextField(
                style: TextStyle(color: Colors.white70),
                controller: amountController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  labelText: 'amount',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: TextField(
                style: TextStyle(color: Colors.white70),
                controller: fromController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  labelText: 'from',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: TextField(
                style: TextStyle(color: Colors.white70),
                controller: toController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0)),
                    border: OutlineInputBorder(),
                    labelText: 'To',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                shape: StadiumBorder(),
                elevation: 12,
                child: Container(
                  width: 100,
                  height: 45,
                  child: Center(
                    child: Text(
                      "conversion",
                      style: TextStyle(color: Colors.white,),
                    ),
                  ),
                ),
                color: Color(0xdd0d7377),
                onPressed: () async {
                  if (amountController.text == "" ||
                      fromController.text == "" ||
                      toController.text == "") {
                    ///alert göster
                    showToast("inputs is empty");
                  } else {
                    value = await getConversion(
                      from: fromController.text,
                      to: toController.text,
                      amount: amountController.text,
                    );
                    resultController.text = value.toString();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
                readOnly: true,
                controller: resultController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0)),
                  border: UnderlineInputBorder(),
                  hintText: 'Rate:',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
