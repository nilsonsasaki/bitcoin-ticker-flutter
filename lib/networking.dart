import 'dart:convert';
import 'secret_constants.dart';
import 'package:http/http.dart' as http;

class Networking {
  Future<double> getExchangeRate(String selectedCurrency) async {
    var apiUrl = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=$apiKey');
    var response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      var jsonReceived = jsonDecode(response.body);
      double teste = jsonReceived['src_side_base'][0]['rate'];
      return (teste);
    }
  }
}
