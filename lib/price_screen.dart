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
  List<String> rates = [];

  Future<void> getNewRates(String currency) async {
    selectCurrency = currency;
    for (int i = 0; i < cryptoList.length; i++) {
      rates.add('?');
    }
    for (int i = 0; i < cryptoList.length; i++) {
      rates[i] = await CoinData().getExchangeRate(cryptoList[i], currency);
    }

    setState(() {
      print(rates);
    });
  }

  List<Widget> trackerDisplayBuilder() {
    List<Widget> trackerList = [];
    for (int i = 0; i < cryptoList.length; i++) {
      trackerList.add(
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
              child: trackerText(cryptoList[i], rates[i]),
            ),
          ),
        ),
      );
    }
    return (trackerList);
  }

  Text trackerText(String cryptoCurrency, String rate) {
    return Text(
      '1 $cryptoCurrency = $rate $selectCurrency',
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
          getNewRates(value);
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
        getNewRates(currenciesList[selectedIndex]);
      },
      children: pickerList,
    );
  }

  @override
  void initState() {
    super.initState();
    getNewRates(selectCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: trackerDisplayBuilder(),
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
