import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectCurrency = 'USD';
  String rate = '?';

  Future<void> getNewRate(String currency) async {
    selectCurrency = currency;
    rate = await CoinData().getExchangeRate(currency);
    setState(() {
      print(rate);
    });
  }

  Text trackerText() {
    return Text(
      '1 BTC = $rate $selectCurrency',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    );
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItens = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItens.add(newItem);
    }
    return DropdownButton<String>(
      value: selectCurrency,
      items: dropdownItens,
      onChanged: (value) {
        setState(() {
          getNewRate(value);
        });
        print(value);
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerList = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerList.add(newItem);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        getNewRate(currenciesList[selectedIndex]);
      },
      children: pickerList,
    );
  }

  @override
  void initState() {
    super.initState();
    getNewRate(selectCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: trackerText(),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
