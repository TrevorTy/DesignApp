import 'dart:math';
import 'package:design_by_me/views/components/adjustable_fontsize.dart';
import 'package:design_by_me/models/font_data_model.dart';
import 'package:design_by_me/models/font_file_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';
import 'package:design_by_me/_services/google_api_service.dart';
import 'package:http/http.dart' as http;

//inladen aan de hand van een provider - met loadingcircularbar
//in homeview de controller aanroepen om de  fonts te laden

//AIzaSyAoPLTpvDwNyxX0OGq968bVI90pNaTlUIY
//https://www.googleapis.com/webfonts/v1/webfonts?key=YOUR-API-KEY
//https://www.googleapis.com/webfonts/v1/webfonts?key=AIzaSyAoPLTpvDwNyxX0OGq968bVI90pNaTlUIY

class FontController {
  final GoogleApiConnection api = GoogleApiConnection();
  final BehaviorSubject<UISettings> _fontSettingSubject =
      BehaviorSubject.seeded(
    UISettings(fontSize: 30.0, lineHeight: 1.0),
  ); //This is to update the stream
  List _fontData;
  //var _randomFontsData;
  FontData _currentFontData;
  FontData get currentFontData => _currentFontData;
  Stream<UISettings> get fontSettingStream => _fontSettingSubject.stream;
  UISettings get currentFontSetting => _fontSettingSubject.value;

  updateBackgroundColor(Color color) {
    UISettings fontSetting =
        currentFontSetting.copyWith(backgroundColor: color);
    _fontSettingSubject.add(fontSetting);
  }

  updateTextColor(Color color) {
    UISettings fontSetting = currentFontSetting.copyWith(textColor: color);
    _fontSettingSubject.add(fontSetting);
  }

  // updateTextgroundColor(Color color){
  //   UISettings fontSetting = currentFontSetting.copyWith(backgroundColor: color);
  //   _fontSettingSubject.add(fontSetting);
  // }

  updateFontSize(double fontSize) {
    UISettings fontSetting =
        currentFontSetting.copyWith(fontSize: fontSize.round().toDouble());

    //UISettings fontSetting = UISettings(
    // fontSize: fontSize.round().toDouble(),
    // lineHeight: currentFontSetting.lineHeight);
    _fontSettingSubject.add(fontSetting);
    // print(fontSize.round());
  }

  updateLineHeight(double lineHeight) {
    double calculation = (lineHeight * 0.10).round().toDouble();
    UISettings fontsettings =
        currentFontSetting.copyWith(lineHeight: calculation);

    _fontSettingSubject.add(fontsettings);
  }

  updateFontData(FontWeightData fontWeightData) {
    // UISettings fontSetting = UISettings(
    //     fontSize: currentFontSetting.fontSize,
    //     fontWeightData: fontWeightData,
    //     lineHeight: currentFontSetting.lineHeight);
    UISettings fontsettings =
        currentFontSetting.copyWith(fontWeightData: fontWeightData);
    _fontSettingSubject.add(fontsettings);
  }

  Future<List<FontData>> loadAllFonts() async {
    if (_fontData == null) {
      _fontData = await api.loadAllFonts();
    }
    //print("no data");
    return _fontData;
  }

  FontData getRandomFontData() {
    if (_fontData == null) return null;

    Random random = Random();
    int maxlength = _fontData.length - 1;
    int newRandom = random.nextInt(maxlength);

    return _currentFontData = _fontData[newRandom];
  }

  Future<ByteData> fetchFont(String url) async {
    final response = await http.get(
        //  'http://fonts.gstatic.com/s/actor/v9/wEOzEBbCkc5cO3ekXygtUMIO.ttf');
        url);

    if (response.statusCode == 200) {
      return ByteData.view(response.bodyBytes.buffer);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load font');
    }
  }

  //https://stackoverflow.com/questions/56270211/how-to-build-a-dropdown-in-flutter-from-a-future-list
  // Future<ByteData> fontListDropdown(FontFileData fontFileData) async{

  //   List myFontData =

  //     final response = await http.get(fontFileData.)
  //     return ByteData.view(buffer)
  // }

  // Future getFontInfo(FontData fontData)async{
  //   final response = await http.get(
  //       //  'http://fonts.gstatic.com/s/actor/v9/wEOzEBbCkc5cO3ekXygtUMIO.ttf');
  //       fontData.family);

  //   if (response.statusCode == 200) {
  //     return ByteData.view(response.bodyBytes.buffer);
  //   } else {
  //     // If that call was not successful, throw an error.
  //     throw Exception('Failed to load font');
  //   }
  // }

  Future loadFont(String family, String url) async {
    var fontLoader = FontLoader(family);
    fontLoader.addFont(fetchFont(url));
    await fontLoader.load();
  }
}
