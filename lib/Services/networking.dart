// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  Networking({required this.apiURL});
  final String apiURL;

  Future getData() async {
    try {
      http.Response dataResponse = await http.get(Uri.parse(apiURL));
      var statusCode = dataResponse.statusCode;
      if (statusCode == 200) {
        String data = dataResponse.body;
        return jsonDecode(data);
      } else {
        print('ERROR: $statusCode');
      }
    } catch (e) {
      print(e);
    }
  }
}
