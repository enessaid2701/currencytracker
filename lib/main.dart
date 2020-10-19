import 'package:currencytracker/flags.dart';
import 'package:currencytracker/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currencies_tracker/flutter_currencies_tracker.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _updateDate;
  List _symbol;
  List _rates;
  bool _isLoading = false;
  Map currenciesMap;

  /// If you want to use the map, remove the comment line
  // Map _fullData;

  getData() async {
    currenciesMap = await Currency.getCurrencies();
    var responseLatest = await Currency.getLatest(from: 'USD');
    setState(() {
      _updateDate = responseLatest.date;
      _symbol = responseLatest.symbol;
      _rates = responseLatest.rates;
      _isLoading = true;

      /// If you want to use the map, remove the comment line
      // _fullData = responseLatest.symbolAndRates;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Center(
          child: Text(
            'Currency Tracker',
          ),
        ),
        /*title: Text(
          _isLoading == false
              ? 'Last Update:'
              : 'Base: USD Last Update: $_updateDate',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),*/
      ),
      body: Column(
        children: [
          /*Container(
            height: 10,
            color: Colors.black,
            child: Row(
              children: [
                Center(
                  child: _isLoading == true
                      ? ListView.builder(
                          itemCount: _rates.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.blueGrey[900],
                              child: ListTile(
                                leading: Image.asset(
                                  flags.values.elementAt(index),
                                ),

                                /// If you want to use the map
                                // _fullData.keys.elementAt(index) returns symbol
                                title: Text(
                                  '${currenciesMap[_symbol.elementAt(index)]}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                // _fullData.values.elementAt(index) returns rates
                                subtitle: Text(
                                  '${_rates.elementAt(index)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : CircularProgressIndicator(),
                ),
              ],
            ),
          ),*/
          Container(
            height: 580,
            color: Colors.black,
            child: Center(
              child: _isLoading == true
                  ? ListView.builder(
                      itemCount: _rates.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.blueGrey[900],
                          child: ListTile(
                            leading: Image.asset(
                              flags.values.elementAt(index),
                            ),

                            /// If you want to use the map
                            // _fullData.keys.elementAt(index) returns symbol
                            title: Text(
                              '${currenciesMap[_symbol.elementAt(index)]}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            // _fullData.values.elementAt(index) returns rates
                            subtitle: Text(
                              '${_rates.elementAt(index)}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : CircularProgressIndicator(),
            ),
          ),
          Card(
            color: Colors.blueGrey[500],
            child: ListTile(
              title: Text('conversion'),
              leading: Icon(Icons.monetization_on),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

///// ÜST TARAFA LİSTE EKLE VE KARŞILIKLARINI SEÇ
