import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_key.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<String> getExchangeRate(
      String cryptoCurrency, String selectedCurrency) async {
    var apiUrl = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$cryptoCurrency/$selectedCurrency?apikey=$apiKey');
    http.Response response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      var jsonReceived = jsonDecode(response.body);
      double rateReceived = jsonReceived['src_side_base'][0]['rate'];
      return (rateReceived.toStringAsFixed(3));
    } else {
      return ('Error code = ${response.statusCode}');
    }
  }
}
