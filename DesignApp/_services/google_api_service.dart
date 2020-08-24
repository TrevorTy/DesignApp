import 'dart:convert';
import 'dart:typed_data';
import 'package:design_by_me/models/font_data_model.dart';
import 'package:http/http.dart' as http;

class GoogleApiConnection {
  final String googleApiKey = 'YOURKEY';

  Future<List<FontData>> getFonts() async {
    http.Response response = await http.get(
        'https://www.googleapis.com/webfonts/v1/webfonts?key=$googleApiKey');
    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      var list = List<FontData>();

      for (var item in decodeData['items']) {
        list.add(FontData.fromJson(item));
        print(item['']);
        print(FontData);
      }
      return list;
    } else {
      return null;
      //print('malfunctioning ');
    }
  }

Future<ByteData> fetchFont() async {
  final response = await http.get(
     
     'https://www.googleapis.com/webfonts/v1/webfonts?key=$googleApiKey');

  if (response.statusCode == 200) {
    return ByteData.view(response.bodyBytes.buffer);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load font');
  }
}

  //TODO Check if the user has internet
  Future<List<FontData>> loadAllFonts() async {
    http.Response response = await http.get(
        'https://www.googleapis.com/webfonts/v1/webfonts?key=$googleApiKey');
    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      var list = List<FontData>();

      for (var item in decodeData['items']) {
        list.add(FontData.fromJson(item));
        // print(item['']);
      }
      return list;
    } else {
      return null;
      //print('malfunctioning ');
    }
  }

  //catch errors
}
